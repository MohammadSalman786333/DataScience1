[Q1] What is the distribution of customers across states?

SELECT state, COUNT(customer_id) as customer_count
FROM customer_t
GROUP BY state
ORDER BY customer_count DESC
LIMIT 5;

Result:-

state	customer_count
California	97
Texas	97
Florida	86
New York	69
District of Columbia	35



The query results provide information on the distribution of customers across states, showing the top 5 states with the highest customer counts. Here are some observations and findings based on the data:

1. **California and Texas**: California and Texas have the highest number of customers, both with 97 customers each. This suggests that these states likely have larger populations or stronger markets for the business.

2. **Florida**: Florida follows closely behind with 86 customers. This indicates a significant customer base in the state, possibly due to factors like population density, economic activity, or targeted marketing efforts.

3. **New York**: New York ranks fourth with 69 customers. Despite being a populous state, it has fewer customers compared to California, Texas, and Florida. This could be due to various factors such as competition, market saturation, or differing consumer behaviors.



-- [Q2] What is the average rating in each quarter?

SELECT
    CONCAT('Q', QUARTER(order_date)) AS quarter_number,
    AVG(customer_feedback) AS avg_customer_rating
FROM
    order_t
WHERE
    customer_feedback IS NOT NULL
GROUP BY
    CONCAT('Q', QUARTER(order_date))
ORDER BY
    CONCAT('Q', QUARTER(order_date));


Result:-
quarter_number
avg_customer_rating

Result:-
quarter_number	avg_customer_rating
Q1	0
Q2	0
Q3	0
Q4	0



Here are some observations and findings based on the provided schema of the `order_t` table:

1. **Primary Key**: The `order_id` column serves as the primary key in the table, ensuring each record has a unique identifier.

2. **Foreign Keys**: The `customer_id`, `shipper_id`, and `product_id` columns likely serve as foreign keys referencing other tables in the database, such as tables containing customer information, shipper information, and product information, respectively.

3. **Order Information**: The table includes various columns related to the order, such as the order quantity (`quantity`), vehicle price (`vehicle_price`), order date (`order_date`), shipment date (`ship_date`), discount applied (`discount`), shipping mode (`ship_mode`), and shipping details (`shipping`).


-- [Q3] Are customers getting more dissatisfied over time?


SELECT
    YEAR(order_date) AS year,
    QUARTER(order_date) AS quarter,
    AVG(customer_feedback) AS avg_customer_rating
FROM
    order_t
WHERE
    customer_feedback IS NOT NULL
GROUP BY
    YEAR(order_date),
    QUARTER(order_date)
ORDER BY
    YEAR(order_date),
    QUARTER(order_date);


Result:-

year	quarter	avg_customer_rating
2018	1	0
2018	2	0
2018	3	0
2018	4	0







To derive observations and findings from the query results, you would typically examine the trend in the average customer feedback ratings over time. Here's how you might interpret the findings:

1. **Trend Analysis**: Look for patterns or trends in the average customer feedback ratings over the quarters or years. Are the ratings generally increasing, decreasing, or staying stable over time?

2. **Positive or Negative Trends**: Determine if there is a noticeable positive or negative trend in customer satisfaction. A positive trend might indicate improving customer satisfaction, while a negative trend might suggest declining satisfaction.

3. **Seasonal Variations**: Check if there are any seasonal variations in customer feedback ratings. For example, are there specific quarters or years where ratings tend to be higher or lower?

4. **Outliers**: Identify any outliers or anomalies in the data. These could be quarters or years where the average rating significantly deviates from the overall trend.

5. **Correlation with Events**: Consider if any external events or changes within the company coincide with shifts in customer feedback ratings. For example, did the launch of a new product lead to an increase in satisfaction, or did a change in customer service policies result in a decline?


-- [Q4] Which are the top 5 vehicle makers preferred by the customer.


SELECT
    vehicle_maker,
    COUNT(*) AS product_count
FROM
    product_t
GROUP BY
    vehicle_maker

Result:-
vehicle_maker	product_count
Chevrolet	83
Ford	63
Toyota	52
Dodge	50
Pontiac	50








After executing the SQL query to identify the top 5 vehicle makers preferred by customers using the `product_t` table, here are the observations and findings:

