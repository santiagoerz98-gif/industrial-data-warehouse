/*
==============================================================================
CREATE MySQL Schemas for Industrial Data Warehouse
==============================================================================
Script Purpose:
This script sets up three schemas within the MySQL database: 'bronze', 'silver' and 'gold'.
*/

-- Bronze Layer Schema
CREATE SCHEMA IF NOT EXISTS industrial_dw_bronze;

-- Silver Layer Schema
CREATE SCHEMA IF NOT EXISTS industrial_dw_silver;

-- Gold Layer Schema
CREATE SCHEMA IF NOT EXISTS industrial_dw_gold;
