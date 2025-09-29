/* ======================================================================
   03_cleaning.sql
   Purpose: Data cleaning and preprocessing for the Zepto dataset
   Prereq: Run 01_schema.sql and 02_load_data.sql before this
   ====================================================================== */

/* ---------- 1. Check for null values ----------------------------- */
SELECT *
FROM zepto
WHERE category IS NULL
   OR name IS NULL
   OR mrp IS NULL
   OR discountPercent IS NULL
   OR discountedSellingPrice IS NULL
   OR weightInGms IS NULL
   OR availableQuantity IS NULL
   OR outOfStock IS NULL
   OR quantity IS NULL;

/* ---------- 2. Identify products with zero/invalid prices -------- */
SELECT *
FROM zepto
WHERE mrp = 0 OR discountedSellingPrice = 0;

/* Remove rows with zero/invalid MRP values */
DELETE FROM zepto
WHERE mrp = 0;

/* ---------- 3. Convert Paise to Rupees ---------------------------
   In the raw dataset, price values (MRP and discountedSellingPrice)
   are stored in paise (e.g., ₹100 = 10000).
   Since we typically work with rupee values in real-world insights
   and business analysis, we convert them to rupees by dividing by 100.
*/
UPDATE zepto
SET mrp = mrp / 100.0,
    discountedSellingPrice = discountedSellingPrice / 100.0;

/* ---------- 4. Check for products with repeated names -------------
   This query identifies product names that occur multiple times.
   Note:
   - These are not necessarily data errors.
   - Repetition can happen because of variations in packaging,
     weights, or pack sizes (e.g., 500ml vs 1L bottle).
   - Still useful to check for consistency in naming and categorization.
*/
SELECT name, COUNT(sku_id) AS "Number of SKUs"
FROM zepto
GROUP BY name
HAVING COUNT(sku_id) > 1
ORDER BY COUNT(sku_id) DESC;


/* ---------- 5. Post-clean sanity checks -------------------------- */
-- Row count after cleaning
SELECT COUNT(*) AS rows_after_cleaning FROM zepto;

-- Sample rows
SELECT * FROM zepto LIMIT 10;

