 ## More on Querying ##

 # Dynamic Finders #

# use ::find and ::find_byfind the single object that matches some criteria
# => ::find accepts a single argument: the id of the record you're looking for
# => ::find_by accepts an options hash to specify as many criteria as necessary

Application.find_by(email_address: "ned@appacademy.io")
# returns the record whose email_address matches "ned@appacademy.io"

Application.find(4)
# returns the record with id 4


# To retrieve records from the database in a specific order, you can use the order method.
Client.order("orders_count ASC, created_at DESC").all


# You can apply GROUP BY and HAVING clauses.
UserPost
  .joins(:likes)
  .group("posts.id")
  .having("COUNT(*) > 5")


# Aggregations - You can perform all the typical aggregations:
Client.count
Orders.sum(:total_price)
Orders.average(:total_price)
Orders.minimum(:total_price)
Orders.maximum(:total_price)


# Be flexible; don't expect too much from ActiveRecord. Even if you have to
# drop to SQL for a few monster queries, ActiveRecord has saved you a lot of
# work on all the easy queries.

# The main problem with trying to take ActiveRecord too far is that it can become
# difficult to understand what kind of query it will generate or how it will
# do what you ask.


# Finding by SQL #

# The find_by_sql method will return an array of objects.
Case.find_by_sql(<<-SQL)
  SELECT
    cases.*
  FROM
    cases
  JOIN (
    -- the five lawyers with the most clients
    SELECT
      lawyers.*
    FROM
      lawyers
    LEFT OUTER JOIN
      clients ON lawyers.id = clients.lawyer_id
    GROUP BY
      lawyers.id
    SORT BY
      COUNT(clients.*)
    LIMIT 5
  ) ON ((cases.prosecutor_id = lawyer.id)
         OR (cases.defender_id = lawyer.id))
SQL
