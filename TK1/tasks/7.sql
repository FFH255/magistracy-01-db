-- Посчитать конкурс на каждую образовательную программу.

SELECT
    p.name_program AS program_name,
    p.plan AS plan,
    COUNT(pe.enrollee_id) AS enrolees_count,
    ROUND(COUNT(pe.enrollee_id)::numeric / p.plan, 2) AS contest_number
FROM program p
         LEFT JOIN program_enrollee pe ON p.program_id = pe.program_id
GROUP BY p.program_id, p.name_program, p.plan
ORDER BY contest_number DESC;