-- 08_semester_summary.sql — enrollment and average-score summary per semester
-- Usage: psql -U postgres -d academic_db -f queries/08_semester_summary.sql
--
-- One row per semester label: how many enrollments, how many distinct
-- students, and the average score that semester.

SELECT
    e.semester,
    COUNT(*)              AS enrollments,
    COUNT(DISTINCT e.student_id) AS students,
    ROUND(AVG(e.score), 2)       AS avg_score,
    ROUND(AVG(grade_point(e.grade)), 2) AS avg_grade_point
FROM enrollments e
GROUP BY e.semester
ORDER BY e.semester;
