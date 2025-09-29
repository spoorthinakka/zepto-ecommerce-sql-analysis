/* ======================================================================
   01_schema.sql
   Purpose: Define the schema and create the `zepto` table
   Notes:
     - Run this script first before loading any data
     - The table stores product information, including category, pricing,
       discount, stock, weight, and availability
   ====================================================================== */

-- Drop table if it already exists (useful for re-runs)
DROP TABLE IF EXISTS zepto;

-- Create the main table
CREATE TABLE zepto (
    sku_id SERIAL PRIMARY KEY,               -- Unique ID for each row
    category VARCHAR(120),                   -- Product category
    name VARCHAR(150) NOT NULL,              -- Product name
    mrp NUMERIC(8,2),                        -- Maximum Retail Price
    discountPercent NUMERIC(5,2),            -- Discount percentage
    availableQuantity INTEGER,               -- Units available in stock
    discountedSellingPrice NUMERIC(8,2),     -- Selling price after discount
    weightInGms INTEGER,                     -- Product weight in grams
    outOfStock BOOLEAN,                      -- Availability flag
    quantity INTEGER                         -- Packaging quantity (e.g., pack of 6)
);

-- Verify that the table was created successfully
SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'public'
  AND table_name = 'zepto';
