CREATE OR REPLACE VIEW analytics.fact_sales AS
WITH BASE AS (
	SELECT
		customer_id,
		purchase_date,
		product_category,
		product_price,
		quantity,
		sales_amount,
		payment_method_clean,
		is_returned_bool,
		total_mismatch_flag
	FROM analytics.vw_stg_normalized
),

dedup AS (
	SELECT
		*,
		ROW_NUMBER() OVER (
			PARTITION BY customer_id, purchase_date, product_category, product_price, quantity, payment_method_clean ORDER BY customer_id
		) AS rn
	FROM base
)
SELECT
	md5(CONCAT_WS('|',
		customer_id,
		purchase_date::text,
		COALESCE(product_category, ''),
		product_price::text,
		quantity::text,
		COALESCE(payment_method_clean, ''),
		rn::text
	)) AS sales_id,
	purchase_date AS date_key,
	customer_id,
	product_category,
	product_price,
	quantity,
	sales_amount,
	payment_method_clean AS payment_method,
	is_returned_bool AS is_returned,
	total_mismatch_flag
FROM dedup
WHERE rn = 1;