 
-- =====================================================
-- SQL Practice: Hospital Database
-- Questions 41–50
-- =====================================================


-- Q41. Show patient_id, first_name, last_name from
-- patients who do not have any records in admissions.

SELECT
    p.patient_id,
    p.first_name,
    p.last_name,
    a.patient_id
FROM patients AS p
LEFT JOIN admissions AS a
    ON p.patient_id = a.patient_id
WHERE a.patient_id IS NULL;


-- Q42. Display a single row with max_visits,
-- min_visits, and average_visits where the maximum,
-- minimum, and average number of admissions per day
-- is calculated. Average is rounded to 2 decimal places.

SELECT
    (
        SELECT COUNT(patient_id) AS max_visits
        FROM admissions
        GROUP BY admission_date
        ORDER BY max_visits DESC
        LIMIT 1
    ) AS max_visits,

    (
        SELECT COUNT(patient_id) AS min_visits
        FROM admissions
        GROUP BY admission_date
        ORDER BY min_visits ASC
        LIMIT 1
    ) AS min_visits,

    (
        SELECT ROUND(AVG(average_visits), 2)
        FROM (
            SELECT COUNT(patient_id) AS average_visits
            FROM admissions
            GROUP BY admission_date
        ) AS daily_counts
    ) AS average_visits;


-- Q43. Show patients with at least one admission
-- and their most recent admission along with
-- the patient's and doctor's full names.

SELECT
    CONCAT(p.first_name, ' ', p.last_name) AS patient_name,
    MAX(a.admission_date) AS admission_date,
    CONCAT(d.first_name, ' ', d.last_name) AS doctor_name
FROM patients AS p
JOIN admissions AS a
    ON p.patient_id = a.patient_id
JOIN doctors AS d
    ON a.attending_doctor_id = d.doctor_id
GROUP BY p.patient_id
HAVING COUNT(a.admission_date) >= 1;


-- =========================================
-- QTN - 44
-- Show all of the patients grouped into weight groups.
-- Show the total amount of patients in each weight group.
-- Order the list by the weight group descending.

SELECT
    COUNT(*) AS patients_in_group,
    FLOOR(weight / 10) * 10 AS weight_group
FROM patients
GROUP BY weight_group
ORDER BY weight DESC;


-- =========================================
-- QTN - 45
-- Show patient_id, weight, height, isObese from the patients table.
-- Display isObese as a boolean 0 or 1.

SELECT
    patient_id,
    weight,
    height,
    weight / POWER(height / 100.0, 2) >= 30 AS isObese
FROM patients;


-- =========================================
-- QTN - 46
-- Show patient_id, first_name, last_name, and attending doctor's specialty.
-- Show only patients who have a diagnosis as 'Epilepsy'
-- and the doctor's first name is 'Lisa'.

SELECT
    p.patient_id,
    p.first_name AS patient_first_name,
    p.last_name AS patient_last_name,
    d.specialty
FROM patients AS p
JOIN admissions AS a
    ON p.patient_id = a.patient_id
JOIN doctors AS d
    ON a.attending_doctor_id = d.doctor_id
WHERE a.diagnosis = 'Epilepsy'
    AND d.first_name = 'Lisa';


-- =========================================
-- QTN - 47
-- Show the patient_id and temporary password.
-- Password order:
-- 1. patient_id
-- 2. Numerical length of patient's last_name
-- 3. Year of patient's birth_date

SELECT DISTINCT
    p.patient_id,
    CONCAT(
        p.patient_id,
        LEN(p.last_name),
        YEAR(p.birth_date)
    ) AS temp_password
FROM patients AS p
JOIN admissions AS a
    ON p.patient_id = a.patient_id
WHERE a.patient_id IS NOT NULL;


-- =========================================
-- QTN - 48
-- Each admission costs $50 for patients without insurance,
-- and $10 for patients with insurance.
-- All patients with an even patient_id have insurance.
--
-- Give each patient a 'Yes' if they have insurance,
-- and a 'No' if they don't have insurance.
-- Add up the admission_total cost for each has_insurance group.

SELECT
    (
        CASE
            WHEN patient_id % 2 = 0 THEN 'Yes'
            ELSE 'No'
        END
    ) AS has_insurance,

    SUM(
        CASE
            WHEN patient_id % 2 = 0 THEN 10
            ELSE 50
        END
    ) AS cost_after_insurance

FROM admissions
GROUP BY has_insurance;


-- =========================================
-- QTN - 49
-- Show the provinces that have more patients identified
-- as 'M' than 'F'.
-- Must only show full province_name.

SELECT
    pn.province_name
FROM patients AS p
JOIN province_names AS pn
    ON p.province_id = pn.province_id
GROUP BY province_name
HAVING
    COUNT(CASE WHEN p.gender = 'M' THEN 1 END) >
    COUNT(CASE WHEN p.gender = 'F' THEN 1 END);


-- =========================================
-- QTN - 50
-- We are looking for a specific patient.
-- Pull all columns for the patient who matches the following criteria:
-- 1. First_name contains an 'r' after the first two letters.
-- 2. Identifies their gender as 'F'.
-- 3. Born in February, May, or December.
-- 4. Their weight would be between 60kg and 80kg.
-- 5. Their patient_id is an odd number.
-- 6. They are from the city 'Kingston'.

SELECT *
FROM patients
WHERE (first_name LIKE '__r%')
    AND (gender = 'F')
    AND (MONTH(birth_date) IN (02, 05, 12))
    AND (weight BETWEEN 60 AND 80)
    AND (patient_id % 2 != 0)
    AND (city = 'Kingston');
