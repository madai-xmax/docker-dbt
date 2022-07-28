 
 {{ config ( enabled = false, materialized='table', schema='DW') }}
with cte as
(
  select * 
  from {{ source('STAGE', 'ORDERS') }}
  left join {{ref('demo_to_ref')}} using (ID)
)
select * from cte 
where ID < '{{ var("values_id") }}'
