/* ======================================================================
   price_per_gram.sql
   Purpose: Identify the most value-for-money products based on price per gram
   Prereq: Run 01_schema.sql, 02_load_data.sql, and 03_cleaning.sql first
   ====================================================================== */

/* ---------- Top 10 best value products overall -------------------------
   Calculates price per gram = selling price ÷ weight (in grams).
   Shows the 10 cheapest products per gram across the entire dataset.
*/
SELECT
  name,
  category,
  weightInGms,
  discountedSellingPrice,
  ROUND(discountedSellingPrice / NULLIF(weightInGms, 0), 4) AS price_per_gram
FROM zepto
WHERE weightInGms IS NOT NULL
ORDER BY price_per_gram ASC
LIMIT 10;
