# Entity–Relationship Diagram

```
students 1 ────< enrollments >──── 1 courses
   │                  │                 │
   │ id (PK)          │ student_id (FK) │ id (PK)
   │ nim (UNIQUE)     │ course_id (FK)  │ code (UNIQUE)
   │ name             │ semester        │ name
   │ email (UNIQUE)   │ score           │ credits (SKS)
   │ major            │ grade           │ semester
   │ enrollment_year  │                 │ lecturer_id (FK)
   │ status           │                 │
   └──────────────────┘                 │
                                        ▼
                                   lecturers
                                      id (PK)
                                      nidn (UNIQUE)
                                      name
                                      email (UNIQUE)
                                      department
```

## Relationships

| Relationship | Type | Rule |
|---|---|---|
| students → enrollments | 1 : N | Deleting a student deletes their enrollments (`ON DELETE CASCADE`). |
| courses → enrollments | 1 : N | Deleting a course deletes its enrollments (`ON DELETE CASCADE`). |
| lecturers → courses | 1 : N | Deleting a lecturer leaves the course but clears the lecturer (`ON DELETE SET NULL`). |
| enrollments uniqueness | — | One row per student + course + semester (`UNIQUE` constraint). |

## Grade scale (Indonesian system)

| Score | Grade | Grade point |
|---|---|---|
| 85–100 | A | 4.0 |
| 80–84 | AB | 3.5 |
| 75–79 | B | 3.0 |
| 70–74 | BC | 2.5 |
| 60–69 | C | 2.0 |
| 50–59 | D | 1.0 |
| 0–49 | E | 0.0 |

GPA (IPK) = Σ(grade point × SKS) / Σ(SKS). Implemented as the
`grade_point()` function and the `v_student_gpa` view in `database/views.sql`.
