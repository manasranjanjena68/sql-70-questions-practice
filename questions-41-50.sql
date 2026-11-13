 
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
