with source as (
    /* The raw customer data contains duplicates and null IDs. 
    We use ROW_NUMBER to identify the most recent record for each customer.
    */
    select 
        *,
        row_number() over (
            partition by CUSTOMER_KEY 
            order by _FIVETRAN_SYNCED desc
        ) as row_num
    from {{ source('retail_raw', 'REF_CUSTOMER_LOOKUP') }}
    where CUSTOMER_KEY is not null -- Fixes the 'not_null' test failure
),

deduplicated as (
    /* Only the first row per CUSTOMER_KEY is kept, ensuring our unique constraint is met.
    */
    select *
    from source
    where row_num = 1 
)

select
    CUSTOMER_KEY as customer_id,
    PREFIX as name_prefix,
    FIRST_NAME as first_name,
    LAST_NAME as last_name,
    cast(BIRTH_DATE as date) as birth_date,
    MARITAL_STATUS as marital_status,
    GENDER as gender,
    EMAIL_ADDRESS as email_address,
    cast(ANNUAL_INCOME as numeric(12,2)) as annual_income,
    TOTAL_CHILDREN as total_children,
    EDUCATION_LEVEL as education_level,
    OCCUPATION as occupation,     
    case 
        when HOME_OWNER = 'Y' then true 
        else false 
    end as is_homeowner

from deduplicated