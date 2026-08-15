-- ============================================================
-- INDUSTRIAL PRODUCTION DATA WAREHOUSE
-- Bronze Layer - BigQuery Table Definitions
-- ============================================================
--
-- Purpose:
--     Create the raw ingestion tables for the Bronze layer in BigQuery.
--
-- Principles:
--     - Preserve source data as received.
--     - No cleaning.
--     - No standardization.
--     - No business logic.
--     - No joins.
--     - Preserve potentially malformed values for Silver processing.
--
-- ============================================================



-- ============================================================
-- 1. MES PRODUCTION DATA
-- ============================================================
--
-- Source:
--     mes_batchs_data.csv
--
-- Grain:
--     One row per production batch.
--
-- Important:
--     Several fields are intentionally stored as STRING because
--     the source data may contain spaces, decimal commas or
--     inconsistent date formats.
--
-- ============================================================

CREATE TABLE IF NOT EXISTS `industrial-data-warehouse.bronze.mes_batchs_data`
(
    btch_id STRING,
    prod_dt STRING,
    prd_id STRING,
    pkg_id STRING,
    shft_id STRING,
    qc_ts STRING,
    visc_ku STRING,
    ph STRING,
    plan_qty STRING,
    act_qty STRING,
    rm_cost_usd STRING
)
OPTIONS (
    description = 'Raw production and MES data ingested from mes_batchs_data.csv'
);


-- ============================================================
-- 2. PRODUCT MASTER DATA
-- ============================================================
--
-- Source:
--     erp_pds_info.csv
--
-- Grain:
--     One row per product.
--
-- ============================================================

CREATE TABLE IF NOT EXISTS `industrial-data-warehouse.bronze.erp_pds_info`
(
    pd_id STRING,
    pd_nm STRING,
    pd_cat STRING,
    chem_base STRING
)
OPTIONS (
    description = 'Raw product master data ingested from erp_pds_info.csv'
);


-- ============================================================
-- 3. PACKAGING DATA
-- ============================================================
--
-- Source:
--     erp_pack_opt.csv
--
-- Grain:
--     One row per packaging/presentation.
--
-- ============================================================

CREATE TABLE IF NOT EXISTS `industrial-data-warehouse.bronze.erp_pack_opt`
(
    pkg_id STRING,
    pkg_type STRING,
    pkg_cap_l STRING
)
OPTIONS (
    description = 'Raw packaging and presentation data ingested from erp_pack_opt.csv'
);


-- ============================================================
-- 4. SHIFT DATA
-- ============================================================
--
-- Source:
--     erp_shift_info.csv
--
-- Grain:
--     One row per production shift.
--
-- ============================================================

CREATE TABLE IF NOT EXISTS `industrial-data-warehouse.bronze.erp_shift_info`
(
    shft_id STRING,
    shft_nm STRING,
    start_tm STRING,
    end_tm STRING
)
OPTIONS (
    description = 'Raw production shift data ingested from erp_shift_info.csv'
);


-- ============================================================
-- 5. SUPERVISOR PRODUCTION DATA
-- ============================================================
--
-- Source:
--     mes_sup_prd_info.csv
--
-- Grain:
--     One row per supervised production lot.
--
-- ============================================================

CREATE TABLE IF NOT EXISTS `industrial-data-warehouse.bronze.mes_sup_prd_info`
(
    btch_id STRING,
    prod_dt STRING,
    prd_nm STRING,
    pkg_desc STRING,
    shft_cd STRING,

    disp_st_ts STRING,
    disp_end_ts STRING,

    grnd_st_ts STRING,
    grnd_end_ts STRING,

    mix_st_ts STRING,
    mix_end_ts STRING,

    fltr_st_ts STRING,
    fltr_end_ts STRING,

    pkg_st_ts STRING,
    pkg_end_ts STRING,

    lbl_st_ts STRING,
    lbl_end_ts STRING,

    plan_qty STRING,
    act_qty STRING,
    rej_qty STRING,

    sup_stat_cd STRING,
    rmks STRING
)
OPTIONS (
    description = 'Raw supervisor and production process data ingested from mes_sup_prd_info.csv'
);