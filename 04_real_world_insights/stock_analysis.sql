/* ======================================================================
   stock_analysis.sql
   Purpose: Analyze stock availability and inventory health
   Prereq: Run 01_schema.sql, 02_load_data.sql, and 03_cleaning.sql first
   ====================================================================== */

/* ---------- 1) Different product categories ---------------------------
   Lists all unique product categories available in the dataset.
   Useful for understanding the overall inventory structure.
*/
SELECT DISTINCT category
FROM zepto
ORDER BY category;

/* ---------- 2) Products in stock vs out of stock ----------------------
   Counts the number of products that are available versus those that are not available.
   This helps in understanding the overall health of the stock.
*/
SELECT outOfStock, COUNT(sku_id) AS num_products
FROM zepto
GROUP BY outOfStock;

/* ---------- 3) Stock health by category -------------------------------
   Shows the number of products per category that are out of stock.
   Also calculates the percentage of out-of-stock items in each category.
*/
SELECT
  category,
  COUNT(*) AS total_products_in_category,
  COUNT(*) FILTER (WHERE outOfStock) AS total_out_of_stock_products,
  ROUND(100.0 * COUNT(*) FILTER (WHERE outOfStock) / NULLIF(COUNT(*), 0), 2) AS percentage_of_products_out_of_stock
FROM zepto
GROUP BY category
ORDER BY total_out_of_stock_products DESC, category;


/* ---------- 4) Available inventory (units) by category ----------------
   Aggregates the total number of available units per category.
   Note: We use COALESCE to treat NULL values in availableQuantity as 0,
   since missing values should not be ignored when summing inventory.
*/
SELECT
  category,
  SUM(COALESCE(availableQuantity, 0)) AS total_units_available
FROM zepto
GROUP BY category
ORDER BY total_units_available DESC;

