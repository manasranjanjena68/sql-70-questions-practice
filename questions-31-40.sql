
-- =====================================================
-- SQL Practice: Hospital Database
-- Questions 31–40
-- SQL Dialect: MySQL
-- =====================================================


-- Q31. Show the difference between the largest and
-- smallest weight of patients with last name 'Maroni'.
-- Concept: MAX(), MIN(), subtraction

SELECT
    MAX(weight) - MIN(weight) AS weight_delta
FROM patients
WHERE last_name = 'Maroni';


-- Q32. Show the day of the month and the number of
-- admissions that occurred on each day.
-- Sort from most admissions to least.
-- Concept: DAY(), COUNT(), GROUP BY, ORDER BY

SELECT
    DAY(admission_date) AS day_number,
    COUNT(*) AS number_of_admissions
FROM admissions
GROUP BY DAY(admission_date)
ORDER BY number_of_admissions DESC,
         day_number ASC;


-- Q33. Show all columns for patient_id 542's
-- most recent admission.
-- Concept: ORDER BY, LIMIT

SELECT *
FROM admissions
WHERE patient_id = 542
ORDER BY admission_date DESC
LIMIT 1;


-- Q34. Show patient_id, attending_doctor_id, and
-- diagnosis for admissions matching either condition:
--
-- 1. patient_id is odd and attending_doctor_id is
--    1, 5, or 19.
-- 2. attending_doctor_id contains the digit 2
--    and patient_id has exactly 3 characters.
--
-- Concept: MOD(), IN, LIKE, CAST(), AND, OR

SELECT
    patient_id,
    attending_doctor_id,
    diagnosis
FROM admissions
WHERE
    (
        MOD(patient_id, 2) = 1
        AND attending_doctor_id IN (1, 5, 19)
    )
    OR
    (
        CAST(attending_doctor_id AS CHAR) LIKE '%2%'
        AND CHAR_LENGTH(CAST(patient_id AS CHAR)) = 3
    );


-- Q35. Show each doctor's first name, last name,
-- and total number of admissions attended.
-- Concept: INNER JOIN, COUNT(), GROUP BY

SELECT
    d.first_name,
    d.last_name,
    COUNT(*) AS admissions_total
FROM admissions AS a
INNER JOIN doctors AS d
    ON a.attending_doctor_id = d.doctor_id
GROUP BY
    d.doctor_id,
    d.first_name,
    d.last_name;


-- Q36. For each doctor, display their ID, full name,
-- first admission date, and last admission date.
-- Concept: CONCAT(), MIN(), MAX(), GROUP BY

SELECT
    d.doctor_id,
    CONCAT(d.first_name, ' ', d.last_name) AS full_name,
    MIN(a.admission_date) AS first_admission_date,
    MAX(a.admission_date) AS last_admission_date
FROM admissions AS a
INNER JOIN doctors AS d
    ON a.attending_doctor_id = d.doctor_id
GROUP BY
    d.doctor_id,
    d.first_name,
    d.last_name
ORDER BY d.doctor_id ASC;


-- Q37. Display the total number of patients
-- for each province, ordered from highest to lowest.
-- Concept: INNER JOIN, COUNT(), GROUP BY, ORDER BY

SELECT
    r.province_name,
    COUNT(*) AS patient_count
FROM patients AS p
INNER JOIN province_names AS r
    ON p.province_id = r.province_id
GROUP BY
    r.province_id,
    r.province_name
ORDER BY patient_count DESC,
         r.province_name ASC;


-- Q38. For every admission, display the patient's
-- full name, diagnosis, and attending doctor's full name.
-- Concept: Multiple INNER JOINs, CONCAT()

SELECT
    CONCAT(p.first_name, ' ', p.last_name) AS patient_name,
    a.diagnosis,
    CONCAT(d.first_name, ' ', d.last_name) AS doctor_name
FROM patients AS p
INNER JOIN admissions AS a
    ON p.patient_id = a.patient_id
INNER JOIN doctors AS d
    ON a.attending_doctor_id = d.doctor_id;


-- Q39. Display first name, last name, and the number
-- of duplicate patients based on identical full names.
-- Concept: GROUP BY, HAVING, COUNT()

SELECT
    first_name,
    last_name,
    COUNT(*) AS num_of_duplicates
FROM patients
GROUP BY first_name, last_name
HAVING COUNT(*) > 1;


-- Q40. Display patient's full name, height in feet
-- rounded to 1 decimal, weight in pounds rounded
-- to 0 decimals, birth date, and full gender.
--
-- Height: CM / 30.48 = Feet
-- Weight: KG * 2.205 = Pounds
--
-- Concept: CONCAT(), ROUND(), CASE

SELECT
    CONCAT(first_name, ' ', last_name) AS patient_name,
    ROUND(height / 30.48, 1) AS height_feet,
    ROUND(weight * 2.205, 0) AS weight_pounds,
    birth_date,
    CASE
        WHEN gender = 'M' THEN 'MALE'
        WHEN gender = 'F' THEN 'FEMALE'
        ELSE 'UNKNOWN'
    END AS gender_type
FROM patients;

