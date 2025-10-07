SELECT
    e.name_enrollee AS enrollee,
    p.name_program AS program,
    SUM(es.result) AS total_result
FROM enrollee e
    JOIN program_enrollee pe ON e.enrollee_id = pe.enrollee_id
    JOIN program p ON pe.program_id = p.program_id
    JOIN program_subject ps ON p.program_id = ps.program_id
    JOIN enrollee_subject es ON e.enrollee_id = es.enrollee_id
        AND ps.subject_id = es.subject_id
GROUP BY e.enrollee_id, e.name_enrollee, p.program_id, p.name_program
ORDER BY p.name_program, total_result DESC;