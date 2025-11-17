-- Вывести статистическую информацию по каждому предмету ЕГЭ (минимальный и
-- максимальный балл, количество абитуриентов, которые этот предмет сдавали).

SELECT
    s.name_subject as subject_name,
    MIN(COALESCE(es.result, 0)) as min_result,
    MAX(COALESCE(es.result, 0)) as max_result,
    COUNT(*) as number_of_enrollees
FROM subject s
LEFT JOIN enrollee_subject es
ON es.subject_id = s.subject_id
GROUP BY s.name_subject
ORDER BY s.name_subject