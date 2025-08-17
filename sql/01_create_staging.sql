CREATE TABLE IF NOT EXISTS public.stg_customer_data (
    customer_id             VARCHAR(50),
    purchase_date           TEXT,            
    product_category        TEXT,
    product_price           TEXT,            
    quantity                TEXT,             
    total_purchase_amount   TEXT,           
    payment_method          TEXT,
    customer_age            TEXT,        
    is_returned             TEXT,         
    customer_name           TEXT,
    age                     TEXT,         
    gender                  TEXT,
    churn                   TEXT             
);