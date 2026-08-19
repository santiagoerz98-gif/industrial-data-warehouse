-- ========================================================
-- Industrial Data Warehouse 
-- Gold Layer Tables Ingestion from Silver Layer
-- ========================================================


INSERT INTO `industrial-data-warehouse.gold.dim_products`(
    product_id,
    product_name,
    category,
    base
)
SELECT
    pd_id,
    pd_nm,
    pd_cat,
    chem_base
FROM `industrial-data-warehouse.silver.erp_pds_info`;

INSERT INTO `industrial-data-warehouse.gold.dim_package`(
    package_id,
    package_name,
    liters
)
SELECT
    pkg_id,
    pkg_type,
    pkg_cap_l
FROM `industrial-data-warehouse.silver.erp_pack_opt`;

INSERT INTO `industrial-data-warehouse.gold.dim_shifts`(
    shift_id,
    shift,
    start_time,
    end_time
)
SELECT
    shft_id,
    shft_nm,
    start_tm,
    end_tm
FROM `industrial-data-warehouse.silver.erp_shift_info`;

INSERT INTO `industrial-data-warehouse.gold.fact_production_batchs`(
    batch_id,
    production_date,
    product_id,
    package_id,
    shift_id,
    viscosity_ku,
    ph,
    planned_quantity,
    actual_quantity,
    rejected_quantity,
    raw_materials_cost_usd,
    dispersion_start_time,
    dispersion_end_time,
    grinding_start_time,
    grinding_end_time,
    mixing_start_time,
    mixing_end_time,
    filter_start_time,
    filter_end_time,
    packaging_start_time,
    packaging_end_time,
    labeling_start_time,
    labeling_end_time,
    batch_status
)
SELECT 

    b.btch_id,
    b.prod_dt,
    b.prd_id,
    b.pkg_id,
    b.shft_id,
    b.visc_ku,
    b.ph,
    b.plan_qty,
    b.act_qty,
    s.rej_qty,
    b.rm_cost_usd,
    s.disp_st_ts,
    s.disp_end_ts,
    s.grnd_st_ts,
    s.grnd_end_ts,
    s.mix_st_ts,
    s.mix_end_ts,
    s.fltr_st_ts,
    s.fltr_end_ts,
    s.pkg_st_ts,
    s.pkg_end_ts,
    s.lbl_st_ts,
    s.lbl_end_ts,
    s.sup_stat_cd
FROM `industrial-data-warehouse.silver.mes_batchs_data` b
LEFT JOIN `industrial-data-warehouse.silver.mes_sup_prd_info` s ON b.btch_id = s.btch_id