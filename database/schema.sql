-- academic-database — schema
-- PostgreSQL 14+
-- Creates the `academic_db` database objects: students, lecturers, courses,
-- and enrollments (student grades per course per semester).
--
-- Run in order:
--   1. database/schema.sql   (this file)
--   2. database/seed.sql     (sample data)
--   3. database/views.sql    (reporting views)
--
--   psql -U postgres -d academic_db -f database/schema.sql

-- ---------------------------------------------------------------------------
-- students
-- ---------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS students (
    id              SERIAL PRIMARY KEY,
    nim             VARCHAR(12)  NOT NULL,
    name            VARCHAR(100) NOT NULL,
    email           VARCHAR(150) NOT NULL,
    major           VARCHAR(100) NOT NULL DEFAULT 'Teknik Informatika',
    enrollment_year SMALLINT     NOT NULL,
    status          VARCHAR(20)  NOT NULL DEFAULT 'active'
                    CHECK (status IN ('active', 'leave', 'graduated', 'dropped')),
    created_at      TIMESTAMPTZ  NOT NULL DEFAULT now(),
    updated_at      TIMESTAMPTZ  NOT NULL DEFAULT now(),
    UNIQUE (nim),
    UNIQUE (email)
);

COMMENT ON TABLE students IS 'Students (mahasiswa), identified by NIM.';
COMMENT ON COLUMN students.nim IS 'Nomor Induk Mahasiswa — unique student number.';

-- ---------------------------------------------------------------------------
-- lecturers
-- ---------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS lecturers (
    id         SERIAL PRIMARY KEY,
    nidn       VARCHAR(12)  NOT NULL,
    name       VARCHAR(100) NOT NULL,
    email      VARCHAR(150) NOT NULL,
    department VARCHAR(100) NOT NULL DEFAULT 'Teknik Informatika',
    created_at TIMESTAMPTZ  NOT NULL DEFAULT now(),
    UNIQUE (nidn),
    UNIQUE (email)
);

COMMENT ON TABLE lecturers IS 'Lecturers (dosen), identified by NIDN.';

-- ---------------------------------------------------------------------------
-- courses
-- ---------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS courses (
    id          SERIAL PRIMARY KEY,
    code        VARCHAR(10)  NOT NULL,
    name        VARCHAR(150) NOT NULL,
    credits     SMALLINT     NOT NULL CHECK (credits BETWEEN 1 AND 6),
    semester    SMALLINT     NOT NULL CHECK (semester BETWEEN 1 AND 8),
    lecturer_id INTEGER      REFERENCES lecturers (id) ON DELETE SET NULL,
    created_at  TIMESTAMPTZ  NOT NULL DEFAULT now(),
    UNIQUE (code)
);

COMMENT ON TABLE courses IS 'Courses (mata kuliah). credits = SKS.';
COMMENT ON COLUMN courses.credits IS 'Credit hours (SKS), usually 2–4.';

-- ---------------------------------------------------------------------------
-- enrollments (grades)
-- ---------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS enrollments (
    id         SERIAL PRIMARY KEY,
    student_id INTEGER      NOT NULL REFERENCES students (id) ON DELETE CASCADE,
    course_id  INTEGER      NOT NULL REFERENCES courses (id) ON DELETE CASCADE,
    semester   VARCHAR(20)  NOT NULL,
    score      NUMERIC(5,2) NOT NULL CHECK (score BETWEEN 0 AND 100),
    grade      CHAR(2)      NOT NULL
               CHECK (grade IN ('A', 'AB', 'B', 'BC', 'C', 'D', 'E')),
    created_at TIMESTAMPTZ  NOT NULL DEFAULT now(),
    UNIQUE (student_id, course_id, semester)
);

COMMENT ON TABLE enrollments IS 'One row per student per course per semester, with the final score and letter grade.';
COMMENT ON COLUMN enrollments.semester IS 'Academic semester label, e.g. ''2023/2024 Ganjil''.';
COMMENT ON COLUMN enrollments.grade IS 'Letter grade from the Indonesian scale: A, AB, B, BC, C, D, E.';

-- Indexes for the reporting queries
CREATE INDEX IF NOT EXISTS idx_enrollments_student ON enrollments (student_id);
CREATE INDEX IF NOT EXISTS idx_enrollments_course  ON enrollments (course_id);
CREATE INDEX IF NOT EXISTS idx_courses_lecturer    ON courses (lecturer_id);
