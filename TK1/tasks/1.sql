SELECT
    e.name_enrollee AS Абитуриент
FROM
    enrollee e
INNER JOIN program_enrollee pe ON e.enrollee_id = pe.enrollee_id
INNER JOIN program p ON pe.program_id = p.program_id
WHERE p.name_program = 'Прикладная математика и информатика'
ORDER BY
    p.program_id;