show databases;
use ishk;
select * from superm;
/*unique customers*/
select count(DISTINCT Customer_id) AS unique_customer
FROM superm;


select distinct Ship_Mode from superm as cat;
select distinct Category from superm as ship;
select count(distinct Sub_Category) from superm;

select distinct Category, count(sales) from superm
group by Category;
select distinct Category, count(quantity) from superm
group by Category;
/* highest sales: Office supplies
Least sales: Furniture*/

select distinct Ship_Mode, count(sales) from superm
group by Ship_Mode;
/* highest sales: std class
followed by First and Second class */


show databases;
