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