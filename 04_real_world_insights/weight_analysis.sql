/* ======================================================================
   weight_analysis.sql
   Purpose : Analyze products based on their weight and inventory contribution
   Prereq : Run 01_schema.sql, 02_load_data.sql, and 03_cleaning.sql first
   ====================================================================== */

/* ---------- 1) Weight category segmentation ----------------------------
   Group products into weight-based categories:
   - Low (< 1000g)
   - Medium (1000g to < 5000g)
   - Bulk (>= 5000g)
   This helps in analyzing packaging and delivery planning.
*/
SELECT
  name,
  weightInGms,
  CASE
    WHEN weightInGms < 1000 THEN 'Low'
    WHEN weightInGms < 5000 THEN 'Medium'
    ELSE 'Bulk'
  END AS weight_category
FROM zepto
WHERE weightInGms IS NOT NULL
ORDER BY weight_category, name;

/* ---------- 2) Total inventory weight per category ---------------------
   Calculates total inventory weight = weight × available quantity.
   Also shows the percentage contribution of each category to the overall weight.
*/
SELECT
  category,
  SUM(weightInGms * availableQuantity) AS total_inventory_weight,
  ROUND( 100.0 * SUM(weightInGms * availableQuantity) / SUM(SUM(weightInGms * availableQuantity)) OVER (), 2) 
        AS percentage_of_total_weight
FROM zepto
WHERE weightInGms IS NOT NULL
GROUP BY category
ORDER BY total_inventory_weight DESC;
