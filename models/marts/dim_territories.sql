with territories as (
    select * from {{ ref('stg_retail_raw__territories') }}
)

select
    territory_id,
    region,
    country,
    continent
from territories