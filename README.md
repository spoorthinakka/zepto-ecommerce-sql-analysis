# Zepto E-commerce SQL Analysis

SQL-based analysis of Zepto's e-commerce dataset: schema design, data loading, cleaning, and deriving real-world business insights.

---

## Project Overview
E-commerce businesses generate massive amounts of product and inventory data every day.  
Efficient analysis of this data helps companies optimize stock levels, identify revenue opportunities, and understand discounting trends.  

In this project, we use **PostgreSQL** to analyze **Zepto's inventory dataset**.  
The workflow includes:
- Designing a structured database schema
- Importing and cleaning raw product data
- Running SQL queries to extract **real-world business insights**

---

## Project Structure
zepto-ecommerce-sql-analysis/
├── 01_schema.sql              # Table design
├── 02_load_data.sql           # Data import steps
├── 03_data_cleaning.sql       # Data cleaning & preprocessing
├── 04_real_world_insights/    # Business insights queries
│   ├── stock_analysis.sql
│   ├── discount_analysis.sql
│   ├── revenue_analysis.sql
│   ├── price_per_gram.sql
│   └── weight_analysis.sql
├── data/
│   └── zepto_utf8.csv         # UTF-8 formatted dataset (ready to import)
├── LICENSE                    # Project license (MIT)
└── README.md                  # Documentation



---

## Dataset
- **Source:** [Zepto Inventory Dataset on Kaggle](https://www.kaggle.com/datasets/palvinder2006/zepto-inventory-dataset)  
- **Format:** CSV  

You can use the dataset in two ways:
1. **Directly from Kaggle** → download the CSV and re-save it as **UTF-8 encoded CSV** before importing into PostgreSQL.  
   - Without UTF-8 encoding, special characters may cause import errors.  
2. **From this repository** → a **UTF-8 formatted version** of the dataset is already included in the `data/` folder, which runs properly without errors.  

- **License:** MIT License (as provided by Kaggle dataset author)

---

## Process

### 1. Schema Design
- Defined a table `zepto` with key attributes:
  - `sku_id`, `category`, `name`, `mrp`, `discountPercent`,  
    `availableQuantity`, `discountedSellingPrice`, `weightInGms`,  
    `outOfStock`, `quantity`.

### 2. Data Loading
- Imported the dataset into PostgreSQL using pgAdmin’s Import/Export tool.  
- Ensured correct **UTF-8 encoding** for smooth import.

### 3. Data Cleaning
- Checked for **null values**.  
- Removed invalid or null values.  
- Converted **Paise → Rupees** for pricing fields (to align with real-world values).  
- Verified product categories and stock status.

### 4. Real-World Insights
- Stock health by category and percentage out-of-stock  
- Top discounts and average discount by category  
- High MRP but out-of-stock items (missed revenue opportunities)  
- Estimated revenue by product category  
- Price-per-gram analysis for best value products  
- Weight-based product segmentation (low, medium, bulk)  
- Overall inventory weight contribution by category  

---

## Example Queries

🔹 **Top 10 products by discount percentage**
```sql
SELECT name, mrp, discountPercent
FROM zepto
ORDER BY discountPercent DESC
LIMIT 10;
```

🔹 **Estimated revenue per category**
```sql
SELECT category,
       SUM(discountedSellingPrice * availableQuantity) AS total_revenue
FROM zepto
GROUP BY category
ORDER BY total_revenue DESC;
```

---

## License

SQL scripts in this repository are released under the MIT License.

Dataset belongs to the Kaggle author and is MIT-licensed.
