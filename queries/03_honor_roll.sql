-- 03_honor_roll.sql — students with GPA >= 3.50 (predikat Cumlaude track)
-- Usage: psql -U postgres -d academic_db -f queries/03_honor_roll.sql
--
-- A student qualifies with at least 10 SKS taken and a GPA of 3.50 or
-- higher. Adjust the thresholds below to match your campus rules.

SELECT
    nim,
    name,
    enrollment_year,
    total_sks,
    gpa,
    CASE
        WHEN gpa >= 3.75 THEN 'Cumlaude'
        WHEN gpa >= 3.50 THEN 'Sangat Memuaskan'
        ELSE 'Memuaskan'
    END AS predicate
FROM v_student_gpa
WHERE gpa >= 3.50
  AND total_sks >= 10
ORDER BY gpa DESC;
