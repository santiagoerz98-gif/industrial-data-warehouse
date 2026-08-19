-- ============================================================
-- INDUSTRIAL PRODUCTION DATA WAREHOUSE
-- Silver Layer - ERP Tables Ingestion
-- ============================================================

-- Purpose:
--     Create the cleaned and standardized ERP tables for the Silver layer.

-- erp_pds_info table
INSERT INTO `industrial-data-warehouse.silver.erp_pds_info`(
    pd_id,
    pd_nm,
    pd_cat,
    chem_base
)
SELECT
    UPPER(TRIM(pd_id)),
    LOWER(TRIM(pd_nm)),
    LOWER(TRIM(pd_cat)),
    LOWER(TRIM(chem_base))
FROM `bronze.erp_pds_info`;

-- erp_pkgs_info table
INSERT INTO `industrial-data-warehouse.silver.erp_pack_opt`(
    pkg_id,
    pkg_type,
    pkg_cap_l
)
SELECT
    UPPER(TRIM(pkg_id)),
    LOWER(TRIM(pkg_type)),
    SAFE_CAST(pkg_cap_l AS FLOAT64)
FROM `bronze.erp_pack_opt`;

-- erp_shift_info table
INSERT INTO `industrial-data-warehouse.silver.erp_shift_info`(
    shft_id,
    shft_nm,
    start_tm,
    end_tm
)
SELECT
    UPPER(TRIM(shft_id)),
    LOWER(TRIM(shft_nm)),
    PARSE_TIME('%H:%M', start_time),
    PARSE_TIME('%H:%M', end_time)
FROM `bronze.erp_shift_info`

