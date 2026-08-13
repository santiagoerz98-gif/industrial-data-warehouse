-- Count null values in each column of the bronze.mes_batchs_data table
SELECT 
  COUNTIF(btch_id IS NULL) AS btch_id_nulls,
  COUNTIF(prod_dt IS NULL) AS prod_dt_nulls,
  COUNTIF(prd_cd IS NULL) AS prd_cd_nulls,
  COUNTIF(pkg_cd IS NULL) AS pkg_cd_nulls,
  COUNTIF(shft_cd IS NULL) AS shft_cd_nulls,
  COUNTIF(qc_ts IS NULL) AS qc_ts_nulls,
  COUNTIF(visc_ku IS NULL) AS visc_ku_nulls,
  COUNTIF(ph IS NULL) AS ph_nulls,
  COUNTIF(plan_qty IS NULL) AS plan_qty_nulls,
  COUNTIF(act_qty IS NULL) AS act_qty_nulls,
  COUNTIF(rm_cost_usd IS NULL) AS rm_cost_usd_nulls
FROM `bronze.mes_batchs_data`;

-- Whitespace and formatting issues in the bronze.mes_batchs_data table
SELECT
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
FROM `bronze.mes_batchs_data`
WHERE
  btch_id != UPPER(TRIM(btch_id))
  OR prod_dt != UPPER(TRIM(prod_dt))
  OR pkg_cd != UPPER(TRIM(pkg_cd))
  OR shft_cd != UPPER(TRIM(shft_cd));

-- Duplicate rows in the bronze.mes_batchs_data table
SELECT
    btch_id,
    COUNT(*) AS duplicate_count
FROM `bronze.mes_batchs_data`
GROUP BY btch_id
HAVING COUNT(*) > 1;

-- Date format issues in the bronze.mes_batchs_data table
SELECT
    btch_id,
    prod_dt
FROM `bronze.mes_batchs_data`
WHERE SAFE.PARSE_DATE('%Y-%m-%d', prod_dt) IS NULL
  AND prod_dt IS NOT NULL;