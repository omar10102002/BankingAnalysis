# 💼 Smart Banking Analytics Solution  
**Powered by AI, SQL, Power BI, and Azure — Built for the EYouth Competition**
![System Architecture](Screenshot%202025-05-28%20233412.png)

## 📌 Overview

This project was developed as part of a national **data analytics competition organized by EYouth**, aiming to deliver an **end-to-end smart banking solution** using real banking datasets. The solution focuses on 
transforming raw data into actionable insights that enhance customer experience, reduce risk, and empower better decision-making across banking departments.



---

## 🗃️ Dataset Composition
The project is based on 6 interrelated datasets:

| Table Name     | Description                                 |
|----------------|---------------------------------------------|
| Customers      | Client profiles and demographic info        |
| Accounts       | Account types and balance history           |
| Transactions   | Full financial transaction records          |
| Loans          | Loan types, durations, and interest rates   |
| Cards          | Issued debit/credit card information        |
| SupportCalls   | Logged customer service call interactions   |

---

## ⚙️ Workflow Architecture
```
Azure SQL Server --> Python Notebook --> Power BI Dashboards
                          |                    |
                        Chatbot <--------------
```

- **Azure SQL**: Centralized, cloud-hosted, relational database
- **Python**: Used for cleaning, ML modeling, and forecasting
- **Power BI**: Used for dashboards, KPIs, and geo-visuals
- **Chatbot**: RAG-based interface for natural-language insights

---


## 🔧 Project Workflow

### 1. **Data Engineering**
- Data cleaning and handling missing values.  
- Creating meaningful features (e.g., loan risk level, transaction frequency).  
- Establishing foreign key relationships and optimizing joins.

### 2. **SQL Analysis**
- Writing complex queries to extract KPIs.  
- Using CTEs and Window Functions for year-over-year analysis.  
- Building stored procedures for report generation.

### 3. **Power BI Reporting**
- Connected all structured data to Power BI.  
- Designed interactive dashboards and storyboards.  
- Wrote **custom DAX formulas** for:  
  - Yearly transaction growth  
  - Average customer tenure  
  - Loan approval rates by region

### 4. **Advanced Data Analytics (Jupyter Notebooks)**
- 📊 **RFM Segmentation**: Classified customers based on Recency, Frequency, and Monetary value.  
- 🔍 **Fraud Detection**: Used anomaly detection to flag unusual transaction patterns.  
- ⚠️ **Inactive High-Value Accounts**: Triggered alerts for dormant but wealthy accounts.  
- 📉 **Loan Default Prediction**: Built a predictive model using historical loan data.  
- 📈 **Time Series Forecasting**: Predicted future transaction volumes.

---

## 💬 AI Chatbot (RAG-Powered)

To make the data accessible to non-technical users, we developed an **AI-powered chatbot** using **Retrieval-Augmented Generation (RAG)**.  
The bot is capable of:
- Answering natural language questions.  
- Extracting SQL-based insights in real-time.  
- Being deployed and accessed by anyone in the organization without coding knowledge.

---

## 🎯 Project Objectives

- Enhance customer engagement through deeper insights.  
- Reduce loan default rates via early risk identification.  
- Detect fraud in real time with automated alerts.  
- Provide clear forecasts for future planning.  
- Democratize access to data insights with AI tools.

---

## 🧠 Key Takeaway

> This is not just a data project — it’s a **comprehensive smart banking ecosystem**.  
From hosting and SQL pipelines to visual storytelling and AI interaction, this solution bridges technical data processing with user-friendly insights for real-world impact.

---

## 🏆 Special Note

> ✅ This project was submitted as part of the **EYouth National Data Analytics Challenge**  
and showcases the full capability of a **cross-functional data science team** in solving real-world banking problems.
