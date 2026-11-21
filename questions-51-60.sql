-- =========================================
-- QTN - 51
-- Show the percent of patients that have 'M' as their gender.
-- Round the answer to the nearest hundredth number
-- and display it in percent form.

SELECT
    CONCAT(
        ROUND(
            (
                SELECT COUNT(*)
                FROM patients
                WHERE gender = 'M'
            ) / CAST(COUNT(*) AS FLOAT) * 100,
            2
        ),
        '%'
    ) AS percent_of_male_patients
FROM patients;


-- =========================================
-- QTN - 52
-- For each day display the total amount of admissions on that day.
-- Display the amount changed from the previous date.

SELECT
    admission_date,
    COUNT(*) AS admission_day,
    COUNT(admission_date) - LAG(COUNT(admission_date))
        OVER (ORDER BY admission_date) AS admission_count_change
FROM admissions
GROUP BY admission_date;


-- =========================================
-- QTN - 53
-- Sort the province names in ascending order
-- in such a way that the province 'Ontario' is always on top.

SELECT
    province_name
FROM province_names
ORDER BY (
    CASE
        WHEN province_name = 'Ontario' THEN 1
        ELSE province_name
    END
);


-- =========================================
-- QTN - 54
-- We need a breakdown for the total amount of admissions
-- each doctor has started each year.
-- Show doctor_id, doctor_full_name, specialty, year,
-- total_admissions for that year.

SELECT
    d.doctor_id,
    CONCAT(d.first_name, ' ', d.last_name) AS doctor_name,
    d.specialty,
    YEAR(a.admission_date) AS selected_year,
    COUNT(*) AS total_admission
FROM doctors AS d
JOIN admissions AS a
    ON d.doctor_id = a.attending_doctor_id
GROUP BY doctor_name, selected_year;


-- =========================================
-- QTN - 55
-- Show the category_name and description
-- from the categories table sorted by category_name.

SELECT
    category_name,
    description
FROM categories
ORDER BY category_name;


-- =========================================
-- QTN - 56
-- Show all the contact_name, address, city of all customers
-- which are not from 'Germany', 'Mexico', 'Spain'.

SELECT
    contact_name,
    address,
    city
FROM customers
WHERE country NOT IN ('Germany', 'Mexico', 'Spain');


-- =========================================
-- QTN - 57
-- Show order_date, shipped_date, customer_id, Freight
-- of all orders placed on 2018 Feb 26.

SELECT
    order_date,
    shipped_date,
    customer_id,
    freight
FROM orders
WHERE order_date = '2018-02-26';


-- =========================================
-- QTN - 58
-- Show the employee_id, order_id, customer_id,
-- required_date, shipped_date from all orders
-- shipped later than the required date.

SELECT
    employee_id,
    order_id,
    customer_id,
    required_date,
    shipped_date
FROM orders
WHERE required_date < shipped_date;


-- =========================================
-- QTN - 59
-- Show all the even numbered Order_id
-- from the orders table.

SELECT
    order_id
FROM orders
WHERE order_id % 2 = 0;


-- =========================================
-- QTN - 60
-- Show the city, company_name, contact_name of all customers
-- from cities which contains the letter 'L' in the city name,
-- sorted by contact_name.

SELECT
    city,
    company_name,
    contact_name
FROM customers
WHERE city LIKE '%L%'
ORDER BY contact_name;
