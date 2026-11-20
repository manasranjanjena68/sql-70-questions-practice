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
