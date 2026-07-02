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




