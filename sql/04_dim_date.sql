CREATE OR REPLACE VIEW analytics.dim_date AS
WITH bounds AS (
	SELECT MIN(purchase_date) AS start_date,
		   MAX(purchase_date) AS end_date
	FROM analytics.vw_stg_normalized
)

SELECT
	d::date	AS date_key,
	EXTRACT(YEAR FROM d)::int AS year,
	EXTRACT(QUARTER FROM d)::int AS quarter,
	EXTRACT(MONTH FROM d)::int AS month,
	TO_CHAR(d, 'Mon') AS month_short,
	EXTRACT(DAY FROM d)	AS day,
	TO_CHAR(d, 'Dy') AS weekday_short,
	EXTRACT(ISODOW FROM d)::int AS weekday_iso,
	(EXTRACT(ISODOW FROM d)::int IN (6, 7)) AS is_weekend
FROM bounds b,
	 generate_series(b.start_date, b.end_date, interval '1 day') AS g(d);
	