with sales as (
    select * from {{ ref('stg_retail_raw__sales') }}
),
products as (
    select * from {{ ref('dim_products') }}
)

select
    -- Primary Key (Surrogate Key)
    {{ dbt_utils.generate_surrogate_key(['s.order_id', 's.order_line_item']) }} as sales_key,

    -- Transactional Keys
    s.order_id,
    s.order_line_item,
    
    -- Foreign Keys (Dimension Links)
    s.order_date,
    s.product_id,
    s.customer_id,
    s.territory_id,
    
    -- Measures
    s.order_quantity,
    p.product_price,
    p.product_cost,
    
    -- Calculated Financial Metrics
    cast(s.order_quantity * p.product_price as numeric(12,2)) as revenue,
    cast(s.order_quantity * p.product_cost as numeric(12,2)) as cogs,
    cast((s.order_quantity * p.product_price) - (s.order_quantity * p.product_cost) as numeric(12,2)) as profit

from sales s
left join products p on s.product_id = p.product_id