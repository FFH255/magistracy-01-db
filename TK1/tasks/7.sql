-- Вариант 1: Основной расчет конкурса (количество абитуриентов / план приема)
SELECT
    p.name_program AS "Образовательная программа",
    p.plan AS "План приема",
    COUNT(pe.enrollee_id) AS "Количество абитуриентов",
    ROUND(COUNT(pe.enrollee_id)::numeric / p.plan, 2) AS "Конкурс"
FROM program p
         LEFT JOIN program_enrollee pe ON p.program_id = pe.program_id
GROUP BY p.program_id, p.name_program, p.plan
ORDER BY "Конкурс" DESC;