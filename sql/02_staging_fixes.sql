ALTER TABLE public.stg_customer_data
  ALTER COLUMN is_returned TYPE TEXT USING is_returned::text;

ALTER TABLE public.stg_customer_data
  ALTER COLUMN churn TYPE TEXT USING churn::text;
