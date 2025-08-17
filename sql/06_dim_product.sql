CREATE OR REPLACE VIEW analytics.dim_product AS
SELECT
	product_category,
	COUNT(*) AS rows_in_data,
	ROUND(AVG(product_price)::numeric, 2) AS avg_price_in_data
FROM analytics.vw_stg_normalized
WHERE product_category IS NOT NULL
GROUP BY product_category;