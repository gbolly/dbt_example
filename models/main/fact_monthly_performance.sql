select
    date_trunc('month', f.date)::date as month,
    sum(impressions)::integer as impressions,
    sum(clicks)::integer as clicks,
    sum(spend)::numeric as spend,
    round(avg(spend)::numeric, 2)::numeric as average_daily_spend
from
    {{ ref('fact_daily_performance') }} f
group by 
    date_trunc('month', f.date)::date
order by
    date_trunc('month', f.date)::date
