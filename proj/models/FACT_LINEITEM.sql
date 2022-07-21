  {{ config ( enabled = true, materialized='incremental', schema='DW') }}

with ord as
(
    select *
    from {{ source('stage', 'ORDERS') }}
),
ITEM as 
(
select *
from {{ source('stage', 'LINEITEM') }}
),
DIMPROD AS
(
    SELECT PRODUCT_KEY
    , PRODUCTNAME
    , PRICE
    , ISACTIVE
    , CATEGORYNAME
    , ID,DBT_SCD_ID
    , DBT_UPDATED_AT
    , DBT_VALID_FROM
    , ifnull(DBT_VALID_TO,'9999-01-01') as DBT_VALID_TO
    FROM {{ source('dw', 'Dim_Product') }}
)
select ord.ORDERDATE
    , ord.ORDERNUMBER
    , DIMPROD.PRODUCT_KEY as PRODUCT_KEY
    , ITEM.QUANTITY
    , ITEM.QUANTITY * DIMPROD.PRICE AS AMOUNT
from ord
left join ITEM on ord.ID = ITEM.orderid
left join DIMPROD on ITEM.PRODUCTID = DIMPROD.ID AND ORD.ORDERDATE >= DIMPROD.DBT_VALID_FROM AND  ORD.ORDERDATE < DIMPROD.DBT_VALID_TO 

{% if is_incremental() %}
  where ORDERDATE > (select max(ORDERDATE) from {{ this }})
{% endif %}





