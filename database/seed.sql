-- academic-database — seed data
-- Sample data for a Teknik Informatika program: 12 students, 4 lecturers,
-- 10 courses, 74 enrollments with scores and letter grades.
--
-- Run after database/schema.sql:
--   psql -U postgres -d academic_db -f database/seed.sql
--
-- The data is fictional and safe to reset: TRUNCATE ... RESTART IDENTITY
-- wipes it, then re-run this file.

-- ---------------------------------------------------------------------------
-- students
-- ---------------------------------------------------------------------------
INSERT INTO students (nim, name, email, major, enrollment_year) VALUES
('202301001', 'Ahmad Rizki Pratama',    'ahmad.rizki@student.polinela.ac.id', 'Teknik Informatika', 2023),
('202301002', 'Siti Nurhaliza',         'siti.nurhaliza@student.polinela.ac.id', 'Teknik Informatika', 2023),
('202301003', 'Budi Santoso',           'budi.santoso@student.polinela.ac.id', 'Teknik Informatika', 2023),
('202301004', 'Dewi Lestari',           'dewi.lestari@student.polinela.ac.id', 'Teknik Informatika', 2023),
('202301005', 'Agus Wijaya',            'agus.wijaya@student.polinela.ac.id', 'Teknik Informatika', 2023),
('202301006', 'Putri Ayu Lestari',      'putri.ayu@student.polinela.ac.id', 'Teknik Informatika', 2023),
('202301007', 'Muhammad Ridha Rezeki',  'ridha.rezeki@student.polinela.ac.id', 'Teknik Informatika', 2023),
('202301008', 'Rina Marlina',           'rina.marlina@student.polinela.ac.id', 'Teknik Informatika', 2023),
('202301009', 'Fajar Nugroho',          'fajar.nugroho@student.polinela.ac.id', 'Teknik Informatika', 2023),
('202301010', 'Maya Kusuma',            'maya.kusuma@student.polinela.ac.id', 'Teknik Informatika', 2023),
('202202011', 'Andi Prasetyo',          'andi.prasetyo@student.polinela.ac.id', 'Teknik Informatika', 2022),
('202202012', 'Lina Hartati',           'lina.hartati@student.polinela.ac.id', 'Teknik Informatika', 2022)
ON CONFLICT (nim) DO NOTHING;

-- ---------------------------------------------------------------------------
-- lecturers
-- ---------------------------------------------------------------------------
INSERT INTO lecturers (nidn, name, email, department) VALUES
('0012345678', 'Dr. Hendra Gunawan, S.T., M.T.', 'hendra.gunawan@polinela.ac.id', 'Teknik Informatika'),
('0012345679', 'Sari Puspita, S.Kom., M.Kom.',   'sari.puspita@polinela.ac.id',   'Teknik Informatika'),
('0012345680', 'Bambang Riyanto, S.T., M.Eng.',  'bambang.riyanto@polinela.ac.id','Teknik Informatika'),
('0012345681', 'Ratna Dewi, S.Si., M.Si.',       'ratna.dewi@polinela.ac.id',     'Teknik Informatika')
ON CONFLICT (nidn) DO NOTHING;

-- ---------------------------------------------------------------------------
-- courses
-- ---------------------------------------------------------------------------
INSERT INTO courses (code, name, credits, semester, lecturer_id) VALUES
('TI101', 'Pengantar Teknologi Informasi', 2, 1, 1),
('TI102', 'Algoritma dan Pemrograman',      3, 1, 2),
('TI103', 'Matematika Diskrit',             3, 1, 4),
('TI201', 'Basis Data',                     3, 2, 2),
('TI202', 'Pemrograman Web',                3, 2, 3),
('TI203', 'Jaringan Komputer',              3, 2, 1),
('TI301', 'Sistem Operasi',                 3, 3, 3),
('TI302', 'Rekayasa Perangkat Lunak',       3, 3, 2),
('TI303', 'Kecerdasan Buatan',              3, 3, 4),
('TI304', 'Keamanan Siber',                 2, 3, 1)
ON CONFLICT (code) DO NOTHING;

