




select count(*)
from (
    select date as id from "dbryan"."public"."fact_daily_performance"
) as child
left join (
    select date as id from "dbryan"."public"."dim_date"
) as parent on parent.id = child.id
where child.id is not null
  and parent.id is null

