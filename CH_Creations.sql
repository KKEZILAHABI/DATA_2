-- ============================ Service A ================================================================================================================================================
-- Kafka Engine Table
CREATE TABLE events.svs_a_kafka_queue (
    message String
) ENGINE = Kafka
SETTINGS 
    kafka_broker_list = 'kafka:9092',
    kafka_topic_list = 'pg_svs_a.svs_a_s.svs_a_evnts',
    kafka_group_name = 'clickhouse_svs_a_consumer_v4',
    kafka_format = 'JSONAsString',
    max_memory_usage = 2000000000; -- Overrides profile limits for this background consumer specifically

-- MergeTree()
CREATE TABLE svs_a_events (
    event_id UUID,
    user_id Int32,
    event_type String,
    platform String,
    amount Float32,
    timestamp DateTime
) ENGINE = MergeTree()
ORDER BY event_id;

-- Materialzied View
CREATE MATERIALIZED VIEW events.svs_a_consumer_mv TO events.svs_a_events AS
SELECT
    toUUID(JSONExtractString(message, 'payload', 'after', 'event_id')) AS event_id,
    JSONExtractInt(message, 'payload', 'after', 'user_id') AS user_id,
    JSONExtractString(message, 'payload', 'after', 'event_type') AS event_type,
    JSONExtractString(message, 'payload', 'after', 'platform') AS platform,
    JSONExtractFloat(message, 'payload', 'after', 'amount') AS amount,
    toDateTime(JSONExtractInt(message, 'payload', 'after', 'timestamp') / 1000000) AS timestamp
FROM events.svs_a_kafka_queue
WHERE JSONExtractString(message, 'payload', 'op') != 'd';

-- ============================ Auth ================================================================================================================================================
CREATE TABLE events.auth_kafka_queue (
    message String
) ENGINE = Kafka
SETTINGS 
    kafka_broker_list = 'kafka:9092',
    kafka_topic_list = 'pg_auth.auth_s.aut_t',
    kafka_group_name = 'clickhouse_auth_consumer',
    kafka_format = 'JSONAsString',
    max_memory_usage = 2000000000;

CREATE TABLE events.auth_events (
    event_id UUID,
    user_id Int32,
    action String,
    device_os String,
    timestamp DateTime
) ENGINE = MergeTree()
ORDER BY event_id;

CREATE MATERIALIZED VIEW events.auth_consumer_mv TO events.auth_events AS
SELECT
    toUUID(JSONExtractString(message, 'payload', 'after', 'event_id')) AS event_id,
    JSONExtractInt(message, 'payload', 'after', 'user_id') AS user_id,
    JSONExtractString(message, 'payload', 'after', 'action') AS action,
    JSONExtractString(message, 'payload', 'after', 'device_os') AS device_os,
    toDateTime(JSONExtractInt(message, 'payload', 'after', 'timestamp') / 1000000) AS timestamp
FROM events.auth_kafka_queue
WHERE JSONExtractString(message, 'payload', 'op') != 'd';


-- ============================ Goals ================================================================================================================================================
CREATE TABLE events.goals_kafka_queue (
    message String
) ENGINE = Kafka
SETTINGS 
    kafka_broker_list = 'kafka:9092',
    kafka_topic_list = 'pg_goals.goals_s.goals_t',
    kafka_group_name = 'clickhouse_goals_consumer',
    kafka_format = 'JSONAsString',
    max_memory_usage = 2000000000;

CREATE TABLE events.goals_events (
    goal_id UUID,
    user_id Int32,
    target_amount Float32,
    category String,
    action String,
    timestamp DateTime
) ENGINE = MergeTree()
ORDER BY goal_id;

CREATE MATERIALIZED VIEW events.goals_consumer_mv TO events.goals_events AS
SELECT
    toUUID(JSONExtractString(message, 'payload', 'after', 'goal_id')) AS goal_id,
    JSONExtractInt(message, 'payload', 'after', 'user_id') AS user_id,
    JSONExtractFloat(message, 'payload', 'after', 'target_amount') AS target_amount,
    JSONExtractString(message, 'payload', 'after', 'category') AS category,
    JSONExtractString(message, 'payload', 'after', 'action') AS action,
    toDateTime(JSONExtractInt(message, 'payload', 'after', 'timestamp') / 1000000) AS timestamp
FROM events.goals_kafka_queue
WHERE JSONExtractString(message, 'payload', 'op') != 'd';


-- ============================ Transactions ================================================================================================================================================
CREATE TABLE events.trxns_kafka_queue (
    message String
) ENGINE = Kafka
SETTINGS 
    kafka_broker_list = 'kafka:9092',
    kafka_topic_list = 'pg_trxns.trxns_s.trxns_t',
    kafka_group_name = 'clickhouse_trxns_consumer',
    kafka_format = 'JSONAsString',
    max_memory_usage = 2000000000;

CREATE TABLE events.trxns_events (
    transaction_id UUID,
    user_id Int32,
    amount Float32,
    transaction_type String,
    status String,
    timestamp DateTime
) ENGINE = MergeTree()
ORDER BY transaction_id;

CREATE MATERIALIZED VIEW events.trxns_consumer_mv TO events.trxns_events AS
SELECT
    toUUID(JSONExtractString(message, 'payload', 'after', 'transaction_id')) AS transaction_id,
    JSONExtractInt(message, 'payload', 'after', 'user_id') AS user_id,
    JSONExtractFloat(message, 'payload', 'after', 'amount') AS amount,
    JSONExtractString(message, 'payload', 'after', 'transaction_type') AS transaction_type,
    JSONExtractString(message, 'payload', 'after', 'status') AS status,
    toDateTime(JSONExtractInt(message, 'payload', 'after', 'timestamp') / 1000000) AS timestamp
FROM events.trxns_kafka_queue
WHERE JSONExtractString(message, 'payload', 'op') != 'd';





