1. **Top Vehicle Makers**: The query provides the top 5 vehicle makers preferred by customers based on the count of products associated with each maker.

2. **Customer Preferences**: By analyzing the results, we can observe which vehicle makers are most popular among customers. This insight can help businesses understand customer preferences and tailor their marketing and sales strategies accordingly.

3. **Market Insights**: The list of top vehicle makers can provide valuable market insights, indicating which brands have strong customer appeal and market demand. This information can inform business decisions related to inventory management, product offerings, and partnerships.

4. **Competitive Analysis**: Knowing the top vehicle makers preferred by customers allows businesses to assess their position in the market relative to competitors. It can highlight areas where they excel or where they may need to improve to remain competitive.

5. **Trend Identification**: Monitoring changes in customer preferences over time can help identify trends in the automotive industry. Businesses can use this information to anticipate shifts in demand and adapt their strategies proactively.








-- [Q5] What is the most preferred vehicle make in each state?


WITH RankedMakes AS (
    SELECT
        c.state,
        p.vehicle_maker,
        COUNT(*) AS make_count,
        ROW_NUMBER() OVER(PARTITION BY c.state ORDER BY COUNT(*) DESC) AS rank_num
    FROM
        order_t o
    JOIN
        customer_t c ON o.customer_id = c.customer_id
    JOIN
        product_t p ON o.product_id = p.product_id
    GROUP BY
        c.state, p.vehicle_maker
)
SELECT
    state,
    vehicle_maker AS most_preferred_make
FROM
    RankedMakes
WHERE
    rank_num = 1;

Result:-

state	most_preferred_make
Alabama	Dodge
Alaska	Chevrolet
Arizona	Pontiac
Arkansas	Suzuki
California	Ford
Colorado	Chevrolet
Connecticut	Chevrolet
Delaware	Mitsubishi
District of Columbia	Chevrolet
Florida	Toyota
Georgia	Toyota
Hawaii	Ford
Idaho	Dodge
Illinois	Ford
Indiana	Mazda
Iowa	Chrysler
Kansas	GMC
Kentucky	Acura
Louisiana	BMW
Maine	Mercedes-Benz
Maryland	Ford
Massachusetts	Dodge
Michigan	Ford
Minnesota	GMC
Mississippi	Dodge
Missouri	Chevrolet
Montana	Chevrolet
Nebraska	Chevrolet
Nevada	Pontiac
New Hampshire	Chrysler
New Jersey	Mercedes-Benz
New Mexico	Dodge
New York	Toyota
North Carolina	Volvo
North Dakota	Hyundai
Ohio	Chevrolet
Oklahoma	Toyota
Oregon	Toyota
Pennsylvania	Toyota
South Carolina	Acura
Tennessee	Mazda
Texas	Chevrolet
Utah	Maybach
Vermont	Mazda
Virginia	Ford
Washington	Chevrolet
West Virginia	Mercedes-Benz
Wisconsin	Pontiac
Wyoming	Buick




Certainly! Here are three observations and findings based on the provided SQL code for determining the most preferred vehicle make in each state:

1. **State-specific Vehicle Preferences**: The analysis reveals that customers in different states exhibit varying preferences for vehicle makes. By identifying the most preferred vehicle make in each state, automotive companies can tailor their marketing and sales strategies to target specific regions effectively. For example, if SUVs are preferred in one state while sedans are favored in another, manufacturers can adjust their inventory and promotional campaigns accordingly.

2. **Insights for Inventory Management**: Understanding state-level preferences can provide valuable insights for inventory management and dealership operations. Dealerships can use this information to optimize their vehicle inventory by stocking more of the preferred makes in each state. By aligning their inventory with customer preferences, dealerships can enhance customer satisfaction and increase sales.

3. **Competitive Analysis**: Analyzing the most preferred vehicle makes in each state also offers insights into market competition and brand positioning. By comparing the popularity of different vehicle makes across states, automotive companies can assess their market share and competitiveness relative to competitors. This information can inform strategic decisions related to branding, product development, and market expansion strategies.



-- [Q6] What is the trend of the number of orders by quarters?


SELECT 
    CONCAT(YEAR(order_date), 'Q', QUARTER(order_date)) AS quarter,
    COUNT(*) AS order_count
FROM 
    order_t
GROUP BY 
    CONCAT(YEAR(order_date), 'Q', QUARTER(order_date))
