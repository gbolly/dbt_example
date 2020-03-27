
  
  create view "dbryan"."public"."fact_daily_performance__dbt_tmp" as (
    select
    a.*,
    
case
    when clicks >= 100
        then 'high clicks'
    when (spend / clicks) <= 1.00 and impressions > 1000
        then 'well optimized'
    when (spend / clicks) > 3.00 and impressions > 100
        then 'unoptimized'
    else
        'normal'
    end as daily_performance_result_tag

from
    (
    select
        d.date,
        d.business_day,
        ad.impressions,
        ad.clicks,
        ad.spend::numeric(7,0) as spend,
        round(ad.spend::numeric / ad.impressions::numeric, 2) as cost_per_impression,
        round(ad.spend::numeric / ad.clicks::numeric, 2) as cost_per_click, 
        round(ad.clicks::numeric / ad.impressions::numeric, 4) as click_through_rate
    from 
        "dbryan"."public"."dim_date" d
        inner join "dbryan"."public"."ad_account_metrics" ad
            on ad.date = d.date
    where
        d.date >= '2020-03-03'
    ) a
order by 
    a.date
  );
