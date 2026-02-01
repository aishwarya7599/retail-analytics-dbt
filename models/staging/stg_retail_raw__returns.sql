with source as (
    select * from {{ source('retail_raw', 'OPS_RETURNS_DATA') }}
)
select
    {{ dbt_utils.generate_surrogate_key([
        'RETURN_DATE', 
        'TERRITORY_KEY', 
        'PRODUCT_KEY'
    ]) }} as return_id,
    cast(RETURN_DATE as date) as return_date,
    TERRITORY_KEY as territory_id,
    PRODUCT_KEY as product_id,
    cast(RETURN_QUANTITY as integer) as return_quantity
from source