ORDER BY 
    CONCAT(YEAR(order_date), 'Q', QUARTER(order_date));


Result:-
quarter	order_count
2018Q1	310
2018Q2	262
2018Q3	229
2018Q4	199


The provided SQL query aggregates the number of orders by quarter, representing the trend of orders over time. Here are some observations and findings based on the query results:

1. **Quarterly Order Trends**: The query provides a breakdown of the number of orders placed in each quarter. Analyzing these trends can reveal seasonal patterns or fluctuations in customer demand over time. For instance, businesses may observe higher order counts during certain quarters, such as the holiday season, while experiencing lower activity in others.

2. **Seasonal Variations**: By examining the quarterly order counts, businesses can identify seasonal variations in customer purchasing behavior. For example, there may be a surge in orders during the spring and summer months, corresponding to increased consumer activity in these seasons. Understanding these patterns allows businesses to adjust their marketing strategies and inventory management practices accordingly.

3. **Performance Evaluation**: Comparing the order counts across quarters enables businesses to evaluate their performance and track progress over time. Increasing order counts from quarter to quarter may indicate business growth and success, while declining or stagnant order counts may signal challenges or areas for improvement.

.





 [Q7] What is the quarter-over-quarter % change in revenue?

WITH RevenueByQuarter AS (
    SELECT 
        CONCAT(YEAR(order_date), 'Q', QUARTER(order_date)) AS quarter,
        SUM(vehicle_price) AS total_revenue
    FROM 
        order_t
    GROUP BY 
        CONCAT(YEAR(order_date), 'Q', QUARTER(order_date))
)
SELECT 
    quarter,
    total_revenue,
    ROUND((total_revenue - LAG(total_revenue) OVER (ORDER BY quarter)) / LAG(total_revenue) OVER (ORDER BY quarter) * 100, 2) AS qoq_percentage_change
FROM 
    RevenueByQuarter;

Result:-
quarter	total_revenue	qoq_percentage_change
2018Q1	26519199.19	NULL
2018Q2	21595874.35	-18.57
2018Q3	19719917.59	-8.69
2018Q4	15280009.98	-22.51




The provided SQL query calculates the total revenue for each quarter and then computes the quarter-over-quarter (QoQ) percentage change in revenue. Here are some observations and findings based on the query results:

1. **Revenue Trends**: The query provides insights into the revenue trends over time by quarter. Analyzing these trends allows businesses to understand the fluctuations in revenue and identify periods of growth or decline. For example, consistent increases in revenue from quarter to quarter may indicate business expansion or successful marketing initiatives, while decreases may signal challenges or shifts in market demand.

2. **Quarter-over-Quarter Changes**: By calculating the QoQ percentage change in revenue, businesses can assess the rate of revenue growth or decline between consecutive quarters. Positive percentage changes indicate revenue growth, while negative changes suggest a decline in revenue. Understanding these changes helps businesses track performance and adapt their strategies accordingly.

3. **Seasonal Patterns**: The QoQ analysis can reveal seasonal patterns or cyclical trends in revenue. For instance, businesses may observe higher revenue during certain quarters, such as the holiday season, due to increased consumer spending. Identifying these seasonal patterns allows businesses to anticipate fluctuations in revenue and plan accordingly, such as adjusting inventory levels or staffing.


-- [Q8] What is the trend of revenue and orders by quarters?


SELECT 
    CONCAT(YEAR(order_date), 'Q', QUARTER(order_date)) AS quarter,
    SUM(vehicle_price) AS total_revenue,
    COUNT(*) AS order_count
FROM 
    order_t
GROUP BY 
    CONCAT(YEAR(order_date), 'Q', QUARTER(order_date))
ORDER BY 
    CONCAT(YEAR(order_date), 'Q', QUARTER(order_date));


Result:-
quarter	total_revenue	order_count
2018Q1	26519199.19	310
2018Q2	21595874.35	262
2018Q3	19719917.59	229
2018Q4	15280009.98	199




The provided SQL query aggregates the total revenue and the number of orders for each quarter. Let's analyze the observations and findings based on the query results:

1. **Quarterly Revenue Analysis**: The query breaks down the total revenue generated in each quarter, providing insights into the financial performance over time. Analyzing the quarterly revenue trends allows businesses to identify peak periods of sales and revenue growth, as well as slower periods of activity.

