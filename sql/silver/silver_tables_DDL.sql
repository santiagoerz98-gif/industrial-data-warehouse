-- ============================================================
-- INDUSTRIAL PRODUCTION DATA WAREHOUSE
-- Silver Layer - Table Definitions
-- ============================================================
--
-- Purpose:
--     Create the cleaned and standardized tables for the Silver layer.
--
-- Principles:
--     - Clean and standardize source data.

-- ============================================================
-- 1. MES PRODUCTION DATA
-- ============================================================
--
-- Source:
--     bronze.mes_batchs_data
--
-- Grain:
--     One row per production batch.
--
-- ============================================================

CREATE OR REPLACE TABLE
    `industrial-data-warehouse.silver.mes_batchs_data`
(
    btch_id STRING,
    prod_dt DATE,
    prd_id STRING,
    pkg_id STRING,
    shft_id STRING,
    qc_ts STRING,
    visc_ku FLOAT64,
    ph FLOAT64,
    plan_qty INTEGER,
    act_qty INTEGER,
    rm_cost_usd FLOAT64
)
OPTIONS (
    description = 'Cleaned production and MES data ingested from bronze.mes_batchs_data'
);


-- ============================================================
-- 2. PRODUCT MASTER DATA
-- ============================================================
--
-- Source:
--     bronze.erp_pds_info
--
-- Grain:
--     One row per product.
--
-- ============================================================

CREATE OR REPLACE TABLE
    `industrial-data-warehouse.silver.erp_pds_info`
(
    pd_id STRING,
    pd_nm STRING,
    pd_cat STRING,
    chem_base STRING
)
OPTIONS (
    description = 'Cleaned product master data ingested from bronze.erp_pds_info'
);


-- ============================================================
-- 3. PACKAGING DATA
-- ============================================================
--
-- Source:
--     bronze.erp_pack_opt
--
-- Grain:
--     One row per packaging/presentation.
--
-- ============================================================

CREATE OR REPLACE TABLE
    `industrial-data-warehouse.silver.erp_pack_opt`
(
    presentacion_id STRING,
    tipo_envase STRING,
    capacidad_litros FLOAT64
)
OPTIONS (
    description = 'Cleaned packaging and presentation data ingested from bronze.erp_pack_opt'
);


-- ============================================================
-- 4. SHIFT DATA
-- ============================================================
--
-- Source:
--     bronze.erp_shift_info
--
-- Grain:
--     One row per production shift.
--
-- ============================================================

CREATE OR REPLACE TABLE
    `industrial-data-warehouse.silver.erp_shift_info`
(
    turno_id STRING,
    nombre_turno STRING,
    hora_inicio TIME,
    hora_fin TIME
)
OPTIONS (
    description = 'Cleaned production shift data ingested from bronze.erp_shift_info'
);


-- ============================================================
-- 5. SUPERVISOR PRODUCTION DATA
-- ============================================================
--
-- Source:
--     bronze.mes_sup_prd_info
--
-- Grain:
--     One row per supervised production lot.
--
-- ============================================================

CREATE OR REPLACE TABLE
    `industrial-data-warehouse.silver.mes_sup_prd_info`
(
    btch_id STRING,
    prod_dt DATE,
    prd_nm STRING,
    pkg_desc STRING,
    shft_cd STRING,

    disp_st_ts TIMESTAMP,
    disp_end_ts TIMESTAMP,

    grnd_st_ts TIMESTAMP,
    grnd_end_ts TIMESTAMP,

    mix_st_ts TIMESTAMP,
    mix_end_ts TIMESTAMP,

    fltr_st_ts TIMESTAMP,
    fltr_end_ts TIMESTAMP,

    pkg_st_ts TIMESTAMP,
    pkg_end_ts TIMESTAMP,

    lbl_st_ts TIMESTAMP,
    lbl_end_ts TIMESTAMP,

    plan_qty INTEGER,
    act_qty INTEGER,
    rej_qty INTEGER,

    sup_stat_cd STRING,
    rmks STRING
)
OPTIONS (
    description = 'Cleaned supervisor and production process data ingested from bronze.mes_sup_prd_info'
);