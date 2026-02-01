with source as (
    select * from {{ source('retail_raw', 'OPS_RETURNS_DATA') }}
)

select
    {{ dbt_utils.generate_surrogate_key([
        'PRODUCT_KEY', 
        'RETURN_DATE', 
        'TERRITORY_KEY'
    ]) }} as return_id,
    -- Explicit date format parsing
    try_to_date(RETURN_DATE, 'dd/mm/yyyy') as return_date,
    TERRITORY_KEY as territory_id,
    PRODUCT_KEY as product_id,
    cast(RETURN_QUANTITY as integer) as return_quantity
from source