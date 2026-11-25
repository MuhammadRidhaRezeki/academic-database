-- 07_students_without_enrollments.sql — students with no grades yet
-- Usage: psql -U postgres -d academic_db -f queries/07_students_without_enrollments.sql
--
-- Finds students who enrolled in the program but have not taken any
-- course — for example new students, or records that need follow-up.

SELECT
    s.nim,
    s.name,
    s.enrollment_year,
    s.status
FROM students s
LEFT JOIN enrollments e ON e.student_id = s.id
WHERE e.id IS NULL
ORDER BY s.enrollment_year, s.name;
