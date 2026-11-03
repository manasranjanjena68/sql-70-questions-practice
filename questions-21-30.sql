
-- =====================================================
-- SQL Practice: Hospital Database
-- Questions 21–30
-- SQL Dialect: MySQL
-- =====================================================


-- Q20. Show patient_id, first_name, and last_name
-- of patients diagnosed with 'Dementia'.
-- Primary diagnosis is stored in admissions.
-- Concept: INNER JOIN, DISTINCT, WHERE

SELECT DISTINCT
    p.patient_id,
    p.first_name,
    p.last_name
FROM patients AS p
INNER JOIN admissions AS a
    ON p.patient_id = a.patient_id
WHERE a.diagnosis = 'Dementia';


-- Q21. Display every patient's first_name.
-- Order by name length, then alphabetically.
-- Concept: CHAR_LENGTH(), ORDER BY

SELECT first_name
FROM patients
ORDER BY CHAR_LENGTH(first_name) ASC,
         first_name ASC;


-- Q22. Show the total number of male and female
-- patients in the same row.
-- Concept: COUNT(), scalar subqueries

SELECT
    (SELECT COUNT(*)
     FROM patients
     WHERE gender = 'M') AS male_count,

    (SELECT COUNT(*)
     FROM patients
     WHERE gender = 'F') AS female_count;


-- Q23. Show first_name, last_name, and allergies
-- for patients allergic to Penicillin or Morphine.
-- Order by allergies, first_name, and last_name.
-- Concept: IN, ORDER BY

SELECT first_name, last_name, allergies
FROM patients
WHERE allergies IN ('Penicillin', 'Morphine')
ORDER BY allergies ASC,
         first_name ASC,
         last_name ASC;


-- Q24. Find patients admitted multiple times
-- for the same diagnosis.
-- Concept: GROUP BY, HAVING, COUNT()

SELECT patient_id, diagnosis
FROM admissions
GROUP BY patient_id, diagnosis
HAVING COUNT(*) > 1;


-- Q25. Show each city and its total number of patients.
-- Order from most patients to least, then city ascending.
-- Concept: GROUP BY, COUNT(), ORDER BY

SELECT
    city,
    COUNT(*) AS num_patients
FROM patients
GROUP BY city
ORDER BY num_patients DESC,
         city ASC;


-- Q26. Show first_name, last_name, and role
-- for every person who is either a patient or doctor.
-- Concept: UNION ALL

SELECT
    first_name,
    last_name,
    'Patient' AS role
FROM patients

UNION ALL

SELECT
    first_name,
    last_name,
    'Doctor' AS role
FROM doctors;


-- Q27. Show all allergies ordered by popularity.
-- Exclude NULL allergy values.
-- Concept: GROUP BY, COUNT(), IS NOT NULL

SELECT
    allergies,
    COUNT(*) AS total_patients
FROM patients
WHERE allergies IS NOT NULL
GROUP BY allergies
ORDER BY total_patients DESC;


-- Q28. Show patients born during the 1970s.
-- Sort from earliest birth_date.
-- Concept: Date filtering, ORDER BY

SELECT first_name, last_name, birth_date
FROM patients
WHERE birth_date >= '1970-01-01'
  AND birth_date < '1980-01-01'
ORDER BY birth_date ASC;


-- Q29. Display last_name in uppercase followed by
-- first_name in lowercase, separated by a comma.
-- Order by first_name in descending order.
-- Concept: CONCAT(), UPPER(), LOWER(), ORDER BY

SELECT
    CONCAT(UPPER(last_name), ',', LOWER(first_name))
    AS new_name_format
FROM patients
ORDER BY first_name DESC;


-- Q30. Show province_id and total patient height
-- for provinces where the total height is >= 7000.
-- Concept: SUM(), GROUP BY, HAVING

SELECT
    province_id,
    SUM(height) AS sum_height
FROM patients
GROUP BY province_id
HAVING SUM(height) >= 7000;

