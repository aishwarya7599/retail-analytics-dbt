with source as (
    select * from {{ source('retail_raw', 'REF_PRODUCT_CATEGORIES_LOOKUP') }}
)
select
    PRODUCT_CATEGORY_KEY as category_id,
    CATEGORY_NAME as category_name
from source