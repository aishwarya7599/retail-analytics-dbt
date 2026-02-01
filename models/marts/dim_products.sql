with products as (
    select * from {{ ref('stg_retail_raw__products') }}
),
subcategories as (
    select * from {{ ref('stg_retail_raw__subcategories') }}
),
categories as (
    select * from {{ ref('stg_retail_raw__categories') }}
)

select
    -- Keys
    p.product_id,
    
    -- Product Attributes
    p.product_sku,
    p.product_name,
    p.model_name,
    p.product_description,
    p.product_color,
    p.product_size,
    p.product_style,
    
    -- Hierarchy Info (The Joins)
    s.subcategory_name,
    c.category_name,
    
    -- Financials
    p.product_cost,
    p.product_price,
    
    -- Derived Metrics (Portfolio Value-Add)
    (p.product_price - p.product_cost) as profit_margin,
    case 
        when p.product_price > 100 then 'Premium' 
        else 'Standard' 
    end as price_tier

from products p
left join subcategories s on p.subcategory_id = s.subcategory_id
left join categories c on s.category_id = c.category_id