# 🎮 GamePulse Market Intelligence

An end-to-end Gaming Market Intelligence Analytics project built using PostgreSQL, Python, Statistical Analysis, and Power BI to uncover pricing trends, discount strategies, publisher performance, and player satisfaction insights from the Steam Games dataset.

---

## 📌 Project Overview

The gaming industry generates billions of dollars annually, and pricing strategy plays a major role in commercial success.

This project analyzes approximately 72,000 Steam games to identify:

- Pricing patterns across publishers
- Impact of discounts on player ratings
- Player satisfaction trends
- Premium vs Budget game performance
- Market benchmarking opportunities
- Business recommendations for pricing optimization

The project follows a complete ETL and Analytics pipeline:

**Raw Data → ETL → PostgreSQL → SQL Analysis → Statistical Analysis → Power BI Dashboard → Business Insights**

---

## 🎯 Business Objectives

- Analyze Steam marketplace pricing trends
- Evaluate publisher performance
- Study discount effectiveness
- Understand player satisfaction behavior
- Identify market opportunities
- Generate data-driven pricing recommendations

---

# 🛠 Tech Stack

### Database
- PostgreSQL

### Programming
- Python

### Python Libraries
- Pandas
- NumPy
- SciPy
- Matplotlib
- Seaborn

### Visualization
- Power BI

### Version Control
- Git
- GitHub

---

# 📊 Dataset Information

**Dataset:** Steam Games Dataset

### Key Statistics

| Metric | Value |
|----------|----------|
| Total Games | ~72,000 |
| Average Rating | 84.95% |
| Average Price | $4.64 |
| Discounted Games | 3K |
| Discount Percentage | 3.71% |
| Price-Rating Correlation | -0.12 |

---

# ⚙️ ETL Pipeline

### Extract
- Read raw Steam Games CSV dataset

### Transform
- Handle missing values
- Remove duplicates
- Fix data types
- Create business features
- Data quality validation

### Load
- Load cleaned dataset into PostgreSQL

---

# 🏗 Project Workflow Architecture

![Workflow](screenshots/GamePulse%20Market%20Intelligence%20Workflow.png)

---

# 📂 Project Structure

```text
GamePulse-Market-Intelligence/
│
├── raw/
│   └── game.csv
│
├── processed/
│   └── game_cleaned.csv
│
├── src/
│   ├── extract.py
│   ├── transform.py
│   ├── load.py
│   └── test_connection.py
│
├── sql/
│   ├── 01_schema.sql
│   └── 02_business_analysis.sql
│
├── notebooks/
│   ├── 01_EDA.ipynb
│   └── 02_steam_statistical_analysis.ipynb
│
├── power bi/
│   ├── GamePulse_Market_Intelligence.pbix
│   └── GamePulse_Market_Intelligence.pdf
│
├── screenshots/
│   ├── Executive Overview.png
│   ├── Player Satisfaction & Pricing Analysis.png
│   ├── Discount Analysis & Business Insights.png
│   └── GamePulse Market Intelligence Workflow.png
│
├── report/
│   └── Gamepulse_Market_Intelligence_report.pdf
│
├── requirements.txt
│
└── README.md
```

---

# 📈 Exploratory Data Analysis (EDA)

EDA was performed to understand:

- Price distributions
- Rating distributions
- Publisher landscape
- Discount patterns
- Outlier detection
- Data quality assessment

Notebook:

```text
notebooks/01_EDA.ipynb
```

---

# 📉 Statistical Analysis

Advanced statistical analysis was conducted using Python and SciPy.

### Analysis Performed

- Correlation Analysis
- Distribution Analysis
- Hypothesis Testing
- Player Satisfaction Analysis
- Pricing Impact Study

Notebook:

```text
notebooks/02_steam_statistical_analysis.ipynb
```

---

# 🗄 SQL Business Analysis

Business-focused SQL queries were developed to answer strategic questions.

### Key Analyses

- Top Publishers
- Highest Rated Games
- Revenue Potential Analysis
- Pricing Segmentation
- Discount Effectiveness
- Market Benchmarking

Files:

```text
sql/01_schema.sql
sql/02_business_analysis.sql
```

---

# 📊 Power BI Dashboard

The project dashboard contains three interactive pages.

---

## 1️⃣ Executive Overview

### KPIs

- Total Games
- Average Price
- Average Rating
- Discount Percentage
- Top Publishers

### Insights

- Marketplace overview
- Publisher benchmarking
- Industry performance tracking

![Executive Overview](screenshots/Executive%20Overview.png)

---

## 2️⃣ Player Satisfaction & Pricing Analysis

### Analysis

- Price vs Rating Relationship
- Rating Distribution
- Premium vs Budget Games
- Satisfaction Trends

### Insights

- Higher prices do not guarantee higher ratings
- Affordable games often perform competitively

![Player Satisfaction & Pricing Analysis](screenshots/Player%20Satisfaction%20%26%20Pricing%20Analysis.png)

---

## 3️⃣ Discount Analysis & Business Insights

### Analysis

- Discount Effectiveness
- Discount Distribution
- Pricing Opportunities
- Market Recommendations

### Insights

- Excessive discounts do not always improve ratings
- Strategic discounting can improve competitiveness

![Discount Analysis & Business Insights](screenshots/Discount%20Analysis%20%26%20Business%20Insights.png)

---

# 💡 Key Findings

### Pricing

- Average game price is $4.64
- Market is dominated by low-cost titles

### Player Satisfaction

- Average rating is 84.95%
- Price has weak correlation with ratings

### Discounts

- Only 3.71% of games are discounted
- Discounting alone does not guarantee higher ratings

### Publishers

- Publisher performance varies significantly
- Market leaders maintain strong rating consistency

---

# 🚀 Business Recommendations

### Pricing Strategy

- Focus on value-driven pricing
- Avoid unnecessary premium pricing

### Discount Optimization

- Apply targeted discount campaigns
- Monitor rating impact before aggressive discounting

### Publisher Benchmarking

- Compare against top-performing publishers
- Adopt successful pricing patterns

### Market Intelligence

- Track pricing trends continuously
- Identify emerging opportunities early

---

# ▶️ How to Run the Project

### Clone Repository

```bash
git clone https://github.com/yourusername/GamePulse-Market-Intelligence.git
```

### Move to Project Folder

```bash
cd GamePulse-Market-Intelligence
```

### Install Dependencies

```bash
pip install -r requirements.txt
```

### Run ETL Pipeline

```bash
python src/extract.py
python src/transform.py
python src/load.py
```

### Test PostgreSQL Connection

```bash
python src/test_connection.py
```

---

# 📄 Report

Detailed project findings and business recommendations are available in:

```text
report/Gamepulse_Market_Intelligence_report.pdf
```

---

# 👨‍💻 Author

**Shantilal Mali**

Aspiring Data Analyst

### Skills

- SQL
- PostgreSQL
- Python
- Pandas
- NumPy
- SciPy
- Power BI
- Excel
- Git
- GitHub

---

# ⭐ If You Found This Project Useful

Please consider giving this repository a star.

It helps support future analytics and data science projects.