-- ---------------------------------------------------------------------------
-- enrollments (student_id, course_id, semester, score, grade)
-- Grade scale: A 85–100, AB 80–84, B 75–79, BC 70–74, C 60–69, D 50–59, E <50.
-- ---------------------------------------------------------------------------
INSERT INTO enrollments (student_id, course_id, semester, score, grade) VALUES
(1, 1, '2023/2024 Ganjil', 65, 'C'),
(1, 2, '2023/2024 Ganjil', 59, 'D'),
(1, 3, '2023/2024 Ganjil', 75, 'B'),
(1, 4, '2023/2024 Genap', 70, 'BC'),
(1, 5, '2023/2024 Genap', 69, 'C'),
(1, 6, '2023/2024 Genap', 63, 'C'),
(2, 1, '2023/2024 Ganjil', 64, 'C'),
(2, 2, '2023/2024 Ganjil', 92, 'A'),
(2, 3, '2023/2024 Ganjil', 63, 'C'),
(2, 4, '2023/2024 Genap', 92, 'A'),
(2, 5, '2023/2024 Genap', 82, 'AB'),
(2, 6, '2023/2024 Genap', 57, 'D'),
(3, 1, '2023/2024 Ganjil', 59, 'D'),
(3, 2, '2023/2024 Ganjil', 63, 'C'),
(3, 3, '2023/2024 Ganjil', 71, 'BC'),
(3, 4, '2023/2024 Genap', 69, 'C'),
(3, 5, '2023/2024 Genap', 87, 'A'),
(3, 6, '2023/2024 Genap', 93, 'A'),
(4, 1, '2023/2024 Ganjil', 59, 'D'),
(4, 2, '2023/2024 Ganjil', 93, 'A'),
(4, 3, '2023/2024 Ganjil', 70, 'BC'),
(4, 4, '2023/2024 Genap', 96, 'A'),
(4, 5, '2023/2024 Genap', 89, 'A'),
(4, 6, '2023/2024 Genap', 81, 'AB'),
(5, 1, '2023/2024 Ganjil', 72, 'BC'),
(5, 2, '2023/2024 Ganjil', 86, 'A'),
(5, 3, '2023/2024 Ganjil', 95, 'A'),
(5, 4, '2023/2024 Genap', 72, 'BC'),
(5, 5, '2023/2024 Genap', 55, 'D'),
(5, 6, '2023/2024 Genap', 65, 'C'),
(6, 1, '2023/2024 Ganjil', 85, 'A'),
(6, 2, '2023/2024 Ganjil', 79, 'B'),
(6, 3, '2023/2024 Ganjil', 75, 'B'),
(6, 4, '2023/2024 Genap', 64, 'C'),
(6, 5, '2023/2024 Genap', 68, 'C'),
(6, 6, '2023/2024 Genap', 76, 'B'),
(7, 1, '2023/2024 Ganjil', 64, 'C'),
(7, 2, '2023/2024 Ganjil', 63, 'C'),
(7, 3, '2023/2024 Ganjil', 82, 'AB'),
(7, 4, '2023/2024 Genap', 61, 'C'),
(7, 5, '2023/2024 Genap', 77, 'B'),
(7, 6, '2023/2024 Genap', 77, 'B'),
(8, 1, '2023/2024 Ganjil', 96, 'A'),
(8, 2, '2023/2024 Ganjil', 74, 'BC'),
(8, 3, '2023/2024 Ganjil', 60, 'C'),
(8, 4, '2023/2024 Genap', 84, 'AB'),
(8, 5, '2023/2024 Genap', 89, 'A'),
(8, 6, '2023/2024 Genap', 62, 'C'),
(9, 1, '2023/2024 Ganjil', 82, 'AB'),
(9, 2, '2023/2024 Ganjil', 63, 'C'),
(9, 3, '2023/2024 Ganjil', 93, 'A'),
(9, 4, '2023/2024 Genap', 73, 'BC'),
(9, 5, '2023/2024 Genap', 95, 'A'),
(9, 6, '2023/2024 Genap', 94, 'A'),
(10, 1, '2023/2024 Ganjil', 81, 'AB'),
(10, 2, '2023/2024 Ganjil', 94, 'A'),
(10, 3, '2023/2024 Ganjil', 70, 'BC'),
(10, 4, '2023/2024 Genap', 59, 'D'),
(10, 5, '2023/2024 Genap', 57, 'D'),
(10, 6, '2023/2024 Genap', 69, 'C'),
(1, 7, '2024/2025 Ganjil', 80, 'AB'),
(1, 8, '2024/2025 Ganjil', 67, 'C'),
(2, 7, '2024/2025 Ganjil', 76, 'B'),
(2, 8, '2024/2025 Ganjil', 68, 'C'),
(7, 7, '2024/2025 Ganjil', 86, 'A'),
(7, 8, '2024/2025 Ganjil', 79, 'B'),
(11, 7, '2024/2025 Ganjil', 89, 'A'),
(11, 8, '2024/2025 Ganjil', 83, 'AB'),
(11, 9, '2024/2025 Ganjil', 70, 'BC'),
(11, 10, '2024/2025 Ganjil', 83, 'AB'),
(12, 7, '2024/2025 Ganjil', 82, 'AB'),
(12, 8, '2024/2025 Ganjil', 73, 'BC'),
(12, 9, '2024/2025 Ganjil', 77, 'B'),
(12, 10, '2024/2025 Ganjil', 64, 'C')
ON CONFLICT (student_id, course_id, semester) DO NOTHING;
