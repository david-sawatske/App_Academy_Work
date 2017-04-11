## SQLite3 ##

# SQL is a language, but there are many different implementations of SQL.
# => RDBMS (ex SQLite3 ostgres Oracle, MySQL, and SQLServer)

# SQLite3 #
# it is a very simple, serverless, public-domain implementation that is easy to set up
# => does not handle multiple simultaneous query requests very well
# => poor query planner to figure out how to execute your query in the best way

# Demo

# 1. Write a SQL source file to generate our data.
#    => writen in file create_tables.sql

CREATE TABLE departments (
  id INTEGER PRIMARY KEY,
  name VARCHAR(255) NOT NULL
);

# Notice that tables are always named lowercase and plural. This is a
# convention.
CREATE TABLE professors (
  # SQLite3 will automatically populate an integer primary key
  # (unless it is specifically provided). The conventional primary
  # key name is 'id'.
  id INTEGER PRIMARY KEY,
  # NOT NULL specifies that the column must be provided. This is a
  # useful check of the integrity of the data.
  first_name VARCHAR(255) NOT NULL,
  last_name VARCHAR(255) NOT NULL,
  department_id INTEGER NOT NULL,

  # Not strictly necessary, but informs the DB not to
  #  (1) create a professor with an invalid department_id,
  #  (2) delete a department (or change its id) if professors
  #      reference it.
  # Either event would leave the database in an invalid state, with a
  # foreign key that doesn't point to a valid record. Older versions
  # of SQLite3 may not enforce this, and will just ignore the foreign
  # key constraint.
  FOREIGN KEY (department_id) REFERENCES departments(id)
);

# In addition to creating tables, we can seed our database with some
# starting data.
INSERT INTO
  departments (name)
VALUES
  ('mathematics'), ('physics');

INSERT INTO
  professors (first_name, last_name, department_id)
VALUES
  ('Albert', 'Einstein', (SELECT id FROM departments WHERE name = 'physics')),
  ('Kurt', 'Godel', (SELECT id FROM departments WHERE name = 'mathematics'));


# 2. Then we can use SQLite3 to run the sql source, generating the tables.
  => ~/sql-demo$ cat create_tables.sql | sqlite3 school.db

# 3. Let's interactively use the SQLite3 client to create some data:
# adding russian lit department
=> ~/sql-demo$ sqlite3 school.db
    SQLite version 3.7.14.1 2012-10-04 19:37:12
    Enter ".help" for instructions
    Enter SQL statements terminated with a ";"
    sqlite> .tables         # lists existing tables
    departments  professors
    sqlite> .schema departments # shows schema
    CREATE TABLE departments (
      id INTEGER PRIMARY KEY,
      name VARCHAR(255)
    );
    sqlite> INSERT INTO departments ("name") VALUES ("russian literature");
    sqlite> SELECT * FROM departments;
    1|mathematics
    2|physics
    3|russian literature

  # also add a new professor:
    sqlite> INSERT INTO professors ("department_id", "first_name", "last_name") VALUES (3, "Vladimir", "Nabokov");


  # Some features that would have been nice if SQLite3 had:
  # => need to rebuild the whole table to drop columns
  # => SQLite3 is overly permissive; it lets you assign, for instance, strings
  #    to non-varchar columns



  # Heredocs #
  # Allows us to mix SQL into our Ruby code

  query = <<-SQL
  SELECT
    *
  FROM
    posts
  JOIN
    comments ON comments.post_id = posts.id
  SQL

  db.execute(query)
