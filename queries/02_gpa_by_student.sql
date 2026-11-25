-- 02_gpa_by_student.sql — GPA (IPK) and total SKS for every student
-- Usage: psql -U postgres -d academic_db -f queries/02_gpa_by_student.sql
--
-- Reads the v_student_gpa view (see database/views.sql). Students with no
-- enrollments yet show 0 SKS and a GPA of 0.00.

SELECT
    nim,
    name,
    enrollment_year,
    courses_taken,
    total_sks,
    passed_sks,
    gpa
FROM v_student_gpa
ORDER BY gpa DESC, name;
