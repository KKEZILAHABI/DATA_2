--truncate transactions_raw;
--truncate goals_raw;
--truncate auth_logs_raw;
--truncate service_a_events;

SELECT *
FROM
(
    SELECT 'auth_logs_raw' AS table_name, COUNT(*) AS row_count
    FROM auth_logs_raw

    UNION ALL

    SELECT 'goals_raw', COUNT(*)
    FROM goals_raw

    UNION ALL

    SELECT 'transactions_raw', COUNT(*)
    FROM transactions_raw

    UNION ALL

    SELECT 'service_a_events', COUNT(*)
    FROM service_a_events
)
ORDER BY row_count DESC;

select * from auth_logs_raw limit 10



-- ========================================================svs_a=========================================================================================================

select count(*) as row_count from svs_a_evnts;
select * from svs_a_evnts;

-- ========================================================auth=========================================================================================================

select count(*) as row_count from aut_t;
select * from aut_t limit 10;

-- ========================================================goals=========================================================================================================

select count(*) as row_count from goals_t;
select * from goals_t limit 10;

-- ========================================================transactions=========================================================================================================

select count(*) as row_count from trxns_t;
select * from trxns_t limit 10;












