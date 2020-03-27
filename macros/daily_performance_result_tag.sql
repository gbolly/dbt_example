{% macro daily_performance_result_tag(impressions, clicks, spend) %}
case
    when clicks >= 100
        then 'high clicks'
    when (spend / clicks) <= 1.00 and impressions > 1000
        then 'well optimized'
    when (spend / clicks) > 3.00 and impressions > 100
        then 'unoptimized'
    else
        'normal'
    end::character varying(16) as daily_performance_result_tag
{% endmacro %}