use ishk;
CREATE TABLE superm (
    Id INT AUTO_INCREMENT,
    Order_id CHAR(20),
    Order_Date CHAR(20),
    Ship_Date CHAR(20),
    Ship_Mode CHAR(15),
    Customer_id CHAR(15),
    Name CHAR(50),
    Segment CHAR(50),
    Country CHAR(50),
    City CHAR(50),
    State CHAR(50),
    Postal_Code INT,
    Region CHAR(50),
    Product_id CHAR(50),
    Category CHAR(50),
    Sub_Category CHAR(50),
    Product_Name CHAR(100),
    Sales DOUBLE,
    Quantity INT,
    Discount DOUBLE,
    Profit DOUBLE,
    PRIMARY KEY (Id , order_id)
);
alter table superm
modify Order_Date date,
modify ship_Date date;


/*unique customers*/
SELECT 
    COUNT(DISTINCT Customer_id)
FROM
    superm;
+-----------------------------+
| count(distinct customer_id) |
+-----------------------------+
|                          79 |
+-----------------------------+


SELECT 
    YEAR(order_date) AS Order_year,
    SUM(quantity) AS Total_Quantity,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM
    superm
GROUP BY 1
ORDER BY 1;
+------------+----------------+--------------+
| Order_year | Total_Quantity | Total_Profit |
+------------+----------------+--------------+
|       2014 |            133 |      -1112.8 |
|       2015 |            166 |     -1553.73 |
|       2016 |            260 |         2446 |
|       2017 |             91 |       478.18 |
+------------+----------------+--------------+


SELECT DISTINCT
    Category, COUNT(quantity)
FROM
    superm
GROUP BY Category;
+-----------------+-----------------+
| Category        | COUNT(quantity) |                              
+-----------------+-----------------+                            
| Furniture       |              36 |
| Office Supplies |              98 |                              /*Most of orders are for Office Supplies.*/
| Technology      |              29 |                              
+-----------------+-----------------+

	
SELECT DISTINCT
    Ship_Mode, COUNT(sales)
FROM
    superm
GROUP BY Ship_Mode;
+----------------+--------------+
| Ship_Mode      | COUNT(sales) |
+----------------+--------------+
| Second Class   |           31 |
| Standard Class |          100 |                                  /*Nearly half of the orders are from
| First Class    |           32 |                                  Consumer segment using Standard Class shipment.*/
+----------------+--------------+

	
SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));
SELECT 
    category, state, Total_sales, rank() over (partition by category order by Total_sales desc) as ranks 
FROM(
	SELECT 
	    sum(sales) as Total_sales, state, category 
    FROM superm group by state, category) as twinkle 
    ORDER BY ranks 
	limit 9;
+-----------------+--------------+--------------------+-------+
| category        | state        | Total_sales        | ranks |
+-----------------+--------------+--------------------+-------+
| Furniture       | Pennsylvania |           3361.802 |     1 |
| Technology      | Texas        |           9628.664 |     1 |
| Office Supplies | California   | 1861.9940000000001 |     1 |
| Furniture       | California   |           2197.908 |     2 |
| Office Supplies | Arizona      |           1517.324 |     2 |
| Technology      | California   |            2210.19 |     2 |
| Furniture       | Wisconsin    |            1951.84 |     3 |
| Office Supplies | Missouri     |  839.4300000000001 |     3 |
| Technology      | New York     |            1059.95 |     3 |
+-----------------+--------------+--------------------+-------+


