with source as (
    select * from {{ source('retail_raw', 'REF_TERRITORY_LOOKUP') }}
)
select
    SALES_TERRITORY_KEY as territory_id,
    REGION as region,
    COUNTRY as country,
    CONTINENT as continent
from source