-- 06_top_students_per_major.sql — top 3 students in each major (RANK)
-- Usage: psql -U postgres -d academic_db -f queries/06_top_students_per_major.sql
--
-- Uses the RANK() window function so ties share a rank. Change the
-- "rank <= 3" filter to widen or narrow the list.

SELECT nim, name, major, total_sks, gpa
FROM (
    SELECT
        nim,
        name,
        major,
        total_sks,
        gpa,
        RANK() OVER (PARTITION BY major ORDER BY gpa DESC) AS rank_in_major
    FROM v_student_gpa
    WHERE total_sks > 0
) ranked
WHERE rank_in_major <= 3
ORDER BY major, rank_in_major;
