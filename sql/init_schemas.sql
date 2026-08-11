/*
==============================================================================
CREATE BIGQUERY DATASETS(SCHEMAS)
==============================================================================
Script Purpose:
This script sets up three datasets within the BigQuery project: 'bronze', 'silver' and 'gold'.
*/

-- Bronze Layer Dataset
CREATE
  SCHEMA `industrial-data-warehouse.bronze`
  OPTIONS (
    location = 'europe-southwest1');

-- Silver Layer Dataset
CREATE
  SCHEMA `industrial-data-warehouse.silver`
  OPTIONS (
    location = 'europe-southwest1');

-- Gold Layer Dataset
CREATE
  SCHEMA `industrial-data-warehouse.gold`
  OPTIONS (
    location = 'europe-southwest1');
