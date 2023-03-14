{% set my_query %}
    select cast({{dbt_utils.current_timestamp()}} as date)
{% endset %}

{% if execute %}
    {% set today = run_query(my_query).columns[0].values()[0] %}
    {% set tomorrow = dbt_utils.dateadd('day', 1, today) %}
    {% set start_date = var('dbt_airflow_monitoring')['airflow_monitoring_start_date'] %}
    {% else %}
    {% set tomorrow = ' ' %}
    {% set start_date = ' ' %}
{% endif %}

{{ dbt_utils.date_spine(
    datepart="day",
    start_date=start_date,
    end_date="cast('{{tomorrow}}' as date)"
)
}}