



select count(*)
from (

    select
        id

    from "dbryan"."public"."my_second_dbt_model"
    where id is not null
    group by id
    having count(*) > 1

) validation_errors

