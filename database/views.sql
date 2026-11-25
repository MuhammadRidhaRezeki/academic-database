-- academic-database — reporting views
-- Run after database/schema.sql and database/seed.sql:
--   psql -U postgres -d academic_db -f database/views.sql
--
-- Grade-point scale (Indonesian system):
--   A = 4.0 | AB = 3.5 | B = 3.0 | BC = 2.5 | C = 2.0 | D = 1.0 | E = 0.0
-- GPA (IPK) = SUM(grade_point * credits) / SUM(credits)

-- ---------------------------------------------------------------------------
-- grade_point: letter grade -> grade point
-- ---------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION grade_point(p_grade CHAR(2))
RETURNS NUMERIC(3,1)
LANGUAGE sql IMMUTABLE AS
$$
    SELECT CASE p_grade
        WHEN 'A'  THEN 4.0
        WHEN 'AB' THEN 3.5
        WHEN 'B'  THEN 3.0
        WHEN 'BC' THEN 2.5
        WHEN 'C'  THEN 2.0
        WHEN 'D'  THEN 1.0
        WHEN 'E'  THEN 0.0
        ELSE NULL
    END;
$$;

COMMENT ON FUNCTION grade_point(CHAR) IS 'Maps an Indonesian letter grade to its grade point (A=4.0 … E=0.0).';

-- ---------------------------------------------------------------------------
-- v_student_gpa: GPA (IPK), total SKS and passed SKS per student
-- ---------------------------------------------------------------------------
CREATE OR REPLACE VIEW v_student_gpa AS
SELECT
    s.id,
    s.nim,
    s.name,
    s.major,
    s.enrollment_year,
    COUNT(e.id)                                   AS courses_taken,
    COALESCE(SUM(c.credits), 0)                   AS total_sks,
    COALESCE(SUM(c.credits) FILTER (WHERE e.grade <> 'E'), 0) AS passed_sks,
    ROUND(
        COALESCE(
            SUM(grade_point(e.grade) * c.credits) / NULLIF(SUM(c.credits), 0),
            0
        ), 2
    )                                             AS gpa
FROM students s
LEFT JOIN enrollments e ON e.student_id = s.id
LEFT JOIN courses c     ON c.id = e.course_id
GROUP BY s.id, s.nim, s.name, s.major, s.enrollment_year;

COMMENT ON VIEW v_student_gpa IS 'One row per student: courses taken, total and passed SKS, and GPA (IPK).';

-- ---------------------------------------------------------------------------
-- v_course_statistics: average score, pass rate and enrollment count per course
-- ---------------------------------------------------------------------------
CREATE OR REPLACE VIEW v_course_statistics AS
SELECT
    c.id,
    c.code,
    c.name,
    l.name                                        AS lecturer,
    c.credits,
    COUNT(e.id)                                   AS students_enrolled,
    ROUND(AVG(e.score), 2)                        AS avg_score,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE e.grade NOT IN ('D', 'E'))
        / NULLIF(COUNT(*), 0), 1
    )                                             AS pass_rate_pct
FROM courses c
LEFT JOIN lecturers l  ON l.id = c.lecturer_id
LEFT JOIN enrollments e ON e.course_id = c.id
GROUP BY c.id, c.code, c.name, l.name, c.credits;

COMMENT ON VIEW v_course_statistics IS 'One row per course: enrollment count, average score, and pass rate (grades above D).';

-- ---------------------------------------------------------------------------
-- v_transcript: full grade list per student, ready for a transcript printout
-- ---------------------------------------------------------------------------
CREATE OR REPLACE VIEW v_transcript AS
SELECT
    s.nim,
    s.name                                        AS student_name,
    e.semester,
    c.code                                        AS course_code,
    c.name                                        AS course_name,
    c.credits,
    e.score,
    e.grade,
    grade_point(e.grade)                          AS grade_point
FROM students s
JOIN enrollments e ON e.student_id = s.id
JOIN courses c     ON c.id = e.course_id
ORDER BY s.nim, e.semester, c.code;

COMMENT ON VIEW v_transcript IS 'Every grade, ordered by student and semester — the raw material for a printed transcript (KHS).';
