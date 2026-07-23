CREATE TABLE customer_churnn(
    customer_id text,
    age text,
    gender VARCHAR(10),
    city VARCHAR(50),
    subscription_type VARCHAR(20),
    monthly_charges FLOAT,
    tenure INT,
    contract_type VARCHAR(20),
    support_calls INT,
    internet_service VARCHAR(20),
    churn INT,
    charges_per_tenure FLOAT
);

select * from customer_churnn;


select churn,count(*)AS total_customers
from customer_churnn
group by churn;

--CHURN RATE "%"

SELECT
   count(case when churn = 1 then 1 end)*
100.0/count(*)AS churn_rate
from customer_churnn;


--OVERALL BUSINESS HEALTH

SELECT 
   count(*) AS total_customers,
   sum(churn)AS churned_customers,
   round(avg(churn)*100,2)AS churn_rate
   from customer_churnn;



SELECT 
    COUNT(*) AS total_customers,
    SUM(CASE WHEN churn = 1 THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(100.0 * SUM(CASE WHEN churn = 1 THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate
FROM customer_churnn;



--CHURN BY CONTRACT_TYPE

SELECT
  contract_type,
  count(*) AS total_customers,
  sum(churn)AS churned_customers,
   round(avg(churn)*100,2)AS churn_rate
   from customer_churnn
   group by contract_type
   order by churn_rate desc;

--"INSIGHT"MONTH TO MONTH CUSTOMER JYDA CHURN KR RHE H..
--PROBLEM
👉SHORT TERM CUSTOMER ARE UNSTABLE..
--SOLUTION
👉DISCOUNT ON LONG_TERM PLAN.
👉SUBSCRIPTION ON 6/12 MONTH..


--TENURE SEGMENTATION

SELECT 
    CASE 
        WHEN tenure < 12 THEN '0-1 Year'
        WHEN tenure BETWEEN 12 AND 24 THEN '1-2 Year'
        ELSE '2+ Year'
    END AS tenure_group,
	ROUND(AVG(churn)*100,2) AS churn_rate,
    COUNT(*) AS total,
    SUM(CASE WHEN churn = 1 THEN 1 ELSE 0 END) AS churned
FROM customer_churnn
GROUP BY tenure_group;

--"INSIGHT “Tenure alone is not a strong predictor of 
churn in this dataset, as churn rates remain consistently 
high across all tenure groups. This suggests deeper issues 
like pricing or service quality. The business should shift 
from tenure-based strategies to behavioral and service-based segmentation.”"
--PROBLEMS..
👉CUSTOMER RETENTION STRATEGY FAIL HO RHI H.
--SOLUTION
👉LOYAL CUSTOMERS RETENTION PLAN(2+YEARS)
.LOYALITY REWARDS.
.DISCOUNT/OFFERS.
.PERSONALIZED COMMUNUCATION.



--REVENUE LOSS

SELECT
   sum(monthly_charges)AS monthly_loss,
   sum(monthly_charges)*12 AS yearly_loss
   from customer_churnn
   where churn = 1;


--HIGH RISK CUSTOMERS....


SELECT *
FROM customer_churnn
WHERE monthly_charges > (SELECT AVG(monthly_charges) FROM customer_churnn)
AND tenure < (SELECT AVG(tenure) FROM customer_churnn)
AND churn = 1;



--SUPPORT CALL IMPACT....


SELECT 
support_calls,
COUNT(*) AS total,
SUM(churn) AS churned,
ROUND(AVG(churn)*100,2) AS churn_rate
FROM customer_churnn
GROUP BY support_calls
ORDER BY churn_rate DESC;

INSIGHT"Customer with more support calls are more likely
to churn".
--PROBLEM
👉CUSTOMER DISSATISFACTION..
--SOLUTION
👉IMPROVE CUSTOMER SERVICE..
👉FASTER RESOLUTION SYSTEM..


--WINDOW FUNCTION....

SELECT 
customer_id,
monthly_charges,
RANK() OVER (ORDER BY monthly_charges DESC) AS rank_by_charge
FROM customer_churnn;


SELECT 
    COUNT(*) AS total_customers,
    SUM(CASE WHEN churn = 1 THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(100.0 * SUM(CASE WHEN churn = 1 THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate
FROM customer_churnn;

-- "INSIGHT"68% CUSTOMERS ARE LEAVING THE COMPANY"
--👉PROBLEM
HIGH CHURN = COMPANY LOSS
--👉SOLUTION
RETENTION STRATEGY..
OFFERS FOR LOYAL CUSTOMERS..


--MONTHLY_CHAREGES Vs CHURN..

SELECT 
CASE 
    WHEN Monthly_Charges < 300 THEN 'Low'
    WHEN Monthly_Charges BETWEEN 300 AND 600 THEN 'Medium'
    ELSE 'High'
END AS charge_group,
COUNT(*) AS total,
SUM(CASE WHEN Churn= 1 THEN 1 ELSE 0 END) AS churned
FROM customer_churnn
GROUP BY charge_group;

INSIGHT = "HIGH PAYING CUSTOMERS SHOW HIGHER CHURN"
--PROBLEM.
👉CUSTOMERS FEELS PRICING IS NOT JUSTIFIED..
--SOLUTION
👉PERSONALIZED PLANS
👉ADD MORE VALUE(FEATURES/SERVICES).



--INTERNET SERVICE IMPACT..

SELECT Internet_Service,
COUNT(*) AS total,
SUM(CASE WHEN Churn= 1 THEN 1 ELSE 0 END) AS churned
FROM customer_churnn
GROUP BY Internet_Service;

--💡INSIGHT:
“Fiber users churn more than DSL users.”
--❗problem:
Service quality issues
--✅SOLUTION:
.Improve fiber network quality..
.Offer compensation..























































