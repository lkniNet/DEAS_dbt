{% snapshot snapshot_forecast %}

    {{
        config(
            strategy='check',
            unique_key='UNIQUE_KEY',
            check_cols=['avg_temperature_feelslike_2m_f']
        )
    }}

    WITH FORECAST_CTE AS (
        select
        {{ dbt_utils.generate_surrogate_key([
            'time_init_utc',
            'postal_code',
            'country',
            'date_valid_std'
        ]) }} AS UNIQUE_KEY,                
        *
      FROM {{ source('WEATHER', 'FORECAST')}}
    {% if target.name == 'dev' %}
      LIMIT 100
    {% elif target.name == 'qa' %}
      LIMIT 10000 
    {% else %}
      
    {% endif %}
    )

    SELECT * FROM FORECAST_CTE


{% endsnapshot %}
