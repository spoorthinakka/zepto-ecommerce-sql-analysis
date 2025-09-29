/* ======================================================================
   discount_analysis.sql
   Purpose: Analyze discounts across products and categories
   Prereq: Run 01_schema.sql, 02_load_data.sql, and 03_cleaning.sql first
   ====================================================================== */

/* ---------- 1) Top 10 highest discounts -------------------------------
   Finds products with the highest discount percentage.
   Useful for spotting the best deals or aggressive promotions.
*/
SELECT
  name,
  category,
  mrp,
  discountedSellingPrice,
  discountPercent
FROM zepto
ORDER BY discountPercent DESC
LIMIT 10;

/* ---------- 2) Average discount % by category -------------------------
   Calculates the average discount percentage for each category.
   Helps identify which categories rely heavily on discounts.
*/
SELECT
  category,
  ROUND(AVG(discountPercent), 2) AS average_discount_percentage
FROM zepto
GROUP BY category
ORDER BY average_discount_percentage DESC;

/* ---------- 3) Expensive products with minimal discount ---------------
   Finds products priced above ₹500 that have less than 5% discount.
   Useful to see which high-value items sell without promotions.
*/
SELECT
  name,
  category,
  mrp,
  discountedSellingPrice,
  discountPercent
FROM zepto
WHERE mrp > 500
  AND discountPercent < 5
ORDER BY mrp DESC;
