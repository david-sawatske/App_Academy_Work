require 'sqlite3'
require 'singleton'

class QuestionsDatabase < SQLite3::Database
  include Singleton

  def initialize
    super('questions.db')
    self.type_translation = true
    self.results_as_hash = true
  end
end

class User
  attr_accessor :id, :fname, :lname
  def initialize(options)
    @id = options['id']
    @fname = options['fname']
    @lname = options['lname']
  end

  def self.find_by_id(id)
    data = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        users
      WHERE
        id = ?
    SQL

    User.new(data.first)
  end

  def self.find_by_name(fname, lname)
    data = QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
      SELECT
        *
      FROM
        users
      WHERE
        fname = ? AND lname = ?
    SQL

    User.new(data.first)
  end

  def authored_questions
    #use Question::find_by_user_id
    Question.find_by_user_id(@id)
  end

  def authored_replies
    Reply.find_by_user_id(@id)
  end

end

class Question
  attr_accessor :id, :title, :body, :user_id

  def initialize(options)
    @id = options['id']
    @title = options['title']
    @body = options['body']
    @user_id = options['user_id']
  end

  def self.find_by_user_id(user_id)
    data = QuestionsDatabase.instance.execute(<<-SQL, user_id)
    SELECT
      *
    FROM
      questions
    WHERE
      user_id = ?
    SQL

    data.map { |datum| Question.new(datum) }
  end

  def create
    raise "#{self} already in database" if @id
    QuestionsDatabase.instance.execute(<<-SQL, @title, @body, @user_id)
      INSERT INTO
        questions (title, body, user_id)
      VALUES
        (?, ?, ?)
    SQL

    @id = QuestionsDatabase.instance.last_insert_row_id
  end

  def author
    data = QuestionsDatabase.instance.execute(<<-SQL, @user_id)
    SELECT
      *
    FROM
      users
    WHERE
      id = ?
    SQL

    User.new(data.first)
  end

  def replies
    Reply.find_by_question_id(@id)
  end

end

class QuestionFollow
  # def self.followers_for_question_id(question_id)
  #   data = QuestionsDatabase.instance.execute(<<-SQL, question_id)
  #   SELECT
  #     users.*
  #   FROM
  #     questions
  #   JOIN
  #     question_follows ON questions.id = question_id
  #       JOIN
  #         users ON question_follows.user_id = users.id
  #   WHERE
  #     question_id = ?
  #   SQL
  #
  #   data
  # end

  def self.followers_for_question_id(question_id)
    users_data = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        users.*
      FROM
        users
      JOIN
        question_follows
      ON
        users.id = question_follows.user_id
      WHERE
        question_follows.question_id = question_id
    SQL

    users_data.map { |user_data| User.new(user_data) }
  end
end

class Reply < Question

  def initialize(options)
    super
    @question_id = options['question_id']
    @parent_reply_id = options['parent_reply_id']
  end

  def self.find_by_user_id(user_id)
    data = QuestionsDatabase.instance.execute(<<-SQL, user_id)
    SELECT
      *
    FROM
      replies
    WHERE
      user_id = ?
    SQL

    data.map { |datum| Reply.new(datum) }
  end

  def self.find_by_question_id(question_id)
    data = QuestionsDatabase.instance.execute(<<-SQL, question_id)
    SELECT
      *
    FROM
      replies
    WHERE
      question_id = ?
    SQL

    data.map { |datum| Reply.new(datum) }
  end

  def question
    data = QuestionsDatabase.instance.execute(<<-SQL, @question_id)
    SELECT
      *
    FROM
      questions
    WHERE
      id = ?
    SQL

    Question.new(data.first)
  end

  def parent_reply
    data = QuestionsDatabase.instance.execute(<<-SQL, @parent_reply_id)
    SELECT
      *
    FROM
      replies
    WHERE
      id = ?
    SQL

    Reply.new(data.first)
  end

  def child_replies
    data = QuestionsDatabase.instance.execute(<<-SQL, @id)
    SELECT
      *
    FROM
      replies
    WHERE
      parent_reply_id = ?
    SQL

    data.map { |reply| Reply.new(reply) }
  end

  def create
    raise "#{self} already in database" if @id
    QuestionsDatabase.instance.execute(<<-SQL, @title, @body, @user_id, @question_id, @parent_reply_id)
      INSERT INTO
        replies (title, body, user_id, question_id, parent_reply_id)
      VALUES
        (?, ?, ?, ?, ?)
    SQL

    @id = QuestionsDatabase.instance.last_insert_row_id
  end
end

class QuestionLikes

end
