# Pizza Hut Sales Performance - End-to-End SQL Analysis

## 📌 Project Overview
This project performs a comprehensive data analysis of a year's transactional data for a pizza factory/store using **MySQL**. The objective is to discover key business performance indicators (KPIs), examine seasonal and daily ordering trends, and understand product-level sales velocity to optimize inventory.

## 🗄️ Database Architecture
The project utilizes **4 distinct interconnected relational tables**:
1. `pizza_types`: Stores unique pizza names, categories (Classic, Veggie, Supreme, Chicken), and ingredients.
2. `pizzas`: Contains pricing points and dimensional size constraints (S, M, L, XL) linked to type IDs.
3. `orders`: Records parent invoice markers tracking specific dates and timestamps.
4. `order_details`: Connects orders to pizzas mapping exact quantitative sale items.

---

## 📊 Key Insights & Business KPIs

### 1. Financial Performance
* **Total Revenue:** Evaluated dynamically using an `INNER JOIN` of unit scales and price matrices.
* **Average Order Value (AOV):** Calculated as `Total Revenue / COUNT(DISTINCT order_id)`. The benchmark output is approximately **38.31**.
* **Average Pizzas Per Order:** Calculated using transaction volumes showing that a typical customer orders **2.32** pizzas per checkout sequence.

### 2. Operational Volume Metrics
* **Total Pizzas Sold:** Calculated strictly using `SUM(quantity)` ensuring precise unit count matching **49,574 physical pieces**.
* **Total Invoices Placed:** Calculated using parent order counters totaling **21,350 unique entries**.

---

## 📈 Executive Summary Trends (Charts Matrix)

* **Daily Rush Trend:** Analysis using `DAYNAME()` and `DAYOFWEEK()` parameters confirms that **Friday and Saturday evenings** register the maximum customer traffic.
* **Size Domain:** Large (L) size variants dominate market generation contributing to **45.89%** of absolute store revenue.
* **Top Revenue Vector:** **The Thai Chicken Pizza** leads premium financial contribution, while **The Classic Deluxe Pizza** scores the highest transaction frequency volume.

---

## 🛠️ Tech Stack & Key Concepts Covered
* **Database Engine:** MySQL Workbench
* **SQL Core Skills:** Multi-Table Inner Joins, Subqueries for Percentages, Group By Aggregations, Data Parsing (`MONTHNAME`, `DAYNAME`), Output Constraints (`LIMIT`, `ORDER BY ASC/DESC`).

