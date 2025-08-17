# 🛒 E-commerce Returns Analysis

## 🎯 Project Overview
This project simulates a real-world **Data Analyst workflow**:
- SQL (PostgreSQL) for data cleaning, normalization, and star schema modeling
- Power BI for interactive dashboards and KPI monitoring
- Business storytelling to support decision-making

Dataset: synthetic e-commerce sales & returns data (CSV).

---

## 🗂️ Project Structure
- `sql/` → SQL scripts for staging, cleaning, dimensions, fact tables
- `powerbi/` → Power BI report (.pbix)
- `docs/` → PDF export + screenshots for quick preview

---

## ⚙️ Data Pipeline
1. **Staging Table** – import raw CSV into `public.stg_customer_data`
2. **Normalized View** – clean payment methods, gender, age, returns, churn
3. **Star Schema**:
   - `dim_date` (calendar table)
   - `dim_customer`
   - `dim_product`
   - `fact_sales`
4. **Integrity Checks** – ensure relationships between fact and dimensions
5. **Power BI Modeling** – connect views, build relationships, create DAX measures

---

## 📊 KPIs & DAX Measures
- **Total Revenue** = SUM(sales_amount)  
- **Orders** = DISTINCTCOUNT(sales_id)  
- **Average Order Value (AOV)** = Revenue ÷ Orders  
- **Revenue Returned** = Revenue where is_returned = TRUE  
- **Return Rate** (orders & revenue)

---

## 📈 Dashboard Pages
1. **Executive Summary** – Revenue, AOV, Return Rate, customer KPIs
2. **Product Performance** – Top product categories by revenue
3. **Returns Analysis** – Return rate by category & customer segment

---

## 💡 Key Insights
- High revenue in *[category X]* but also highest return rate → signals quality issue
- Younger age groups (18–24) generate most orders, but 45–54 are more profitable
- Cash payments show higher mismatch errors vs Credit Card → operational risk

---

## 🚀 Learnings
- How to design a **SQL-to-Power BI pipeline** using star schema
- Hands-on practice with **data cleaning in SQL** (CASE, COALESCE, NULLIF, LIKE)
- **DAX fundamentals** for KPIs
- Storytelling: transforming raw data into actionable business insights


---

👤 Author: [Numele tău]  
🔗 Portfolio: [link website personal / LinkedIn]
