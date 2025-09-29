/* ======================================================================
   revenue_analysis.sql
   Purpose: Estimate revenue potential across products and categories
   Prereq: Run 01_schema.sql, 02_load_data.sql, and 03_cleaning.sql first
   ====================================================================== */

/* ---------- 1) Estimated revenue per product ---------------------------
   Calculates estimated revenue = selling price × available quantity.
   Useful for identifying top products that contribute the most revenue.
*/
SELECT
  name,
  category,
  discountedSellingPrice,
  availableQuantity,
  ROUND(discountedSellingPrice * availableQuantity, 2) AS estimated_revenue
FROM zepto
ORDER BY estimated_revenue DESC
LIMIT 10;

/* ---------- 2) Total estimated revenue by category ---------------------
   Aggregates estimated revenue for each category.
   Helps identify the most profitable categories overall.
*/
SELECT
  category,
  ROUND(SUM(discountedSellingPrice * availableQuantity), 2) AS category_revenue
FROM zepto
GROUP BY category
ORDER BY category_revenue DESC;

/* ---------- 3) Category contribution to overall revenue ----------------
   Calculates each category’s share (%) of total revenue.
   Useful for business strategy and resource allocation.
*/
SELECT
  category,
  ROUND(SUM(discountedSellingPrice * availableQuantity), 2) AS category_revenue,
  ROUND(100.0 * SUM(discountedSellingPrice * availableQuantity) / SUM(SUM(discountedSellingPrice * availableQuantity)) 
        OVER (), 2) AS revenue_percentage_share
FROM zepto
GROUP BY category
ORDER BY category_revenue DESC;
