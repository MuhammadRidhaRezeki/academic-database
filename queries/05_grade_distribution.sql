-- 05_grade_distribution.sql — how many of each letter grade were given
-- Usage: psql -U postgres -d academic_db -f queries/05_grade_distribution.sql
--
-- Useful for spotting grade inflation or a course that grades unusually
-- harshly. The grade order follows the scale A, AB, B, BC, C, D, E.

SELECT
    e.grade,
    COUNT(*) AS total,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 1) AS pct_of_all
FROM enrollments e
GROUP BY e.grade
ORDER BY
    CASE e.grade
        WHEN 'A'  THEN 1
        WHEN 'AB' THEN 2
        WHEN 'B'  THEN 3
        WHEN 'BC' THEN 4
        WHEN 'C'  THEN 5
        WHEN 'D'  THEN 6
        WHEN 'E'  THEN 7
    END;
