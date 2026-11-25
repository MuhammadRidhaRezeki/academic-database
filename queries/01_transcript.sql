-- 01_transcript.sql — full transcript (KHS) for one student
-- Usage: psql -U postgres -d academic_db -v nim='202301007' -f queries/01_transcript.sql
--
-- Lists every course the student took, grouped by semester, with score,
-- letter grade, grade point, and the semester GPA (IPS) at the end of
-- each semester block.

SELECT
    e.semester,
    c.code        AS course_code,
    c.name        AS course_name,
    c.credits     AS sks,
    e.score,
    e.grade,
    grade_point(e.grade) AS grade_point
FROM students s
JOIN enrollments e ON e.student_id = s.id
JOIN courses c     ON c.id = e.course_id
WHERE s.nim = :'nim'
ORDER BY e.semester, c.code;

-- Semester GPA (IPS) for the same student:
SELECT
    e.semester,
    SUM(c.credits) AS sks,
    ROUND(SUM(grade_point(e.grade) * c.credits) / SUM(c.credits), 2) AS ips
FROM students s
JOIN enrollments e ON e.student_id = s.id
JOIN courses c     ON c.id = e.course_id
WHERE s.nim = :'nim'
GROUP BY e.semester
ORDER BY e.semester;
