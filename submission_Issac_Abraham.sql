/*

-----------------------------------------------------------------------------------------------------------------------------------
													    Guidelines
-----------------------------------------------------------------------------------------------------------------------------------

The provided document is a guide for the project. Follow the instructions and take the necessary steps to finish
the project in the SQL file			

-----------------------------------------------------------------------------------------------------------------------------------
                                                         Queries
                                               
-----------------------------------------------------------------------------------------------------------------------------------*/
  
/*-- QUESTIONS RELATED TO CUSTOMERS
     [Q1] What is the distribution of customers across states?
     Hint: For each state, count the number of customers.*/
     -- Query to retrieve the distribution of customers across states
USE newwheels;
SELECT state, COUNT(DISTINCT customer_id) AS customer_count
FROM customer_t
GROUP BY state;


-- ---------------------------------------------------------------------------------------------------------------------------------

/* [Q2] What is the average rating in each quarter?
-- Very Bad is 1, Bad is 2, Okay is 3, Good is 4, Very Good is 5.

Hint: Use a common table expression and in that CTE, assign numbers to the different customer ratings. 
      Now average the feedback for each quarter. 
-- Query to calculate the average rating in each quarter using a subquery */
use newwheels;
SELECT
  quarter_number,
  AVG(
    CASE customer_feedback
      WHEN 'Very Bad' THEN 1
      WHEN 'Bad' THEN 2
      WHEN 'Okay' THEN 3
      WHEN 'Good' THEN 4
      WHEN 'Very Good' THEN 5
      ELSE NULL
    END
  ) AS average_rating
FROM order_t
WHERE customer_feedback IS NOT NULL
GROUP BY quarter_number
ORDER BY quarter_number;

-- ---------------------------------------------------------------------------------------------------------------------------------

/* [Q3] Are customers getting more dissatisfied over time?

Hint: Need the percentage of different types of customer feedback in each quarter. Use a common table expression and
	  determine the number of customer feedback in each category as well as the total number of customer feedback in each quarter.
	  Now use that common table expression to find out the percentage of different types of customer feedback in each quarter.
      Eg: (total number of very good feedback/total customer feedback)* 100 gives you the percentage of very good feedback. */
	
-- Query to calculate the percentage of different types of customer feedback in each quarter using subqueries
SELECT
  quarter_number,
  (COUNT(CASE WHEN customer_feedback = 'Very Bad' THEN 1 END) / COUNT(*) * 100) AS percentage_very_bad,
  (COUNT(CASE WHEN customer_feedback = 'Bad' THEN 1 END) / COUNT(*) * 100) AS percentage_bad,
  (COUNT(CASE WHEN customer_feedback = 'Okay' THEN 1 END) / COUNT(*) * 100) AS percentage_okay,
  (COUNT(CASE WHEN customer_feedback = 'Good' THEN 1 END) / COUNT(*) * 100) AS percentage_good,
  (COUNT(CASE WHEN customer_feedback = 'Very Good' THEN 1 END) / COUNT(*) * 100) AS percentage_very_good
FROM order_t
WHERE customer_feedback IS NOT NULL
GROUP BY quarter_number
ORDER BY quarter_number;

-- ---------------------------------------------------------------------------------------------------------------------------------

/*[Q4] Which are the top 5 vehicle makers preferred by the customer.

Hint: For each vehicle make what is the count of the customers.*/
-- Query to find the top 5 vehicle makers preferred by customers
use newwheels;
SELECT
  p.vehicle_maker,
  COUNT(DISTINCT c.customer_id) AS customer_count
FROM product_t p
JOIN order_t o ON p.product_id = o.product_id
JOIN customer_t c ON o.customer_id = c.customer_id
GROUP BY p.vehicle_maker
ORDER BY customer_count DESC
LIMIT 5;


-- ---------------------------------------------------------------------------------------------------------------------------------

/*[Q5] What is the most preferred vehicle make in each state?

Hint: Use the window function RANK() to rank based on the count of customers for each state and vehicle maker. 
After ranking, take the vehicle maker whose rank is 1.*/
-- Query to find the most preferred vehicle make in each state
use newwheels;
SELECT
  state,
  vehicle_maker