2. **Order Count Comparison**: In addition to revenue, the query also calculates the total number of orders placed in each quarter. Comparing the order counts across quarters helps businesses understand the relationship between sales volume and revenue generation. For instance, a quarter with a higher number of orders may not necessarily result in higher revenue if the average order value is lower.

3. **Seasonal Patterns**: By examining the quarterly revenue and order counts, businesses can identify seasonal patterns or trends in customer behavior. For example, they may observe increased sales during certain quarters due to holidays, promotions, or seasonal demand for specific products or services. Understanding these patterns allows businesses to adjust their marketing strategies and inventory management practices accordingly.







-- [Q9] What is the average discount offered for different types of credit cards?



SELECT
    c.credit_card_type,
    SUM(o.discount) AS total_discount_amount
FROM
    order_t o
JOIN
    customer_t c ON o.customer_id = c.customer_id
WHERE
    o.discount > 0  -- Consider orders with non-zero discounts
GROUP BY
    c.credit_card_type;

Result:-
credit_card_type	total_discount_amount
jcb	257.53
visa-electron	30.55
switch	26.24
diners-club-carte-blanche	30.11
laser	16.74
china-unionpay	28.62
diners-club-enroute	28.79
americanexpress	30.2
mastercard	50.36
visa	21.63
bankcard	26.82
solo	4.68
maestro	39.95
diners-club-us-ca	7.99
instapayment	9.93
diners-club-international	2.92









Certainly! Here are some observations and findings based on the provided SQL query to calculate the total discount amount for each credit card type:

1. **Distribution of Discount Amount**: The query reveals the distribution of total discount amounts across different credit card types. By analyzing this distribution, businesses can gain insights into which types of credit cards are associated with higher or lower discount amounts. This information can be valuable for understanding customer preferences and behaviors related to payment methods.

2. **Effectiveness of Promotions**: Higher total discount amounts for certain credit card types may indicate the effectiveness of promotional offers or incentives associated with those cards. Businesses can use this insight to assess the impact of specific promotions on customer spending behavior and adjust marketing strategies accordingly to optimize promotional efforts.

3. **Customer Segmentation**: The total discount amounts associated with different credit card types can also inform customer segmentation strategies. Businesses may identify segments of customers who are more responsive to discounts and promotions, allowing for targeted marketing campaigns tailored to those segments. Understanding which credit card types are associated with higher discount amounts can help refine segmentation criteria and personalize marketing messages to enhance engagement and conversion rates.



-- [Q10] What is the average time taken to ship the placed orders for each quarter?

SELECT 
    CONCAT(YEAR(order_date), 'Q', QUARTER(order_date)) AS quarter,
    AVG(DATEDIFF(ship_date, order_date)) AS avg_shipping_time
FROM 
    order_t
WHERE 
    ship_date IS NOT NULL
GROUP BY 
    CONCAT(YEAR(order_date), 'Q', QUARTER(order_date))
ORDER BY 
    CONCAT(YEAR(order_date), 'Q', QUARTER(order_date));

Result:-
quarter	avg_shipping_time
2018Q1	57.1677
2018Q2	71.1107
2018Q3	117.7555
2018Q4	174.0955


Certainly! Here are some observations and findings based on the provided SQL query to calculate the total discount amount for each credit card type:

1. **Variation in Discount Usage**: The analysis reveals variations in the total discount amounts associated with different credit card types. Businesses can observe which credit card types are more frequently used for transactions involving discounts. This information can be useful for understanding customer preferences and behaviors related to payment methods and discount utilization.

2. **Effectiveness of Discount Programs**: Higher total discount amounts for certain credit card types may indicate the effectiveness of discount programs or promotional offers associated with those cards. Businesses can assess the performance of their discount programs and promotions, identifying which credit card types yield the highest discount amounts and evaluating the return on investment (ROI) of these initiatives.

3. **Customer Behavior Insights**: Analyzing discount usage by credit card type provides insights into customer behavior and purchasing patterns. Businesses can identify segments of customers who are more inclined to redeem discounts, enabling targeted marketing efforts to encourage repeat purchases and loyalty among these segments. Understanding which credit card types are associated with higher discount amounts can inform personalized marketing strategies tailored to specific customer segments.


