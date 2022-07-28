{% snapshot DIM_PRODUCT %}

{{
    config(
        target_schema= 'DW',
        unique_key= 'ID',
        strategy='timestamp',
        updated_at='UPDATED_AT'
      )
}}
select {{ dbt_utils.surrogate_key(['Id','UPDATED_AT']) }} as product_key,ProductName,Price,IsActive,CategoryName,Id,UPDATED_AT
from STAGE.PRODUCTS
{% endsnapshot %}
