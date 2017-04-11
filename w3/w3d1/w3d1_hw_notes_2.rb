# SQL Lesson 6: Multi-table queries with JOINs #

# Database normalization
# => minimizes duplicate data in any single table
# => allows for data in the database to grow independently of each other
#   -queries get slightly more complex

# Multi-table queries with JOINs
# => need to have a primary key that identifies that entity uniquely across the database.
#    - auto-incrementing integer is common primary key type

# INNER JOIN - matches rows from the first table and the second table which have the same key
# => ON constraint - the defined 'same' key used to join
# =>  creates a result row with the combined columns from both tables.

# Find the domestic and international sales for each movie
SELECT title, domestic_sales, international_sales
FROM movies
  JOIN boxoffice
    ON movies.id = boxoffice.movie_id;
# Show the sales numbers for each movie that did better internationally
SELECT title, domestic_sales, international_sales
FROM movies
  JOIN boxoffice
    ON movies.id = boxoffice.movie_id
WHERE international_sales > domestic_sales;
# List all the movies by their ratings in descending order
SELECT title, rating
FROM movies
  JOIN boxoffice
    ON movies.id = boxoffice.movie_id
ORDER BY rating DESC;


# SQL Lesson 7: OUTER JOINs #

# LEFT JOIN, RIGHT JOIN or FULL JOIN
# => used for tables with asymmetric data
#    - ensures that the data you need is not left out of the results
SELECT column, another_column, …
FROM mytable
INNER/LEFT/RIGHT/FULL JOIN another_table
    ON mytable.id = another_table.matching_id
WHERE condition(s)
ORDER BY column, … ASC/DESC
LIMIT num_limit OFFSET num_offset;

# LEFT JOIN
# => includes rows from A regardless of whether a matching row is found in B
# RIGHT JOIN
# => includes rows from b regardless of whether a matching row is found in A
# FULL JOIN
# => rows from both tables are kept, regardless of whether a matching row exists in the other table.

# Find the list of all buildings that have employees
SELECT DISTINCT building FROM employees;
# Find the list of all buildings and their capacity
SELECT * FROM buildings;
# List all buildings and the distinct employee roles in each building (including empty buildings)
SELECT DISTINCT building_name, role
FROM buildings
  LEFT JOIN employees
    ON building_name = building;


# SQL Lesson 8: A short note on NULLs #
