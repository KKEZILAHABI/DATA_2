-- 1. Create the database first
CREATE DATABASE IF NOT EXISTS events;

create schema  if not exists event_schema;

set search_path to event_schema;

-- 2. Create the table inside it
CREATE TABLE IF NOT EXISTS service_a_events (
    event_id UUID,
    user_id int,
    event_type varchar,
    platform varchar,
    amount Float,
    timestamp timestamp 
);

CREATE TABLE IF NOT EXISTS transactions_raw (
    transaction_id UUID,
    user_id Int,
    amount Float,
    transaction_type varchar,
    status varchar,
    timestamp timestamp
);


CREATE TABLE IF NOT EXISTS auth_logs_raw (
    event_id UUID,
    user_id Int,
    action varchar,
    device_os varchar,
    timestamp timestamp
);

CREATE TABLE IF NOT EXISTS goals_raw (
    goal_id UUID,
    user_id int,
    target_amount Float,
    category varchar,
    action varchar,
    timestamp timestamp
);


