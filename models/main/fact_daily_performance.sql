select
    a.date::date as date,
    a.business_day::boolean as business_day,
    a.impressions::integer as impressions,
    a.clicks::integer as clicks,
    a.spend::numeric(7,0) as spend,
    a.cost_per_impression::numeric as cost_per_impression,
    a.cost_per_click::numeric as cost_per_click,
    a.click_through_rate::numeric as click_through_rate,
    {{ daily_performance_result_tag(impressions, clicks, spend) }}
from
    (
    select
        d.date,
        d.business_day,
        ad.impressions,
        ad.clicks,
        ad.spend,
        round(ad.spend::numeric / ad.impressions::numeric, 2) as cost_per_impression,
        round(ad.spend::numeric / ad.clicks::numeric, 2) as cost_per_click, 
        round(ad.clicks::numeric / ad.impressions::numeric, 4) as click_through_rate
    from 
        {{ ref('dim_date') }} d
        inner join {{ ref('ad_account_metrics') }} ad
            on ad.date = d.date
    where
        d.date >= '{{ var("start_date") }}'
    ) a
order by 
    a.date