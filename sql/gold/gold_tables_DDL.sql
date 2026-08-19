-- ==========================================================
-- Gold Layer Tables DDL
-- Star Schema Design for Industrial Production Data Warehouse
-- ==========================================================

-- dim_products table
CREATE OR REPLACE TABLE `gold.dim_products`(
  product_id STRING,
  product_name STRING,
  category STRING,
  base STRING,
  PRIMARY KEY (product_id) NOT ENFORCED -- This is a dimension table for products, with product_id as the primary key.
);


CREATE OR REPLACE TABLE `gold.dim_package`(
  package_id STRING,
  package_name STRING,
  liters FLOAT64,
  PRIMARY KEY (package_id) NOT ENFORCED -- This is a dimension table for packages, with package_id as the primary key.
);

CREATE OR REPLACE TABLE `gold.dim_shifts`(
  shift_id STRING,
  shift STRING,
  start_time TIME,
  end_time TIME,
  PRIMARY KEY (shift_id) NOT ENFORCED -- This is a dimension table for shifts, with shift_id as the primary key.
);

CREATE OR REPLACE TABLE `gold.dim_production_batch`(
  batch_id STRING,
  production_date DATE,
  product_id STRING,
  package_id STRING,
  shift_id STRING,
  viscosity_ku FLOAT64,
  ph FLOAT64,
  planned_quantity INT64,
  actual_quantity INT64,
  rejected_quantity INT64,
  raw_materials_cost_usd FLOAT64,
  dispersion_start_time TIMESTAMP,
  dispersion_end_time TIMESTAMP,
  grinding_start_time TIMESTAMP,
  grinding_end_time TIMESTAMP,
  mixing_start_time TIMESTAMP,
  mixing_end_time TIMESTAMP,
  filter_start_time TIMESTAMP,
  filter_end_time TIMESTAMP,
  packaging_start_time TIMESTAMP,
  packaging_end_time TIMESTAMP,
  labeling_start_time TIMESTAMP,
  labeling_end_time TIMESTAMP,
  status STRING,
  PRIMARY KEY (batch_id) NOT ENFORCED -- This is a fact table for production batches, with batch_id as the primary key.
);