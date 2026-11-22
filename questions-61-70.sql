-- =========================================
-- QTN - 61
-- Show the company_name, contact_name, fax number
-- of all customers that have a fax number (not null).

SELECT
    company_name,
    contact_name,
    fax
FROM customers
WHERE fax IS NOT NULL;


-- =========================================
-- QTN - 62
-- Show the first_name, last_name, hire_date
-- of the most recently hired employee.

SELECT
    first_name,
    last_name,
    MAX(hire_date)
FROM employees;


-- =========================================
-- QTN - 63
-- Show the average unit price rounded to 2 decimal places,
-- the total units in stock, total discontinued products
-- from the products table.

SELECT
    ROUND(AVG(unit_price), 2) AS average_price,
    SUM(units_in_stock) AS total_stock,
    SUM(discontinued) AS total_discontinued
FROM products;


-- =========================================
-- QTN - 64
-- Show the ProductName, CompanyName, CategoryName
-- from the products, suppliers, and categories table.

SELECT
    p.product_name,
    s.company_name,
    c.category_name
FROM categories AS c
JOIN products AS p
    ON c.category_id = p.category_id
JOIN suppliers AS s
    ON p.supplier_id = s.supplier_id;


-- =========================================
-- QTN - 65
-- Show the category_name and the average product unit price
-- for each category rounded to 2 decimal places.

SELECT
    category_name,
    ROUND(AVG(unit_price), 2) AS average_unit_price
FROM categories AS c
JOIN products AS p
    ON c.category_id = p.category_id
GROUP BY p.category_id;


-- =========================================
-- QTN - 66
-- Show the city, company_name, contact_name
-- from the customers and suppliers table merged together.
-- Create a column which contains 'customers' or 'suppliers'
-- depending on the table it came from.

SELECT
    city,
    company_name,
    contact_name,
    'customers' AS relationship
FROM customers

UNION

SELECT
    city,
    company_name,
    contact_name,
    'suppliers' AS relationship
FROM suppliers;


-- =========================================
-- QTN - 67
-- Show the total amount of orders for each year/month.

SELECT
    YEAR(order_date) AS order_year,
    MONTH(order_date) AS order_month,
    COUNT(*) AS no_of_orders
FROM orders
GROUP BY
    YEAR(order_date),
    MONTH(order_date);


-- =========================================
-- QTN - 68
-- Show the employee's first_name and last_name,
-- a "num_orders" column with a count of the orders taken,
-- and a column called "Shipped" that displays:
-- 'On Time' if shipped_date is less than or equal to required_date,
-- 'Late' if the order shipped late,
-- 'Not Shipped' if shipped_date is null.
--
-- Order by employee last_name, then by first_name,
-- and then descending by number of orders.

SELECT
    e.first_name,
    e.last_name,
    COUNT(o.order_id) AS num_orders,
    CASE
        WHEN o.shipped_date <= o.required_date THEN 'On Time'
        WHEN o.shipped_date > o.required_date THEN 'Late'
        WHEN shipped_date IS NULL THEN 'Not Shipped'
    END AS shipped
FROM employees AS e
JOIN orders AS o
    ON e.employee_id = o.employee_id
GROUP BY
    first_name,
    last_name,
    shipped
ORDER BY
    e.last_name,
    e.first_name,
    num_orders DESC;


-- =========================================
-- QTN - 69
-- Show how much money the company lost due to giving discounts
-- each year.
-- Order the years from most recent to least recent.
-- Round to 2 decimal places.

SELECT
    YEAR(order_date) AS order_year,
    ROUND(SUM(p.unit_price * o.quantity * o.discount), 2) AS discount_amount
FROM order_details AS o
JOIN orders AS a
    ON o.order_id = a.order_id
JOIN products AS p
    ON o.product_id = p.product_id
GROUP BY order_year
ORDER BY order_year DESC;
