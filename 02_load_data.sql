/* ======================================================================
   02_load_data.sql
   Purpose: Load the Zepto e-commerce dataset into the `zepto` table
   Prereq: Run 01_schema.sql first to create the `zepto` table

   Dataset Source :
   Zepto Inventory Dataset on Kaggle
   https://www.kaggle.com/datasets/palvinder2006/zepto-inventory-dataset

   Notes :
     - The repo includes a UTF-8 CSV at: data/zepto_utf8.csv (can use it directly)
     - Else, if downloading directly from Kaggle, re-save as UTF-8 CSV
       (to avoid encoding errors while importing)
     - Column order in COPY must match the table columns used below
   ====================================================================== */

/* ---------- Option A: Load from the owner's repo's /data folder (recommended) --
   This works if you use the provided UTF-8 CSV in your repo.
*/
COPY zepto (
  category,
  name,
  mrp,
  discountPercent,
  availableQuantity,
  discountedSellingPrice,
  weightInGms,
  outOfStock,
  quantity
)
FROM 'data/zepto_utf8.csv'
DELIMITER ','
CSV HEADER
ENCODING 'UTF8';


/* ---------- Option B: pgAdmin GUI Import -------------------------------
   - Right-click table `zepto` → Import/Export → Import
   - File: <your_repo_path>/data/zepto_utf8.csv
   - Format: CSV
   - Encoding: UTF-8
   - Header: Yes
   - Delimiter: ,
   - In the Columns section → uncheck/remove `sku_id` (it will auto-generate)
   Then click OK
*/

/* --------------------------- Post-load sanity checks ------------------- */
-- Verify row count
SELECT COUNT(*) FROM zepto;

-- Quick sample of the imported data
SELECT * FROM zepto 
LIMIT 10;

