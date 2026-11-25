-- 04_course_statistics.sql — average score and pass rate per course
-- Usage: psql -U postgres -d academic_db -f queries/04_course_statistics.sql
--
-- Reads the v_course_statistics view (see database/views.sql). Pass rate
-- counts grades above D (A, AB, B, BC, C) as passing.

SELECT
    code,
    name,
    lecturer,
    credits AS sks,
    students_enrolled,
    avg_score,
    pass_rate_pct
FROM v_course_statistics
ORDER BY avg_score DESC;
