with customers as (
    SELECT * from {{ ref('stg_retail_raw__customers')}}
)
select
    -- Primary Key
    customer_id,

    -- Customer Profile
    name_prefix,
    first_name,
    last_name,
    -- Concatenating names is a standard 'Marts' transformation for BI ease
    first_name || ' ' || last_name as full_name,
    
    -- Demographics
    birth_date,
    marital_status,
    gender,
    email_address,
    annual_income,
    total_children,
    education_level,
    occupation,
    is_homeowner

from customers