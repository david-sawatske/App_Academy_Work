require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    @columns ||= DBConnection.execute2(<<-SQL)
      SELECT
        *
      FROM
        #{self.table_name}
    SQL

    @columns.first.map! { |str| str.to_sym }
  end

  def self.finalize!
    self.columns.each do |column_name|
      define_method(column_name) do
        self.attributes[column_name]
      end

      define_method("#{column_name}=") do |value|
        self.attributes[column_name] = value
      end
    end
  end

  def self.table_name=(table_name)
    @table_name = table_name
  end

  def self.table_name
    @table_name || self.name.tableize
  end

  def self.all
    unparsed = DBConnection.execute(<<-SQL)
      SELECT
        #{table_name}.*
      FROM
        #{table_name}
    SQL

    parse_all(unparsed)
  end

  def self.parse_all(results)
    results.map { |result| self.new(result) }
  end

  def self.find(id)
    unparsed = DBConnection.execute(<<-SQL, id)
      SELECT
        #{table_name}.*
      FROM
        #{table_name}
      WHERE
        #{table_name}.id = ?
    SQL

    parse_all(unparsed).first
  end

  def initialize(params = {})
    params.each do |attr_name, value|
      attr_name = attr_name.to_sym

      if self.class.columns.include?(attr_name)
        self.send("#{attr_name}=", value)
      else
        raise "unknown attribute '#{attr_name}'"
      end
    end
  end

  def attributes
    @attributes ||= {}
  end

  def attribute_values
    self.class.columns.map { |key| self.send(key) }
  end

  def insert
    attr_vals = attribute_values.drop(1)
    cols = self.class.columns.drop(1)
    col_names = cols.join(', ')
    question_marks = ['?'] * cols.length
    question_marks = question_marks.join(', ')
    DBConnection.execute(<<-SQL, *attr_vals)
      INSERT INTO
        #{self.class.table_name} (#{col_names})
      VALUES
        (#{question_marks})
    SQL

    self.id = DBConnection.last_insert_row_id
  end

  def update
    DBConnection.execute(<<-SQL, *attribute_values, id)
      UPDATE
        #{self.class.table_name}
      SET
        #{self.class.columns.map { |col_key| "#{col_key} = ?" }.join(", ")}
      WHERE
        #{self.class.table_name}.id = ?
    SQL
  end

  def save
    self.id.nil? ? insert : update
  end
end
