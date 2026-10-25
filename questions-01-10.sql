
-- =====================================================
-- SQL Practice: Hospital Database
-- Questions 1–10
-- SQL Dialect: MySQL
-- =====================================================


-- Q1. Show the first name, last name, and gender
-- of patients whose gender is 'M'.
-- Concept: SELECT, WHERE

SELECT first_name, last_name, gender
FROM patients
WHERE gender = 'M';


-- Q2. Show the first name and last name of patients
-- who do not have allergies (NULL).
-- Concept: IS NULL

SELECT first_name, last_name
FROM patients
WHERE allergies IS NULL;


-- Q3. Show the first names of patients that start
-- with the letter 'C'.
-- Concept: LIKE, wildcard %

SELECT first_name
FROM patients
WHERE first_name LIKE 'C%';


-- Q4. Show the first name and last name of patients
-- whose weight is between 100 and 120 inclusive.
-- Concept: BETWEEN

SELECT first_name, last_name
FROM patients
WHERE weight BETWEEN 100 AND 120;


-- Q5. Replace NULL allergy values with 'NKA'.
-- Concept: UPDATE, SET, IS NULL
-- Note: This query modifies data in the table.

UPDATE patients
SET allergies = 'NKA'
WHERE allergies IS NULL;


-- Q6. Combine first name and last name into one
-- column named full_name.
-- Concept: CONCAT(), column alias

SELECT CONCAT(first_name, ' ', last_name) AS full_name
FROM patients;


-- Q7. Show patient first names, last names, and
-- their full province names.
-- Concept: INNER JOIN

SELECT
    p.first_name,
    p.last_name,
    pn.province_name
FROM patients AS p
INNER JOIN province_names AS pn
    ON p.province_id = pn.province_id;


-- Q8. Count patients born in the year 2010.
-- Concept: COUNT(), YEAR()

SELECT COUNT(*) AS total_patients
FROM patients
WHERE YEAR(birth_date) = 2010;


-- Q9. Show the first name, last name, and height
-- of the tallest patient(s).
-- Concept: MAX(), subquery

SELECT first_name, last_name, height
FROM patients
WHERE height = (
    SELECT MAX(height)
    FROM patients
);


-- Q10. Show all columns for patients whose IDs
-- are 1, 45, 534, 879, or 1000.
-- Concept: IN operator

SELECT *
FROM patients
WHERE patient_id IN (1, 45, 534, 879, 1000);
