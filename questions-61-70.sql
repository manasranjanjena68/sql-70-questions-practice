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
