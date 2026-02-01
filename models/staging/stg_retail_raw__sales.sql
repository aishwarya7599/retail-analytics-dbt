with source_2020 as (
    select * from {{ source('retail_raw', 'SALES_DATA_2020') }}
),
source_2021 as (
    select * from {{ source('retail_raw', 'SALES_DATA_2021') }}
),
source_2022 as (
    select * from {{ source('retail_raw', 'SALES_DATA_2022') }}
),
unioned as (
    select * from source_2020
    union all
    select * from source_2021
    union all
    select * from source_2022
)
select
    ORDER_NUMBER as order_id,
    cast(ORDER_DATE as date) as order_date,
    cast(STOCK_DATE as date) as stock_date,
    PRODUCT_KEY as product_id,
    CUSTOMER_KEY as customer_id,
    TERRITORY_KEY as territory_id,
    ORDER_LINE_ITEM as order_line_item,
    cast(ORDER_QUANTITY as integer) as order_quantity
from unioned