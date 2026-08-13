-- ============================================================
-- INDUSTRIAL PRODUCTION DATA WAREHOUSE
-- Silver Layer - MES Production Data Table Ingestion
-- ============================================================

-- Purpose:
--     Ingest the cleaned and standardized MES production data from the Bronze layer into the Silver layer

INSERT INTO `industrial-data-warehouse.silver.mes_batchs_data`(
    btch_id,
    prod_dt,
    prd_cd,
    pkg_cd,
    shft_cd,
    qc_ts,
    visc_ku,
    ph,
    plan_qty,
    act_qty,
    rm_cost_usd
)

SELECT
    UPPER(TRIM(btch_id)) AS btch_id,
    SAFE_PARSE_DATE('%d/%m/%Y', prod_dt) AS prod_dt,
    UPPER(TRIM(prd_cd)) AS prd_cd,
    UPPER(TRIM(pkg_cd)) AS pkg_cd,
    UPPER(TRIM(shft_cd)) AS shft_cd,
    qc_ts,
    SAFE_CAST(visc_ku AS FLOAT64) AS visc_ku,
    SAFE_CAST(ph AS FLOAT64) AS ph,
    SAFE_CAST(plan_qty AS INT64) AS plan_qty,
    SAFE_CAST(act_qty AS INT64) AS act_qty,
    SAFE_CAST(rm_cost_usd AS FLOAT64) AS rm_cost_usd
FROM `bronze.mes_batchs_data`;


-- Count null values in each column of the silver.mes_batchs_data table
SELECT 
  COUNTIF(btch_id IS NULL) AS btch_id_nulls,
  COUNTIF(prod_dt IS NULL) AS prod_dt_nulls,
  COUNTIF(prd_id IS NULL) AS prd_cd_nulls,
  COUNTIF(pkg_id IS NULL) AS pkg_cd_nulls,
  COUNTIF(shft_id IS NULL) AS shft_cd_nulls,
  COUNTIF(qc_ts IS NULL) AS qc_ts_nulls,
  COUNTIF(visc_ku IS NULL) AS visc_ku_nulls,
  COUNTIF(ph IS NULL) AS ph_nulls,
  COUNTIF(plan_qty IS NULL) AS plan_qty_nulls,
  COUNTIF(act_qty IS NULL) AS act_qty_nulls,
  COUNTIF(rm_cost_usd IS NULL) AS rm_cost_usd_nulls
FROM `silver.mes_batchs_data`;

-- Whitespace and formatting issues in the silver.mes_batchs_data table
SELECT
  btch_id,
  prod_dt,
  prd_id,
  pkg_id,
  shft_id,
  qc_ts,
  visc_ku,
  ph,
  plan_qty,
  act_qty,
  rm_cost_usd
FROM `silver.mes_batchs_data`
WHERE
  btch_id != UPPER(TRIM(btch_id))
  OR pkg_id != UPPER(TRIM(pkg_id))
  OR shft_id != UPPER(TRIM(shft_id));

-- Duplicate rows in the silver.mes_batchs_data table
SELECT
    btch_id,
    COUNT(*) AS duplicate_count
FROM `silver.mes_batchs_data`
GROUP BY btch_id
HAVING COUNT(*) > 1;