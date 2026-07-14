select
  id,
  max(weight)
from
  `Player`;

-- Aggregating the table in different groups
select
  country_id,
  count(*),
  `Country`.name
from
  `Match`
  join `Country` on `Country`.id = `Match`.country_id
group by
  country_id;

-- Arithmetic
select
  min(ROUND(weight * 0.45, 1)) as min_weight,
  max(round(weight * 0.45, 1)) as max_weight,
  round(avg(weight * 0.45), 1) as avg_weight
from
  `Player`;

-- BMI
-- height in meters, height in meters squared, weight in kilograms
with tmp as (
  select
    height / 100 as height_m,
    power(height / 100, 2) as height_m2,
    weight * 0.45 as weight_kg
  from
    `Player`
)
select
  weight_kg / height_m2 as bmi
from
  tmp;

-- JOINS
select
  `League`.name,
  coalesce(`Country`.name, 'Unknown Country') as country_name
from
  `League`
  LEFT JOIN `Country` ON `Country`.id = `League`.country_id;

-- variance
with avg_weight_table as (
  select
    avg(weight) as avg_weight
  from
    `Player`
)
SELECT
  AVG(POWER(weight - avg_weight_table.avg_weight, 2)) AS var_weight
FROM
  Player,
  avg_weight_table;

-- How to use CTE
with tmp as (
  select
    avg(weight) as avg_weight
  from
    `Player`
)
select
  avg(power(weight - tmp.avg_weight, 2)) as var_weight
from
  `Player`,
  tmp;
