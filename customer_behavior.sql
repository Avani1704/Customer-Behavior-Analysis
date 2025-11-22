SELECT gender, SUM(purchase_amount) AS revenue
FROM customer
GROUP BY gender;

--
select customer_id,purchase_amount
from customer
where discount_applied ='Yes' and purchase_amount >= (select AVG(purchase_amount) from customer)

--
select item_purchased,AVG (review_rating) as "Average  Product Rating"
from customer
group by item_purchased
order by avg(review_rating)desc
limit 5;

--
SELECT shipping_type,
       ROUND(AVG(purchase_amount), 2) AS avg_purchase
FROM customer
WHERE shipping_type IN ('Standard', 'Express')
GROUP BY shipping_type;

--
SELECT shipping_type,
       ROUND(AVG(purchase_amount), 2) AS avg_purchase
FROM customer
WHERE shipping_type IN ('Standard', 'Express')
GROUP BY shipping_type;

--
SELECT shipping_type,
       ROUND(AVG(purchase_amount), 2) AS avg_purchase
FROM customer
WHERE shipping_type IN ('Standard', 'Express')
GROUP BY shipping_type;

--
with customer_type as (
select customer_id,previous_purchase,
Case
    When previous_purchases = 1 THEN 'New'
when previous_purchases BETWEEN 2 AND 10 THEN 'Returning'
else 'loyal'
end as customer_segment
from customer
)
select customer_segment ,count(*) as "number of Customer"
from customer_type
group by customer_segment

--
WITH customer_type AS (
    SELECT customer_id,
           previous_purchases,
           CASE
               WHEN previous_purchases = 1 THEN 'New'
               WHEN previous_purchases BETWEEN 2 AND 10 THEN 'Returning'
               ELSE 'Loyal'
           END AS customer_segment
    FROM customer
)
SELECT customer_segment,
       COUNT(*) AS "number of customers"
FROM customer_type
GROUP BY customer_segment;

--
with item_counts as (
select category,
item_purchased,
COUNT(customer_id) as total_order,
ROE_NUMBER() OVER (partition by category oder by count (customer_id) DESC)as item_rank
from Customer
group by category,item_purchased
)
slelect item_rank,category,item_purchased,total_orders
from items_counts
where item_rank <= 3;

)

--
WITH customer_type AS (
    SELECT customer_id,
           previous_purchases,
           CASE
               WHEN previous_purchases = 1 THEN 'New'
               WHEN previous_purchases BETWEEN 2 AND 10 THEN 'Returning'
               ELSE 'Loyal'
           END AS customer_segment
    FROM customer
),
ranked_customers AS (
    SELECT customer_segment,
           customer_id,
           ROW_NUMBER() OVER (PARTITION BY customer_segment ORDER BY previous_purchases DESC) AS rn
    FROM customer_type
)
SELECT *
FROM ranked_customers
WHERE rn = 1;

--
SELECT subscription_status,
       COUNT(customer_id) AS repeat_buyers
FROM customer
WHERE previous_purchases > 5
GROUP BY subscription_status;


--
select age_group,
SUM(purchase_amount)as total_revenue
from customer
group by age_group
order by total_revenue desc;