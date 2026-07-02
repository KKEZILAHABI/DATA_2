-- ============================ Service A ==================================================================================================================
-- Kafka Engine Table
CREATE TABLE svs_a_kafka_queue (
    message String
) ENGINE = Kafka
SETTINGS 
    kafka_broker_list = 'kafka:9092',
    kafka_topic_list = 'pg_svs_a.svs_a_s.svs_a_evnts',
    kafka_group_name = 'clickhouse_svs_a_consumer',
    kafka_format = 'JSONAsString';

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
CREATE MATERIALIZED VIEW svs_a_consumer_mv TO svs_a_events AS
SELECT
    toUUID(JSONExtractString(message, 'payload', 'after', 'event_id')) AS event_id,
    JSONExtractInt(message, 'payload', 'after', 'user_id') AS user_id,
    JSONExtractString(message, 'payload', 'after', 'event_type') AS event_type,
    JSONExtractString(message, 'payload', 'after', 'platform') AS platform,
    JSONExtractFloat(message, 'payload', 'after', 'amount') AS amount,
    toDateTime(JSONExtractInt(message, 'payload', 'after', 'timestamp') / 1000000) AS timestamp
FROM svs_a_kafka_queue
WHERE JSONExtractString(message, 'payload', 'op') != 'd';






















