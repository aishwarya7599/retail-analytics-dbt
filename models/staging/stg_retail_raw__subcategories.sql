with source as (
    select * from {{ source('retail_raw', 'REF_PRODUCT_SUBCATEGORIES_LOOKUP') }}
)
select
    PRODUCT_SUBCATEGORY_KEY as subcategory_id,
    SUBCATEGORY_NAME as subcategory_name,
    PRODUCT_CATEGORY_KEY as category_id
from source