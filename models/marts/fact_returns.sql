with returns as (
    select * from {{ ref('stg_retail_raw__returns') }}
),
products as (
    select * from {{ ref('dim_products') }}
)

select
    -- Primary Key (Surrogate Key created in staging)
    r.return_id,
    
    -- Transactional Details
    r.return_date,
    r.product_id,
    r.territory_id,
    
    -- Measures
    r.return_quantity,
    
    -- Financial Impact Calculations
    -- Total value of returned products: $Quantity \times Price$
    cast(r.return_quantity * p.product_price as numeric(12,2)) as return_amount,
    
    -- Cost impact of returned products: $Quantity \times Cost$
    cast(r.return_quantity * p.product_cost as numeric(12,2)) as return_cost_impact

from returns r
left join products p on r.product_id = p.product_id