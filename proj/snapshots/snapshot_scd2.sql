  {% snapshot Dim_Product %}

{{
    config(
      target_database= 'DEMO',
      target_schema= 'DW',
      unique_key= 'ID',
      strategy= 'check',
       check_cols= ['Price']
       )
}}
select {{ dbt_utils.surrogate_key(['Id','Price']) }} as product_key,ProductName,Price,IsActive,CategoryName,Id
from DEMO.STAGE.PRODUCTS
{% endsnapshot %}