FROM (
  SELECT
    state,
    vehicle_maker,
    ROW_NUMBER() OVER (PARTITION BY state ORDER BY COUNT(DISTINCT c.customer_id) DESC) AS row_num
  FROM product_t p
  JOIN order_t o ON p.product_id = o.product_id
  JOIN customer_t c ON o.customer_id = c.customer_id
  GROUP BY state, vehicle_maker
) AS ranked
WHERE row_num = 1;
-- ---------------------------------------------------------------------------------------------------------------------------------

/*QUESTIONS RELATED TO REVENUE and ORDERS 

-- [Q6] What is the trend of number of orders by quarters?

Hint: Count the number of orders for each quarter.*/
use newwheels;
SELECT
  quarter_number,
  COUNT(DISTINCT order_id) AS num_orders
FROM order_t
GROUP BY quarter_number
ORDER BY quarter_number;


-- ---------------------------------------------------------------------------------------------------------------------------------

/* [Q7] What is the quarter over quarter % change in revenue? 

Hint: Quarter over Quarter percentage change in revenue means what is the change in revenue from the subsequent quarter to the previous quarter in percentage.
      To calculate you need to use the common table expression to find out the sum of revenue for each quarter.
      Then use that CTE along with the LAG function to calculate the QoQ percentage change in revenue.
*/
    -- Common Table Expression (CTE) to calculate the sum of revenue for each quarter
use newwheels;
-- Common Table Expression (CTE) to compute the sum of revenue for each quarter
WITH QuarterlyRevenue AS (
  SELECT
    quarter_number,
    SUM(QUANTITY * VEHICLE_PRICE * (1 - DISCOUNT)) AS total_revenue
  FROM order_t
  GROUP BY quarter_number
)

-- Query to calculate the quarter-over-quarter % change in revenue
SELECT
  quarter_number,
  total_revenue,
  LAG(total_revenue) OVER (ORDER BY quarter_number) AS previous_quarter_revenue,
  ROUND((total_revenue - LAG(total_revenue) OVER (ORDER BY quarter_number)) / LAG(total_revenue) OVER (ORDER BY quarter_number) * 100, 2) AS qoq_percentage_change
FROM QuarterlyRevenue
ORDER BY quarter_number;      

-- ---------------------------------------------------------------------------------------------------------------------------------

/* [Q8] What is the trend of revenue and orders by quarters?

Hint: Find out the sum of revenue and count the number of orders for each quarter.*/
use newwheels;
-- Query to calculate the sum of revenue and count of orders for each quarter
SELECT
  o.quarter_number,
  SUM(o.QUANTITY * p.VEHICLE_PRICE * (1 - o.DISCOUNT)) AS total_revenue,
  COUNT(DISTINCT o.order_id) AS num_orders
FROM order_t o
JOIN product_t p ON o.product_id = p.product_id
GROUP BY o.quarter_number
ORDER BY o.quarter_number;

-- ---------------------------------------------------------------------------------------------------------------------------------

/* QUESTIONS RELATED TO SHIPPING 
    [Q9] What is the average discount offered for different types of credit cards?

Hint: Find out the average of discount for each credit card type.*/
use newwheels;
-- Query to calculate the average discount for each credit card type
SELECT
  c.credit_card_type,
  AVG(o.discount) AS average_discount
FROM order_t o
JOIN customer_t c ON o.customer_id = c.customer_id
GROUP BY c.credit_card_type;




-- ---------------------------------------------------------------------------------------------------------------------------------

/* [Q10] What is the average time taken to ship the placed orders for each quarters?
	Hint: Use the dateiff function to find the difference between the ship date and the order date.
*/
use newwheels;
-- Query to calculate the average time taken to ship orders for each quarter
SELECT
  quarter_number,
  AVG(DATEDIFF(ship_date, order_date)) AS average_ship_time
FROM order_t
GROUP BY quarter_number;

-- --------------------------------------------------------Done----------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------------------------------------------



