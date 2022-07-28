 
 {{ config ( enabled = false, materialized='table', schema='DW') }}
with demj as
(
  select * 
  from "STAGE"."LINEITEM"
)
select * from demj 
