with source as (
    select * from {{ source('retail_raw', 'REF_PRODUCT_LOOKUP') }}
)
select
    PRODUCT_KEY as product_id,
    PRODUCT_SUBCATEGORY_KEY as subcategory_id,
    PRODUCT_SKU as product_sku,
    PRODUCT_NAME as product_name,
    MODEL_NAME as model_name,
    PRODUCT_DESCRIPTION as product_description,
    PRODUCT_COLOR as product_color,
    PRODUCT_SIZE as product_size,
    PRODUCT_STYLE as product_style,
    cast(PRODUCT_COST as numeric(12,2)) as product_cost,
    cast(PRODUCT_PRICE as numeric(12,2)) as product_price
from source