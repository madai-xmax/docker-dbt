  {{ config ( enabled = false, materialized='table', schema='DW') }}
with cte as
(
  select * 
  from {{ source('stage', 'ORDERS') }}
  left join {{ source('stage', 'LINEITEM') }} using (ID,Orderid)
)
select * from cte 

--  select OrderDate as Datakey,ORDERNUMBER as ordernum,Quantity
  --from {{ source('stage', 'ORDERS') }}
  --left join {{ source('stage', 'LINEITEM') }} using (ID,ORDERID)