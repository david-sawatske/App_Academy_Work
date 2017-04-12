## Video 1 ##

# sqlite_orm_intro #

# Object Relational Mapping (ORM) - interact with DB in language of App
# when we queary the DB, we get a nested array, with arrays of each row of the DB
# [[1, "All My Sons, 1947"], ...]

# the create and update methods can be used to edit DB, using Ruby.
# this can be done on any instance that has been initialize in the PlayDBConnection class

require 'sqlite3'
require 'singleton'

class PlayDBConnection < SQLite3::Database # inherits SQLite3 Database class
  include Singleton

  def initialize
    super('plays.db')
    self.type_translation = true # makes sure all data past in, retains type
    self.results_as_hash = true  # returns hash which is easier to work with that
  end                            # the array the db returns. Key = column id & val = the data in the column
end

class Play
  attr_accessor :title, :year, :playwright_id

  def self.all # shows all entries in DB
    data = PlayDBConnection.instance.execute("SELECT * FROM plays") # we want to grab the DB, execute enheritied from Database
    data.map { |datum| Play.new(datum) } # turns the data array into a hash
  end

  def initialize(options) # pass in options hash
    @id = options['id'] # opitons id will either be defined coming from DB or nil when created with new user entry
    @title = options['title']
    @year = options['year']
    @playwright_id = options['playwright_id']
  end

  def create
    raise "#{self} already in database" if @id  # @..  below are bind args for execute
    PlayDBConnection.instance.execute(<<-SQL, @title, @year, @playwright_id)  -- SQL queary to add to DB using <<- Here Doc
      INSERT INTO
        plays (title, year, playwright_id)
      VALUES
        (?, ?, ?) -- accessing the bind arguments, used to prevent SQL injection attack. 'sanitize inputs'
    SQL
    @id = PlayDBConnection.instance.last_insert_row_id # this saves the prev nil id value for the user addition
  end

  def update
    raise "#{self} not in database" unless @id
    PlayDBConnection.instance.execute(<<-SQL, @title, @year, @playwright_id, @id) -- SQL queary to add to DB using <<- Here Doc
      UPDATE -- SQL queary. need attr_accessor
        plays
      SET -- SQL queary
        title = ?, year = ?, playwright_id = ? -- what we want to edit using sanitize inputs
      WHERE
        id = ?
    SQL
  end
end

class Playwright
  attr_accessor :name, :birth_year
  attr_reader :id

  def self.all
    data = PlayDBConnection.instance.execute("SELECT * FROM playwrights")
    data.map { |datum| Playwright.new(datum) }
  end

  def self.find_by_name(name)
    person = PlayDBConnection.instance.execute(<<-SQL, name)
      SELECT
        *
      FROM
        playwrights
      WHERE
        name = ?
    SQL
    return nil unless person.length > 0 # person is stored in an array!

    Playwright.new(person.first)
  end

class Playwright
  def initialize(options)
    @id = options['id']
    @name = options['name']
    @birth_year = options['birth_year']
  end

  def create
    raise "#{self} already in database" if @id
    PlayDBConnection.instance.execute(<<-SQL, @name, @birth_year)
      INSERT INTO
        playwrights (name, birth_year)
      VALUES
        (?, ?)
    SQL
    @id = PlayDBConnection.instance.last_insert_row_id
  end

  def update
    raise "#{self} not in database" unless @id
    PlayDBConnection.instance.execute(<<-SQL, @name, @birth_year, @id)
      UPDATE
        playwrights
      SET
        name = ?, birth_year = ?
      WHERE
        id = ?
    SQL
  end

  def get_plays
    plays = PlayDBConnection.instance.execute(<<-SQL, @id)
      SELECT
        *
      FROM
        plays
      WHERE
        playwright_id = ?
    SQL

    plays.map { |play| Play.new(play) }
  end
