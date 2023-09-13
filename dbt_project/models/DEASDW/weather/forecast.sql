-- Her vil man lave eventuel rens af rå data. 


select *
from {{ ref('snapshot_forecast')}}
-- er det her mon nødvendigt? den må reelt set må tage data fra dev miljøet? dev kan selvfølgelig ende med at blive stor over tid.
{% if target.name == 'dev' %}
    LIMIT 100
{% elif target.name == 'qa' %}
    LIMIT 10000 
{% else %}
