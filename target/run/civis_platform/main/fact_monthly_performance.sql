
  
  create view "dbryan"."public"."fact_monthly_performance__dbt_tmp" as (
    select
    date_trunc('month', f.date)::date as month,
    sum(impressions) as impressions,
    sum(clicks) as clicks,
    sum(spend) as spend,
    round(avg(spend)::numeric, 2) as average_daily_spend
from
    "dbryan"."public"."fact_daily_performance" f
group by 
    date_trunc('month', f.date)::date
order by
    date_trunc('month', f.date)::date
  );
