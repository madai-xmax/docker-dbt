  {% snapshot Dim_Product %}

{{
    config(
      target_database= 'DEMO',
      target_schema= 'DW',
      unique_key= 'ID',
       strategy='timestamp',
       updated_at='UPDATED_AT'
       )
}}
select {{ dbt_utils.surrogate_key(['Id','Price']) }} as product_key,ProductName,Price,IsActive,CategoryName,Id,UPDATED_AT
from DEMO.STAGE.PRODUCTS
{% endsnapshot %}
