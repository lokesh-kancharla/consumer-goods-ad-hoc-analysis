-- ==========================================================
-- Consumer Goods Ad-hoc Analysis
-- Step 1: Initialize Database
-- Author: Lokesh Kancharla
-- MySQL 8.0+
-- ==========================================================

DROP DATABASE IF EXISTS consumer_goods_db;
CREATE DATABASE consumer_goods_db
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_0900_ai_ci;

USE consumer_goods_db;

SELECT DATABASE() AS active_database;
