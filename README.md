# academic-database

A **PostgreSQL academic database system** for courses and student grades:
schema for students, lecturers, courses and enrollments, seed data, reporting
views, and the reporting queries a campus actually runs — total credits (SKS),
GPA / IPK calculation, transcripts, honor roll, and grade distribution.

> From the portfolio of **Muhammad Ridha Rezeki** — Informatics Engineering
> student, Politeknik Negeri Lhokseumawe. See also
> [php-native-crud](https://github.com/MuhammadRidhaRezeki/php-native-crud)
> and [ai-response-ranker](https://github.com/MuhammadRidhaRezeki/ai-response-ranker).

## What is inside

| Path | Contents |
|---|---|
| `database/schema.sql` | Tables: `students`, `lecturers`, `courses`, `enrollments` (+ indexes) |
| `database/seed.sql` | Sample data: 12 students, 4 lecturers, 10 courses, 74 enrollments |
| `database/views.sql` | `grade_point()` function, `v_student_gpa`, `v_course_statistics`, `v_transcript` |
| `queries/` | 8 documented reporting queries (see below) |
| `docs/erd.md` | ER diagram and the Indonesian grade scale |

## Requirements

- PostgreSQL **14+**
- `psql` command-line client (comes with PostgreSQL)

## Quick start

```bash
# 1. Create the database
createdb academic_db

# 2. Create the tables
psql -U postgres -d academic_db -f database/schema.sql

# 3. Load the sample data
psql -U postgres -d academic_db -f database/seed.sql

# 4. Create the views and the grade_point() function
psql -U postgres -d academic_db -f database/views.sql

# 5. Run a report, e.g. GPA for every student
psql -U postgres -d academic_db -f queries/02_gpa_by_student.sql
```

To reset the sample data and start over:

```sql
TRUNCATE students, lecturers, courses, enrollments RESTART IDENTITY CASCADE;
```

then re-run `database/seed.sql`.

## Reporting queries

| File | Report |
|---|---|
| `queries/01_transcript.sql` | Full transcript (KHS) for one student + semester GPA (IPS). Pass `-v nim='202301007'`. |
| `queries/02_gpa_by_student.sql` | GPA (IPK), total SKS and passed SKS for every student. |
| `queries/03_honor_roll.sql` | Students with GPA ≥ 3.50 and ≥ 10 SKS, with predicate (Cumlaude / Sangat Memuaskan). |
| `queries/04_course_statistics.sql` | Average score and pass rate per course. |
| `queries/05_grade_distribution.sql` | How many of each letter grade (A–E) were given. |
| `queries/06_top_students_per_major.sql` | Top 3 students per major, using `RANK()`. |
| `queries/07_students_without_enrollments.sql` | Students with no grades yet. |
| `queries/08_semester_summary.sql` | Enrollments, students and average score per semester. |

## Example output

GPA for every student (`queries/02_gpa_by_student.sql`, top rows, seed data):

```
     nim     |         name          | courses_taken | total_sks | gpa
-------------+-----------------------+---------------+-----------+------
 202202011   | Andi Prasetyo         |             4 |        11 | 3.36
 202301009   | Fajar Nugroho         |             6 |        17 | 3.32
 202301004   | Dewi Lestari          |             6 |        17 | 3.29
 202301008   | Rina Marlina          |             6 |        17 | 2.94
 202301007   | Muhammad Ridha Rezeki |             8 |        23 | 2.85
```

Semester summary (`queries/08_semester_summary.sql`, seed data):

```
    semester     | enrollments | students | avg_score | avg_grade_point
-----------------+-------------+----------+-----------+-----------------
 2023/2024 Ganjil |          30 |       10 |     74.90 |            2.77
 2023/2024 Genap  |          30 |       10 |     74.83 |            2.70
 2024/2025 Ganjil |          14 |        5 |     76.93 |            3.00
```

## Grade scale

Indonesian letter grades, implemented in `grade_point()`:

| Score | Grade | Points |
|---|---|---|
| 85–100 | A | 4.0 |
| 80–84 | AB | 3.5 |
| 75–79 | B | 3.0 |
| 70–74 | BC | 2.5 |
| 60–69 | C | 2.0 |
| 50–59 | D | 1.0 |
| 0–49 | E | 0.0 |

GPA (IPK) = Σ(grade point × SKS) / Σ(SKS). A grade of E earns 0 points and
its SKS do not count as passed SKS.

## Project structure

```
academic-database/
├── database/
│   ├── schema.sql
│   ├── seed.sql
│   └── views.sql
├── docs/
│   └── erd.md
├── queries/
│   ├── 01_transcript.sql
│   ├── 02_gpa_by_student.sql
│   ├── 03_honor_roll.sql
│   ├── 04_course_statistics.sql
│   ├── 05_grade_distribution.sql
│   ├── 06_top_students_per_major.sql
│   ├── 07_students_without_enrollments.sql
│   └── 08_semester_summary.sql
├── LICENSE
└── README.md
```

## Roadmap

- [ ] Stored procedure to insert a grade with automatic letter-grade derivation from the score
- [ ] Attendance table and attendance-rate report
- [ ] Semester GPA (IPS) trend view per student
- [ ] Export helpers (transcript to CSV via `COPY`)

## License

MIT — see [LICENSE](LICENSE).
