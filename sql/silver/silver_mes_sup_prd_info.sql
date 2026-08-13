-- ============================================================
-- INDUSTRIAL PRODUCTION DATA WAREHOUSE
-- Silver Layer - MES Supervisor Production Info Table Ingestion
-- ============================================================

INSERT INTO `industrial-data-warehouse.silver.mes_sup_prd_info`(
  btch_id, 
  prod_dt, 
  prd_nm, 
  pkg_desc, 
  shft_cd, 
  disp_st_ts,
  disp_end_ts, 
  grnd_st_ts, 
  grnd_end_ts,
  mix_st_ts, 
  mix_end_ts, 
  fltr_st_ts, 
  fltr_end_ts, 
  pkg_st_ts, 
  pkg_end_ts,
  lbl_st_ts,
  lbl_end_ts, 
  plan_qty,
  act_qty, 
  rej_qty, 
  sup_stat_cd,
  rmks 
)
SELECT
  UPPER(TRIM(btch_id)), 
  prod_dt, 
  LOWER(TRIM(prd_nm)), 
  UPPER(TRIM(pkg_desc)), 
  UPPER(TRIM(shft_cd)), 
  disp_st_ts,
  disp_end_ts, 
  grnd_st_ts, 
  grnd_end_ts,
  mix_st_ts, 
  mix_end_ts, 
  fltr_st_ts, 
  fltr_end_ts, 
  pkg_st_ts, 
  pkg_end_ts,
  lbl_st_ts,
  lbl_end_ts, 
  plan_qty,
  act_qty, 
  rej_qty,
  (CASE 
    WHEN UPPER(TRIM(sup_stat_cd)) IN ("RECHAZADO","NO CONFORME") THEN "rechazado"
    WHEN UPPER(TRIM(sup_stat_cd)) IN ("CONFORME","OK","LIBERADO","APROBADO") THEN "aprobado"
    ELSE "reproceso"
    END
  ) AS sup_stat_cd,
  rmks
FROM `bronze.mes_sup_prd_info`

-- Count total rows in the silver.mes_sup_prd_info table
SELECT COUNT(*) FROM `industrial-data-warehouse.silver.mes_sup_prd_info`;

-- Count null values in each column of the silver.mes_sup_prd_info table
SELECT COUNT(*) FROM `industrial-data-warehouse.silver.mes_sup_prd_info`;

SELECT
  COUNTIF(btch_id IS NULL) AS btch_id_nulls,
  COUNTIF(prod_dt IS NULL) AS prod_dt_nulls,
  COUNTIF(prd_nm IS NULL) AS prd_nm_nulls,
  COUNTIF(pkg_desc IS NULL) AS pkg_desc_nulls,
  COUNTIF(shft_cd IS NULL) AS shft_cd_nulls,
  COUNTIF(disp_st_ts IS NULL) AS disp_st_ts_nulls,
  COUNTIF(disp_end_ts IS NULL) AS disp_end_ts_nulls,
  COUNTIF(grnd_st_ts IS NULL) AS grnd_st_ts_nulls,
  COUNTIF(grnd_end_ts IS NULL) AS grnd_end_ts_nulls,
  COUNTIF(mix_st_ts IS NULL) AS mix_st_ts_nulls,
  COUNTIF(mix_end_ts IS NULL) AS mix_end_ts_nulls,
  COUNTIF(fltr_st_ts IS NULL) AS fltr_st_ts_nulls,
  COUNTIF(fltr_end_ts IS NULL) AS fltr_end_ts_nulls,
  COUNTIF(pkg_st_ts IS NULL) AS pkg_st_ts_nulls,
  COUNTIF(pkg_end_ts IS NULL) AS pkg_end_ts_nulls,
  COUNTIF(lbl_st_ts IS NULL) AS lbl_st_ts_nulls,
  COUNTIF(lbl_end_ts IS NULL) AS lbl_end_ts_nulls,
  COUNTIF(plan_qty IS NULL) AS plan_qty_nulls,
  COUNTIF(act_qty IS NULL) AS act_qty_nulls,
  COUNTIF(rej_qty IS NULL) AS rej_qty_nulls,
  COUNTIF(sup_stat_cd IS NULL) AS sup_stat_cd_nulls,
  COUNTIF(rmks IS NULL) AS rmks_nulls,
FROM `industrial-data-warehouse.silver.mes_sup_prd_info`;

-- Inspect products with null process stages timestamps
SELECT
  LOWER(TRIM(prd_nm)) AS clean_nm,
  COUNTIF(disp_st_ts IS NULL) AS null_disp_ts,
  COUNTIF(grnd_st_ts IS NULL) AS null_grnd_ts
FROM `industrial-data-warehouse.silver.mes_sup_prd_info`
GROUP BY clean_nm;

-- Whitespace and formatting issues in the silver.mes_sup_prd_info table
SELECT
  btch_id,
  prod_dt,
  prd_nm,
  pkg_desc,
  shft_cd,
FROM `industrial-data-warehouse.silver.mes_sup_prd_info`
WHERE
  btch_id != UPPER(TRIM(btch_id))
  OR prd_nm != LOWER(TRIM(prd_nm))
  OR pkg_desc != UPPER(TRIM(pkg_desc))
  OR shft_cd != UPPER(TRIM(shft_cd))
  OR sup_stat_cd != LOWER(TRIM(sup_stat_cd));

-- Duplicate rows in the silver.mes_sup_prd_info table
SELECT
  btch_id,
  COUNT(*) AS duplicate_count
FROM `industrial-data-warehouse.silver.mes_sup_prd_info`
GROUP BY btch_id
HAVING COUNT(*) > 1;

-- Check supervisor status code values
SELECT DISTINCT 
  UPPER(TRIM(sup_stat_cd)) 
FROM `industrial-data-warehouse.silver.mes_sup_prd_info`