# Global Superstore Retail Analytics Application

An end-to-end business intelligence and data engineering ecosystem featuring an enterprise SQL Server data warehouse backend and a custom, interactive Power BI application frontend modeled after modern application UI/UX patterns.

---

## 📊 Executive Dashboard Preview
![Project Overview Showcase](Assets/Global_Superstore.pdf)

---

## 🛠️ The Tech Stack & Architecture
* **Data Layer:** SQL Server (SSMS) - Database Architecture, Custom Schema Design, and ETL script execution.
* **Transformation & Modeling:** Power Query (M Language) and Star Schema Data Modeling (Fact/Dimension separation).
* **Analytics Layer:** Advanced DAX (Data Analysis Expressions) for time-series forecasting, predictive demand modeling, and behavioral margin analysis.
* **UI/UX Theme:** Custom Dark Mode App Interface featuring floating visual containers, synchronized page navigation, and responsive KPIs.

---

## ⚙️ Core Engineering & Analytical Breakthroughs

### 1. Data Pipeline & Error Handling (SQL Frontend)
* Solved critical schema constraints during ETL processes including data truncation handling and `DBNull.Value` exceptions in dimensions.
* Cleansed natural business keys to maintain strict relational integrity across transactional facts and client dimensions.

### 2. Algorithmic Margin Analysis & Behavioral Diagnostics (DAX)
* **Inventory Scale Management:** Structured optimized iterators to dynamically profile and track **10.29K+ unique product assets** across multi-regional distribution points without causing engine latency.
* **Outlier Isolation Logic:** Formulated an ascending `TOPN` calculation framework to automatically isolate and flag **"Tables"** as the deepest loss-making sub-category, exposing a critical profit leak.
* **Enterprise-Level Performance Monitoring:** Developed analytical models capturing **$12.64M in Total Sales** and **$1.47M in Total Profit** over a complex, multi-year global retail matrix.

---

## 📱 Dashboard Architecture (4-Page Application)
The application features an interconnected 4-page responsive grid layout mapped to core corporate departments, utilizing synchronized date and regional slicers for seamless exploration:

### 1. Executive Sales & Profitability Overview
Provides a high-level command center for executive leadership to monitor top-line growth metrics, historical trends, and market distributions.
* **Core KPI Indicators:** Total Sales ($12.64M), Total Profit ($1.47M), Profit Margin % (11.61%), and Total Order Volume (25.04K).
* **Macro Matrix Table:** A corporate performance overview breakdown across high-level categories (Technology, Office Supplies, Furniture) tracking exact sales tallies and profit margin percentages.
* **Core Trend Visualization:** A dual-axis Month-over-Month Sales vs. Profit Margin % Combo Chart to trace operational seasonality patterns.
* **Segment Distribution:** A Total Sales by Segment Donut Chart isolating consumer retail demand (51.48%) from corporate and home office portfolios.

### 2. Customer Performance & Behavioral Analysis
Built for customer success managers to isolate high-value accounts, prevent margin erosion, and monitor portfolio concentration risks.
* **Core KPI Indicators:** Distinct Active Customer Tracking (4.87K), Lifecycle Average Sales per Customer ($2.59K), and Top Customer Revenue Contribution ($40.49K).
* **Main Matrix Plot:** A massive Customer Profitability Scatter Plot Matrix mapping Sales against Profit Margin % to cluster high-performing tiers from outliers.
* **Leaderboard Matrix Grid:** Top 10 Customers ranked strictly by Profit Margin (led by Raymond Buch at $8.45K profit) to identify baseline revenue anchors.
* **Risk Exception Grid:** Bottom 10 Customers sorted by net margin deficits (isolating critical risk accounts like Luke Foster at -$3.64K profit) to address contractual leaks.

### 3. Operational & Regional Performance Matrix
Engineered for supply chain and logistics coordinators to diagnose shipment costs, transit delays, and geographical execution bottlenecks.
* **Core KPI Indicators:** Total Global Shipping Cost ($1.4M), Average Order Value ($505 AOV), and Average Shipping Cost per Order ($54).
* **Hierarchical Tree Flow:** An interactive Global Decomposition Tree breaking down delivery costs by Country $\rightarrow$ Region $\rightarrow$ Ship Mode (tracking key channels like United States West Coast Standard Class).
* **Logistics Bar Charts:** Dual decoupled horizontal bar charts mapping Total Shipping Cost by Ship Mode alongside Avg Order Value by Ship Mode to prevent scale distortion across Standard Class, Second Class, First Class, and Same Day tiers.

### 4. Product Profitability & Advanced Forecasting
Designed for inventory procurement managers to analyze product demand velocities, prevent warehouse stockouts, and flag portfolio profit drains.
* **Core KPI Indicators:** Total Unique Products Sold (10.29K), Most Profitable Sub-Category (Copiers), and Deepest Loss-Making Sub-Category (Tables).
* **Predictive Demand Timeline:** A continuous Total Sales by Month line chart extending out into a 10-month linear predictive forecast model complete with shaded 95% standard-error shadow bounds.
* **Portfolio Optimization Chart:** A sorted Horizontal Profit by Sub-Category Bar Chart visualizing asset profit engines (Copiers, Phones) dropping down directly into structural deficit lines.
---

## 🚀 How to Deploy This Project
1. Run the scripts inside `/database` sequentially in your SQL Server instance to spin up the schema.
2. Open the `/dashboard/superstore_retail_app.pbix` file in Power BI Desktop.
3. Update the data source parameters to point to your local database engine instance.
