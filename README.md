# 🚗 SQL & Databases: Customer & Vehicle Sales Analysis
Queried disorganized flat-file sales data to uncover customer feedback patterns. Used advanced SQL joins, window functions, and subqueries to generate a business report with improvement recommendations.

---

## 🚀 Project Overview
📊 **Goal:** Analyze customer demographics, satisfaction trends, order volumes, revenue, and vehicle brand preferences to guide data-driven business decisions.

✅ **Key Data Tables:** 
- `customer_t` — Customer demographics, contact, credit card type.
- `order_t` — Orders & transaction metrics.
- Other supporting tables from `new_wheels_dumpfile.sql`.

📝 Used **MySQL** for data management and **Python (SQLAlchemy, Pandas)** for additional analysis & visualization.

---

## 🔍 Key Business Insights
### 📈 Market Hotspots
- **Texas & California** each have 97 customers, top markets for targeted campaigns.
- Followed by Florida, New York, and DC.

### 🏎️ Vehicle Preferences
- Most preferred automakers: **Chevrolet**, followed by Pontiac, Ford, Toyota, Dodge.
- Regional nuances: luxury brands (Audi, BMW, Mercedes) popular in niche states.

### 💸 Revenue & Orders
| Metric                  | Q1         | Q2         | Q3         | Q4         |
|--------------------------|------------|------------|------------|------------|
| Orders                   | 310        | 199        | ~150       | <100       |
| Revenue                  | Highest    | Declining  | Lower      | Lowest     |
| Customer Satisfaction    | 3.55 ⭐    | 3.36 ⭐    | 2.96 ⭐    | 2.40 ⭐    |
| Avg Ship Days            | ~57 days   | ~128 days  | ~118 days  | ~174 days  |

- Declining orders & revenue with **sharp satisfaction drops**, esp. in Q3-Q4.

### ⏳ Shipping & Discounts
- **Ship times rose** dramatically to ~174 days by Q4, risking churn.
- Highest average discounts seen on **Laser & Mastercard** holders.

---

## 💼 Strategic Recommendations
- 📍 Launch targeted promotions in Texas & California.
- 🎯 Improve shipping operations to cut delivery time.
- 🛠️ Address quality to halt rising bad reviews in Q3 & Q4.
- 🏷️ Tailor offers by credit card type to incentivize sales.

---

## 📊 Key Visualizations
- 🗺️ **Customer Distribution by State**
![Distribution of Customers across States](https://github.com/user-attachments/assets/0bc824e2-5902-45d0-9184-b5b61f182346)
- 🚗 **Top Automaker Preferences**
![Top Vehicle makers preferred by customers](https://github.com/user-attachments/assets/f7faebba-04b4-4409-b931-4ee887097edd)
- 💵 **Revenue & Orders Over Quarters**
![Quarter on Quarter % change in Revenue](https://github.com/user-attachments/assets/c66528a5-e8fb-4bbf-b711-a708d20713d0)
- ⏳ **Shipping Days & Customer Ratings Trend**
![Time taken to ship orders by Quarter](https://github.com/user-attachments/assets/63ec7c1e-a92b-4a23-af70-fe88d6ef7b52)

Please check the Project report for full insights

---

## 🛠️ Tools & Skills Covered
- 🐬 **MySQL:** Database creation, data population (`new_wheels_dumpfile.sql`), advanced joins & aggregations.
- 🐍 **Python:** SQLAlchemy, Pandas for querying & EDA.
- 📈 Business Metrics: Revenue, Orders, Customer Satisfaction, Shipping SLAs.

---

## ⚙️ How to Run
- Restore DB in MySQL:  
```bash
mysql -u username -p vehdb < new_wheels_dumpfile.sql
```
- Run Python notebooks (`SQL_Issac.ipynb`) for additional EDA.

---

## 🤝 About Me
I built this project independently, showcasing expertise in relational databases, SQL analytics, and translating data into actionable strategies.

🔗 [LinkedIn](https://linkedin.com/in/yourprofile)

---

✅ **Thanks for exploring my database analytics project!**
