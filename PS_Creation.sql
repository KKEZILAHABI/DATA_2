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

-- =====================================SERVICE A SCHEMA DEFINITON===========================================================================================================
create database svs_a;
create schema svs_a_s;
set search_path to svs_a_s;
CREATE TABLE IF NOT EXISTS svs_a_evnts (
    event_id UUID,
    user_id int,
    event_type varchar,
    platform varchar,
    amount Float,
    timestamp timestamp 
);

INSERT INTO svs_a_s.svs_a_evnts (event_id, user_id, event_type, platform, amount, timestamp) 
VALUES (gen_random_uuid(), 1, 'login', 'web', 0.0, NOW());

SHOW wal_level;
SELECT slot_name, plugin, active FROM pg_replication_slots;
-- =====================================AUTHS SCHEMA DEFINITON===========================================================================================================
create database auth;
create schema auth_s;
set search_path to auth_s;
CREATE TABLE IF NOT EXISTS aut_t (
    event_id UUID,
    user_id Int,
    action varchar,
    device_os varchar,
    timestamp timestamp
);


-- =====================================TRANSACTIONS SCHEMA DEFINITON===========================================================================================================
create database trxns;
create schema trxns_s;
set search_path to trxns_s;
CREATE TABLE IF NOT EXISTS trxns_t (
    transaction_id UUID,
    user_id Int,
    amount Float,
    transaction_type varchar,
    status varchar,
    timestamp timestamp
);

-- =====================================GOALS SCHEMA DEFINITON===========================================================================================================
create database goals;
create schema goals_s;
set search_path to goals_s;
CREATE TABLE IF NOT EXISTS goals_t (
    goal_id UUID,
    user_id int,
    target_amount Float,
    category varchar,
    action varchar,
    timestamp timestamp
);


-- =========================================================Debezium User=================================================================================================

-- 1. Create the user with strict replication privileges
CREATE ROLE dbzm_user WITH REPLICATION LOGIN PASSWORD '##Removed##';

GRANT CREATE ON DATABASE svs_a TO dbzm_user;

-- 2. Grant connection access to the database
GRANT CONNECT ON DATABASE svs_a TO dbzm_user;

-- 3. Grant schema usage and read access to the tables
GRANT USAGE ON SCHEMA svs_a_s TO dbzm_user;
GRANT SELECT ON ALL TABLES IN SCHEMA svs_a_s TO dbzm_user;

-- 4. Ensure Debezium automatically has read access to any tables you create in the future
ALTER DEFAULT PRIVILEGES IN SCHEMA svs_a_s GRANT SELECT ON TABLES TO dbzm_user;

-- Switch to Auth DB
GRANT CONNECT ON DATABASE auth TO dbzm_user;
GRANT USAGE ON SCHEMA auth_s TO dbzm_user;
GRANT SELECT ON ALL TABLES IN SCHEMA auth_s TO dbzm_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA auth_s GRANT SELECT ON TABLES TO dbzm_user;

-- Switch to Transactions DB
GRANT CONNECT ON DATABASE trxns TO dbzm_user;
GRANT USAGE ON SCHEMA trxns_s TO dbzm_user;
GRANT SELECT ON ALL TABLES IN SCHEMA trxns_s TO dbzm_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA trxns_s GRANT SELECT ON TABLES TO dbzm_user;

-- Switch to Goals DB
GRANT CONNECT ON DATABASE goals TO dbzm_user;
GRANT USAGE ON SCHEMA goals_s TO dbzm_user;
GRANT SELECT ON ALL TABLES IN SCHEMA goals_s TO dbzm_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA goals_s GRANT SELECT ON TABLES TO dbzm_user;











