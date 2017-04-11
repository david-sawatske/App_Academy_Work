## Video 1 ##
# sqlite_intro #

# Relational database - unique primary key, info in columns and rows

# RDBMS - Relational Database Management System (ex SQLite, PostGres)
# => takes info from database and returns it

# SQLite is server-less
# => good when limited in the amount of info you can store (mobile phone/ tab)

# DDL Data Definition Language
# => describes structure of, and where tables are built
#    - create, drop tables

# DML Data Manipulation Language
# => add, edit, delete data in tables
#   - SELECT, INSERT, UPDATE, DELETE


## Video 2 ##

# sqlite3_build_database #

# created file import_db.sql

CREATE TABLE plays (
  id INTEGER PRIMARY KEY,  # knows what colum to search for primary key
  title TEXT NOT NULL,     # must have value
  year INTEGER NOT NULL,
  playwright_id INTEGER NOT NULL

  FOREIGN KEY (playwright_id) REFERENCES playwright(id) # to know what playwright_id
);                                                      # points to

CREATE TABLE playwrights (
  id INTEGER PRIMARY KEY,
  name TEXT NOT NULL,
  birth_year
);

# Start adding data - what first?
# because plays table references playwrights, we should do playwrights first

INSERT INTO
  playwrights (name, birth_year) # id is automatic
VALUES
  ('Arthur Miller', 1915),
  ('Eugene O''Neill', 1888);

INSERT INTO
  plays (title, year, playwright_id)
VALUES
  ('All My Sons', 1947, (SELECT id FROM playwrights WHERE name = 'Arthur Miller'))
#                        this quearys other table for playwright_id
  ('Long Day''s Journey into Night', 1956, (SELECT id FROM playwrights WHERE name = 'Eugene O''Neill'));


# Now we are ready to generate the db in the terminal

=> cat import_db.sql | sqlite3 plays.db
# concatinate  the output from import_db into sqlite3 in the file plays.db

# Now we enter the sqlite3 command shell terminal to access data
=> sqlite3 plays.db
sqlite3> .tables # shows what table are in that db
sqlite3> .schema # represents the sturcture of db
