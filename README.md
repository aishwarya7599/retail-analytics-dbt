# RETAIL ANALYTICS ENGINEERING: END-TO-END ELT PIPELINE

## PROJECT OVERVIEW
This project demonstrates a professional **ELT (Extract, Load, Transform)** pipeline designed to convert raw, multi-year retail data into a production-ready analytical layer. I architected a solution that automates data ingestion from **Google Drive** into **Snowflake**, performs rigorous data cleansing via **dbt**, and materializes a **Star Schema** optimized for business intelligence and executive reporting.



---

## TECHNICAL STACK
* **DATA SOURCE**: Google Drive
* **INGESTION (EL)**: Fivetran
* **DATA WAREHOUSE**: Snowflake
* **TRANSFORMATION (T)**: dbt Cloud
* **ORCHESTRATION & TESTING**: dbt Core/Cloud
* **VERSION CONTROL**: GitHub

---

## DATA ARCHITECTURE AND PIPELINE

### 1. EXTRACTION AND LOADING (FIVETRAN)
* **AUTOMATED INGESTION**: Utilized Fivetran to create a persistent connection between Google Drive and Snowflake, ensuring that new sales files are automatically synced to the `RAW` schema.
* **SCHEMA GOVERNANCE**: Managed initial table landing and data types during the ingestion phase to maintain warehouse organization.

### 2. TRANSFORMATION AND MODELING (DBT)
I moved raw ingestion tables through a structured **Medallion Architecture** to reach the final analytical layer:

**STAGING LAYER**
* **MULTI-YEAR UNIONING**: Consolidated individual sales files from 2020, 2021, and 2022 into a single unified model to enable longitudinal trend analysis.
* **ADVANCED DATE PARSING**: Implemented `try_to_date` logic to resolve European date formats (`DD/MM/YYYY`), ensuring compatibility with Snowflake’s standard `YYYY-MM-DD` format.
* **METADATA CLEANSING**: Engineered filters to remove non-numeric "junk" rows (e.g., "Source AW_Cust_Master") that frequently occur in legacy CSV exports, preventing downstream join failures.

**MARTS LAYER (STAR SCHEMA)**
* **FACT TABLES**: Materialized `fact_sales` and `fact_returns` for high-performance KPI tracking.
* **DIMENSION TABLES**: Built descriptive lookup tables for `dim_customers`, `dim_products`, `dim_territories`, and `dim_categories`.
* **SURROGATE KEYS**: Implemented hash-based surrogate keys via `dbt_utils` to ensure reliable unique identifiers across disparate data sources.

### 3. QUALITY ASSURANCE
* **AUTOMATED TESTING**: Deployed a suite of `unique`, `not_null`, and `relationships` tests across all primary and foreign keys to ensure data integrity.
* **RBAC MANAGEMENT**: Configured Snowflake **Role-Based Access Control (RBAC)** to manage secure permissions between transformation roles and admin roles.

---

## DATA LINEAGE

The project lineage demonstrates a clear separation of concerns, transitioning from raw ingestion through the staging filters to the verified "Marts" layer.

---

## KEY BUSINESS INSIGHTS ENABLED
With this clean Star Schema, organizations can now perform:
* **SALES PERFORMANCE ANALYSIS**: Tracking revenue growth month-over-month across the 2020–2022 period.
* **PRODUCT HEALTH MONITORING**: Identifying categories with disproportionately high return rates.
* **CUSTOMER SEGMENTATION**: Analyzing average order value (AOV) against demographics such as income level and occupation.

---

## EXECUTION INSTRUCTIONS
1. **CLONE REPOSITORY**: `git clone [Your-Repo-URL]`
2. **INSTALL DEPENDENCIES**: `dbt deps`
3. **RUN PIPELINE**: `dbt build --full-refresh`
4. **GENERATE DOCUMENTATION**: `dbt docs generate`

---

## EXECUTION INSTRUCTIONS

### REPOSITORY INITIALIZATION
* **CLONE REPOSITORY**: Run `git clone [Your-Repo-URL]` to download the project source code and configuration files.
* **INSTALL DEPENDENCIES**: Run `dbt deps` to install the `dbt_utils` package required for surrogate key generation and schema tests.

### PIPELINE EXECUTION
* **RUN BUILD**: Execute `dbt build --full-refresh` to materialize all models in Snowflake and run automated tests.
* **FULL REFRESH**: The `--full-refresh` flag is mandatory for the initial run to ensure the staging filters purge all metadata headers from the warehouse.

### DOCUMENTATION AND LINEAGE
* **GENERATE DOCS**: Run `dbt docs generate` to compile the data dictionary and lineage graph.
* **VIEW LINEAGE**: Access the dbt Cloud documentation tab to visually inspect the data flow from raw ingestion to the marts layer.

## LINEAGE GRAPH

<img width="1832" height="823" alt="Lineage Graph" src="https://github.com/user-attachments/assets/b97816e4-2fa9-44fd-932a-a7626139ee99" />

## DASHBOARD SCREENSHOT

<img width="1520" height="832" alt="image" src="https://github.com/user-attachments/assets/a4c6d8f9-6466-4ad0-9d69-ee44cf0867cd" />

