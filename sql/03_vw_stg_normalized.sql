CREATE OR REPLACE VIEW analytics.vw_stg_normalized AS
SELECT
	trim(customer_id)		AS customer_id,
	purchase_date::date 	AS purchase_date,
	NULLIF(trim(product_category), '')		AS product_category,
	product_price::numeric(10, 2)			AS product_price,
	quantity::int							AS quantity,
	total_purchase_amount::numeric(10, 2)	AS total_purchase_amount,

	CASE
		WHEN lower(trim(payment_method)) IN ('creditcard', 'credit card', 'cc') THEN 'Credit Card'
		WHEN lower(trim(payment_method)) IN ('debitcard', 'debit card', 'dc') THEN 'Debit Card'
		WHEN lower(trim(payment_method)) LIKE 'paypal%' THEN 'PayPal'
		WHEN lower(trim(payment_method)) LIKE 'cash%'	 THEN 'Cash'
		ELSE initcap(trim(payment_method))
	END AS payment_method_clean,

	CASE 
		WHEN COALESCE(age, customer_age) BETWEEN 10 AND 100 THEN COALESCE(age, customer_age)
		ELSE NULL
	END::int AS age_coalesced,

	trim(customer_name) AS customer_name,

	CASE
		WHEN lower(trim(gender)) IN ('m', 'male') THEN 'Male'
		WHEN lower(trim(gender)) IN ('f', 'female') THEN 'Female'
		ELSE 'Unknown'
	END AS gender_clean,

	CASE
		WHEN lower(trim(is_returned)) IN ('1', '1.0', 'true', 't', 'yes', 'y') THEN TRUE
		WHEN lower(trim(is_returned)) IN ('0', '0.0', 'false', 'f', 'no', 'n') THEN FALSE
		ELSE NULL
	END AS is_returned_bool,	
	
	CASE
		WHEN lower(trim(churn)) IN ('1', '1.0', 'true', 't', 'yes', 'y') THEN TRUE 
		WHEN lower(trim(churn)) IN ('0', '0.0', 'false', 'f', 'no', 'n') THEN FALSE
		ELSE NULL
	END AS churn_bool,

	(product_price::numeric(10, 2) * quantity::numeric) AS expected_total,
	COALESCE(total_purchase_amount::numeric(10, 2), product_price::numeric(10, 2) * quantity::numeric) AS sales_amount,

	CASE
		WHEN total_purchase_amount IS NULL THEN FALSE
		ELSE ABS(total_purchase_amount::numeric - (product_price::numeric * quantity::numeric)) > 0.01
	END AS total_mismatch_flag
FROM public.stg_customer_data;