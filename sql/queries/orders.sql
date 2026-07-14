-- simple sum of all the order prices
SELECT
  id,
  amount,
  customer_id,
  round(amount / sum(amount) over () * 100, 2) || '%' as percentage_over_revenue
from
  orders;

-- partition
SELECT
  customer_id,
  SUM(amount)
FROM
  orders
GROUP BY
  customer_id;

-- first try on partition by
select
  id,
  customer_id,
  amount,
  round(
    amount / sum(amount) over (partition by customer_id) * 100,
    2
  ) || '%' as percentage_over_their_total_purchase
from
  orders;

--- cumulative sum
select
  orders.id,
  ordered_at,
  amount,
  sum(amount) over (
    partition by customer_id
    order by
      ordered_at
  ),
  first_name,
  last_name
from
  orders
  join customers on orders.customer_id = customers.id;

-- sort and rank
select
  *,
  rank() over (
    partition by customer_id
    order by
      ordered_at
  ) as rank_of_their_purchase
from
  orders;
