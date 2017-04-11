## SQL ## https://sqlbolt.com/

# Relational Databasae - A relational database represents a collection
#                        of related (two-dimensional) tables

# SQL Lesson 1: SELECT queries 101 #

# SELECT statements (queries) - retrieve data from a SQL database

# The most basic query we could write would be one that selects for a couple
# columns (properties) of the table with all the rows (instances).
SELECT column, another_column, …
FROM mytable;
# The result of this query will be a two-dimensional set of rows and columns,
# effectively a copy of the table, but only with the columns that we requested.

# If we want to retrieve absolutely all the columns of data from a table,
# we can then use the asterisk (*)
SELECT *
FROM mytable;


# SQL Lesson 2: Queries with constraints #

# WHERE clause - filters certain results from being returned
SELECT column, another_column, …
FROM mytable
WHERE condition
    AND/OR another_condition
    AND/OR …

# complex clauses - makes the results more manageable to understand and allows the query to run faster

      Operator	                     Condition        	         SQL Example
=, !=, < <=, >, >=	|  Standard numerical operators	      |  col_name != 4
BETWEEN … AND …	    |  Number is within range (inclusive)	|  col_name BETWEEN 1.5 AND 10.5
NOT BETWEEN … AND …	|  Number is not within range (inc)	  |  col_name NOT BETWEEN 1.5 AND 10.5
IN (…)	            |  Number exists in a list	          |  col_name IN (2, 4, 6)
NOT IN (…)	        |  Number does not exists in a list	  |  col_name NOT IN (2, 4, 6)


# Find the movie with a row id of 6
SELECT id, title FROM movies
WHERE id = 6;
# Find the movies released in the  years between 2000 and 2010
SELECT title, year FROM movies
WHERE year BETWEEN 2000 AND 2010;
# Find the movies not released in the  years between 2000 and 2010
SELECT title, year FROM movies
WHERE year < 2000 OR year > 2010;
# Find the first 5 Pixar movies and their release year
SELECT title, year FROM movies
WHERE year <= 2003;


# SQL Lesson 3: Queries with constraints (Pt. 2) #
Operator	                     Condition        	            SQL Example
    = 	     | Case sensitive exact string comparison	   |  col_name = "abc"
!= or <>     | Exact string inequality comparison        |  col_name != "abcd"
  LIKE	     | Case insensitive exact string comparison  |  col_name LIKE "ABC"
NOT LIKE	   | Insensitive exact string inequality       |  col_name NOT LIKE "ABCD"
   %	       | String to match a sequence of zero or     |  col_name LIKE "%AT%" (matches "AT",
             | more characters.                                          "ATTIC", "BATS")
 IN (…)      | String exists in a list	                 |  col_name IN ("A", "B", "C")
NOT IN (…)   | String does not exist in a list	         |  col_name NOT IN ("D", "E", "F")

# Find all the Toy Story movies
SELECT title, director FROM movies
WHERE title LIKE "Toy Story%";
# Find all the movies directed by John Lasseter
SELECT title, director FROM movies
WHERE director LIKE "John Lasseter";
# Find all the movies (and director) not directed by John Lasseter
SELECT title, director FROM movies
WHERE director NOT LIKE "John Lasseter";
# Find all the WALL-* movies
SELECT title, director FROM movies
WHERE title LIKE "WALL%";

# => We should note that while most database implementations are quite efficient
#    when using these operators, full-text search is best left to dedicated
#    libraries like Apache Lucene or Sphinx.


# SQL Lesson 4: Filtering and sorting Query results #

# Even though the data in a database may be unique, the results of any
# particular query may not be
# => DISTINCT keyword - discards rows that have a duplicate column value

# Ordering results
# => most data in real databases are added in no particular column order
# => ORDER BY clause - sorts your results by a given column in ascending or descending order

SELECT column, another_column, …
FROM mytable
WHERE condition(s)
ORDER BY column ASC/DESC;

# Limiting results to a subset
# => LIMIT clause will reduce the number of rows to return
# => OFFSEt clause (optional) will specify where to begin counting the number rows fro

SELECT column, another_column, …
FROM mytable
WHERE condition(s)
ORDER BY column ASC/DESC
LIMIT num_limit OFFSET num_offset;


# List all directors of Pixar movies (alphabetically), without duplicates
SELECT DISTINCT director FROM movies
ORDER BY director ASC;
# List the last four Pixar movies released (ordered from most recent to least)
SELECT title, year FROM movies
ORDER BY year DESC
LIMIT 4;
# List the first five Pixar movies sorted alphabetically
SELECT title FROM movies
ORDER BY title ASC
LIMIT 5;
# List the next five Pixar movies sorted alphabetically
SELECT title FROM movies
ORDER BY title ASC
LIMIT 5 OFFSET 5;


# SQL Review: Simple SELECT Queries #
SELECT column, another_column, …
FROM mytable
WHERE condition(s)
ORDER BY column ASC/DESC
LIMIT num_limit OFFSET num_offset;


# List all the Canadian cities and their populations
SELECT city, population FROM north_american_cities
WHERE country = "Canada";
# Order all the cities in the United States by their latitude from north to south
SELECT city, latitude FROM north_american_cities
WHERE country = "United States"
ORDER BY latitude DESC;
# List all the cities west of Chicago, ordered from west to east
SELECT city, longitude FROM north_american_cities
WHERE longitude < -87.629798
ORDER BY longitude ASC;
# List the two largest cities in Mexico (by population)
SELECT city, population FROM north_american_cities
WHERE country LIKE "Mexico"
ORDER BY population DESC
LIMIT 2;
# List the 3rd and 4th most pop cities in the US
SELECT city, population FROM north_american_cities
WHERE country LIKE "United States"
ORDER BY population DESC
LIMIT 2 OFFSET 2;
