-- ============================================================
-- INDUSTRIAL PRODUCTION DATA WAREHOUSE
-- Bronze Layer - Table Definitions
-- ============================================================
--
-- Purpose:
--     Create the raw ingestion tables for the Bronze layer.
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

CREATE TABLE IF NOT EXISTS industrial_dw_bronze.mes_batchs_data (
    btch_id VARCHAR(255),
    prod_dt VARCHAR(255),
    prd_id VARCHAR(255),
    pkg_id VARCHAR(255),
    shft_id VARCHAR(255),
    qc_ts VARCHAR(255),
    visc_ku VARCHAR(255),
    ph VARCHAR(255),
    plan_qty VARCHAR(255),
    act_qty VARCHAR(255),
    rm_cost_usd VARCHAR(255)
) ENGINE=InnoDB 
DEFAULT CHARSET=utf8mb4 
COLLATE=utf8mb4_unicode_ci
COMMENT = 'Raw production and MES data ingested from mes_batchs_data.csv';


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

CREATE TABLE IF NOT EXISTS industrial_dw_bronze.erp_pds_info (
    pd_id VARCHAR(255),
    pd_nm VARCHAR(255),
    pd_cat VARCHAR(255),
    chem_base VARCHAR(255)
) ENGINE=InnoDB 
DEFAULT CHARSET=utf8mb4 
COLLATE=utf8mb4_unicode_ci
COMMENT = 'Raw product master data ingested from erp_pds_info.csv';


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

CREATE TABLE IF NOT EXISTS industrial_dw_bronze.erp_pack_opt (
    pkg_id VARCHAR(255),
    pkg_type VARCHAR(255),
    pkg_cap_l VARCHAR(255)
) ENGINE=InnoDB 
DEFAULT CHARSET=utf8mb4 
COLLATE=utf8mb4_unicode_ci
COMMENT = 'Raw packaging and presentation data ingested from erp_pack_opt.csv';


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

CREATE TABLE IF NOT EXISTS industrial_dw_bronze.erp_shift_info (
    shft_id VARCHAR(255),
    shft_nm VARCHAR(255),
    start_tm VARCHAR(255),
    end_tm VARCHAR(255)
) ENGINE=InnoDB 
DEFAULT CHARSET=utf8mb4 
COLLATE=utf8mb4_unicode_ci
COMMENT = 'Raw production shift data ingested from erp_shift_info.csv';


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

CREATE TABLE IF NOT EXISTS industrial_dw_bronze.mes_sup_prd_info (
    btch_id VARCHAR(255),
    prod_dt VARCHAR(255),
    prd_nm VARCHAR(255),
    pkg_desc VARCHAR(255),
    shft_cd VARCHAR(255),

    disp_st_ts VARCHAR(255),
    disp_end_ts VARCHAR(255),

    grnd_st_ts VARCHAR(255),
    grnd_end_ts VARCHAR(255),

    mix_st_ts VARCHAR(255),
    mix_end_ts VARCHAR(255),

    fltr_st_ts VARCHAR(255),
    fltr_end_ts VARCHAR(255),

    pkg_st_ts VARCHAR(255),
    pkg_end_ts VARCHAR(255),

    lbl_st_ts VARCHAR(255),
    lbl_end_ts VARCHAR(255),

    plan_qty VARCHAR(255),
    act_qty VARCHAR(255),
    rej_qty VARCHAR(255),

    sup_stat_cd VARCHAR(255),
    rmks VARCHAR(255)
)
ENGINE=InnoDB 
DEFAULT CHARSET=utf8mb4 
COLLATE=utf8mb4_unicode_ci
COMMENT = 'Raw supervisor and production process data ingested from mes_sup_prd_info.csv';