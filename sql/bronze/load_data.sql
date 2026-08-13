
-- ===========================================================================
-- INDUSTRIAL PRODUCTION DATA WAREHOUSE
-- Bronze Layer - Load Data into bronze Tables from raw CSV files
-- ===========================================================================
-- Purpose:
--     Load raw data into the Bronze layer tables.

SET GLOBAL local_infile = 1;

-- Load data into the bronze table for mes_batchs_data
LOAD DATA LOCAL INFILE 'C:\\Users\\Admin\\Desktop\\proyectos\\industrial-data-warehouse\\data\\mes_batchs_data.csv'
INTO TABLE industrial_dw_bronze.mes_batchs_data
FIELDS TERMINATED BY ';'
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

SELECT * FROM industrial_dw_bronze.erp_pds_info LIMIT 10;