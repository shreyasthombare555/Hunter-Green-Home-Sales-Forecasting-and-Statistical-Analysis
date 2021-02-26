# Hunter Green Home Sales Forecasting and Statistical Analysis

Project Overview: Hunters Green is a gated residential community in Tampa about 10 miles northeast of USF. I worked on actual data on all home sold in this community over the period 2015-2020. My goal for this project was to build statistical models to predict,

1) **Agent days on market (adom)**, which is essentially the number of days it took to close the sale from date of listing,  

2) **Sale price of home (pricesold)** based on relevant attributes in this data set.

# Business Value

i) Insights from the analysis can prove vital for a real estate company in analyzing trends pertaining to the house sales in a particular locality. Moreover, this analysis will enable real estate firm to forecast Agent Days on Market, Cumulative Days on Market and Price Sold for the property. 

ii) Insights extracted from the analysis will prove beneficial for the organization dealing with services such as buying, selling, insuring, financing, and restructuring the property and will help officials to evaluate KPI's thus easing the process of decision making. 

# Data Set Description

I worked on actual data on all home sold in this community over the period 2015-2020. The Dataset had relevant fetures pertaining to the demographics of the house, locality, and tenure since the house was listed. 

# Action Plan

1) Researched about relevant features that could prove vital for redicting ADOM and Proce Sold for the house.  

2) Preprocessed data by removing irrelevant features, standardizing features, factorizing categorical values with the aim of achieving consistency. 

3) Performed exploratory data analysis by implementing technicques such as plotting histograms and correlation matrix.

4) Built polynomial regression model with degree 2 for predicting Agent Days on Market and Price Sold.

5) Interpreted regression model's output and sketched marginal effect for top three predictors for both the dependent variables. 

6) Verified LINE assumptions and validated multi-collinerity effects. 

7) Formulated a well drafted actionable report which consolidated key insights and visualizations.   

# Model Interpretations and Insights
 
1) **Agent Days on Market** - Top Predictor Marginal Effect

i) Cumulative Days on Market - 1 day increase in CDOM will increase ADOM days by 0.68 unit. This variable was significant in the model.

ii) Square Feet Area - I unit increase in SQFT will decrease ADOM days by 0.0155 unit.

iii) Roof Type - Roof Type is directly related to ADOM. ADOM can marginally change by 2.29 as per the variations in the roof type.

2) **Price Sold** - Top Predictor Marginal Effect

i) Square Feet Area - 1 unit increase in SQFT will increase price sold by 23.52.

ii) Lot Square Feet - 1 unit increase in Lot SQFT will have marginal effect of 0.51 on price sold.

iii) List Price - 1 unit increase in list price will increase price sold by 0.915.

# Technologies Used

1) R programming

2) Microsoft Excel




