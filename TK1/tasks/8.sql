SELECT
    p.name_program AS "Образовательная программа"
FROM program p
    JOIN program_subject ps ON p.program_id = ps.program_id
    JOIN subject s ON ps.subject_id = s.subject_id
WHERE s.name_subject IN ('Математика', 'Информатика')
GROUP BY p.program_id, p.name_program
HAVING COUNT(DISTINCT s.subject_id) = 2
ORDER BY p.name_program;