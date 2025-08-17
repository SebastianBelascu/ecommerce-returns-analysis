CREATE OR REPLACE VIEW analytics.dim_customer AS
WITH base AS (
  SELECT * FROM analytics.vw_stg_normalized WHERE customer_id IS NOT NULL
),
latest AS (
  SELECT DISTINCT ON (customer_id)
         customer_id, customer_name, gender_clean, age_coalesced, purchase_date
  FROM base
  ORDER BY customer_id, purchase_date DESC
),
churn_agg AS (
  SELECT customer_id, BOOL_OR(churn_bool) AS churn
  FROM base
  GROUP BY customer_id
)
SELECT
  l.customer_id,
  l.customer_name,
  l.gender_clean,
  l.age_coalesced AS age,
  CASE
    WHEN l.age_coalesced BETWEEN 18 AND 24 THEN '18-24'
    WHEN l.age_coalesced BETWEEN 25 AND 34 THEN '25-34'
    WHEN l.age_coalesced BETWEEN 35 AND 44 THEN '35-44'
    WHEN l.age_coalesced BETWEEN 45 AND 54 THEN '45-54'
    WHEN l.age_coalesced BETWEEN 55 AND 64 THEN '55-64'
    WHEN l.age_coalesced >= 65 THEN '65+'
    ELSE 'Unknown'
  END AS age_band,
  c.churn
FROM latest l
LEFT JOIN churn_agg c USING (customer_id);
