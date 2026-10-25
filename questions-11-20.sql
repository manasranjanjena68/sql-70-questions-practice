
-- =====================================================
-- SQL Practice: Hospital Database
-- Questions 11–20
-- =====================================================


-- Q11. Show the total number of admissions.
-- Concept: COUNT()

SELECT COUNT(*) AS total_admissions
FROM admissions;


-- Q12. Show all columns from admissions where the
-- patient was admitted and discharged on the same day.
-- Concept: WHERE with date comparison

SELECT *
FROM admissions
WHERE admission_date = discharge_date;


-- Q13. Show the patient_id and total number of
-- admissions for patient_id 579.
-- Concept: COUNT(), WHERE, GROUP BY

SELECT patient_id, COUNT(*) AS total_admissions
FROM admissions
WHERE patient_id = 579
GROUP BY patient_id;


-- Q14. Show unique cities of patients living
-- in province_id 'NS'.
-- Concept: DISTINCT, WHERE

SELECT DISTINCT city
FROM patients
WHERE province_id = 'NS';


-- Q15. Find the first name, last name, and birth date
-- of patients with height > 160 and weight > 70.
-- Concept: AND operator

SELECT first_name, last_name, birth_date
FROM patients
WHERE height > 160
  AND weight > 70;


-- Q16. Find patients from Hamilton whose allergies
-- are not NULL.
-- Concept: IS NOT NULL, AND

SELECT first_name, last_name, allergies
FROM patients
WHERE allergies IS NOT NULL
  AND city = 'Hamilton';


-- Q17. Show unique birth years in ascending order.
-- Concept: DISTINCT, YEAR(), ORDER BY

SELECT DISTINCT YEAR(birth_date) AS birth_year
FROM patients
ORDER BY birth_year ASC;


-- Q18. Show first names that occur exactly once.
-- Concept: GROUP BY, HAVING, COUNT()

SELECT first_name
FROM patients
GROUP BY first_name
HAVING COUNT(*) = 1;


-- Q19. Show patient_id and first_name where the
-- first name starts and ends with 's' and is at
-- least 6 characters long.
-- Concept: LIKE, CHAR_LENGTH()

SELECT patient_id, first_name
FROM patients
WHERE CHAR_LENGTH(first_name) >= 6
  AND LOWER(first_name) LIKE 's%s';


-- Q20. Show patient_id, first_name, and last_name
-- for patients diagnosed with 'Dementia'.
-- Primary diagnosis is stored in admissions.
-- Concept: INNER JOIN, WHERE

SELECT DISTINCT
       p.patient_id,
       p.first_name,
       p.last_name
FROM patients AS p
JOIN admissions AS a
    ON p.patient_id = a.patient_id
WHERE a.diagnosis = 'Dementia';

