SELECT
    p.name_program AS "Образовательная программа",
    ps.min_result AS "Минимальный балл"
FROM program_subject ps
INNER JOIN program p ON ps.program_id = p.program_id
INNER JOIN subject s ON ps.subject_id = s.subject_id
WHERE s.name_subject = 'Математика'
ORDER BY p.name_program;