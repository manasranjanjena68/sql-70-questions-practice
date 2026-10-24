
-- SQL Practice: Hospital Database
-- Questions 1–10

-- Q1. Show first name, last name, and gender
-- of patients whose gender is 'M'.
SELECT first_name, last_name, gender
FROM patients
WHERE gender = 'M';


-- Q2. Show first name and last name of patients
-- who do not have allergies (NULL).
SELECT first_name, last_name
FROM patients
WHERE allergies IS NULL;


-- Q3. Show first names that start with 'C'.
SELECT first_name
FROM patients
WHERE first_name LIKE 'C%';


-- Q4. Show first name and last name of patients
-- whose weight is between 100 and 120 inclusive.
SELECT first_name, last_name
FROM patients
WHERE weight BETWEEN 100 AND 120;


-- Q5. Replace NULL allergies with 'NKA'.
UPDATE patients
SET allergies = 'NKA'
WHERE allergies IS NULL;


-- Q6. Concatenate first name and last name
-- into a full_name column.
SELECT CONCAT(first_name, ' ', last_name) AS full_name
FROM patients;


-- Q7. Show patient names and full province names.
SELECT p.first_name, p.last_name, pn.province_name
FROM patients AS p
JOIN province_names AS pn
    ON p.province_id = pn.province_id;


-- Q8. Count patients born in 2010.
SELECT COUNT(patient_id)
FROM patients
WHERE YEAR(birth_date) = 2010;


-- Q9. Show the names and height of the tallest patient(s).
SELECT first_name, last_name, height
FROM patients
WHERE height = (
    SELECT MAX(height)
    FROM patients
);


-- Q10. Show all columns for the specified patient IDs.
SELECT *
FROM patients
WHERE patient_id IN (1, 45, 534, 879, 1000);
