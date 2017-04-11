# == Schema Information
#
# Table name: countries
#
#  name        :string       not null, primary key
#  continent   :string
#  area        :integer
#  population  :integer
#  gdp         :integer

require_relative './sqlzoo.rb'

# BONUS QUESTIONS: These problems require knowledge of aggregate
# functions. Attempt them after completing section 05.

def highest_gdp
  # Which countries have a GDP greater than every country in Europe? (Give the
  # name only. Some countries may have NULL gdp values)
  execute(<<-SQL)
    SELECT
      countries.name
    FROM
      countries
    WHERE
      countries.gdp > (
        SELECT
          MAX(country2.gdp)
        FROM
          countries country2
        WHERE
          country2.continent = 'Europe'
      );
  SQL
end

def largest_in_continent
  # Find the largest country (by area) in each continent. Show the continent,
  # name, and area.
  execute(<<-SQL)
    SELECT
      country1.continent,
      country1.name,
      country1.area
    FROM
      countries country1
    WHERE
      country1.area = (
        SELECT
          MAX(country2.area)
        FROM
          countries country2
        WHERE
          country1.continent = country2.continent
      );
  SQL
end

def large_neighbors
  # Some countries have populations more than three times that of any of their
  # neighbors (in the same continent). Give the countries and continents.
  execute(<<-SQL)
    SELECT
      country1.name,
      country1.continent
    FROM
      countries country1
    WHERE
      country1.population > 3 * (
        SELECT
          MAX(country2.population)
        FROM
          countries country2
        WHERE
          country1.continent = country2.continent
          AND country1.name <> country2.name
      );
  SQL
end
