truncate "events"."transactions_raw";
truncate "events"."goals_raw";
truncate "events"."auth_logs_raw";
truncate "events"."service_a_events";

SELECT *
FROM
(
    SELECT 'auth_logs_raw' AS table_name, COUNT(*) AS row_count
    FROM "events"."auth_logs_raw"

    UNION ALL

    SELECT 'goals_raw', COUNT(*)
    FROM "events"."goals_raw"

    UNION ALL

    SELECT 'transactions_raw', COUNT(*)
    FROM "events"."transactions_raw"

    UNION ALL

    SELECT 'service_a_events', COUNT(*)
    FROM "events"."service_a_events"
)
ORDER BY row_count DESC;

-- ========================================================svs_a=========================================================================================================

select count(*) as row_count from "events"."svs_a_events";
select * from "events"."svs_a_events" limit 10;

-- ========================================================auth=========================================================================================================

select count(*) as row_count from aut_t;
select * from aut_t limit 10;

-- ========================================================goals=========================================================================================================

select count(*) as row_count from goals_t;
select * from goals_t limit 10;

-- ========================================================transactions=========================================================================================================

select count(*) as row_count from trxns_t;
select * from trxns_t limit 10;

SELECT 
    last_error_time, 
    name, 
    last_error_message
FROM system.errors 
WHERE last_error_time >= now() - INTERVAL 1 HOUR
  AND last_error_message != ''
ORDER BY last_error_time DESC 
LIMIT 5;







