SELECT
    s.name_subject,
    MIN(COALESCE(es.result, 0)),
    MAX(COALESCE(es.result, 0))
FROM subject s
LEFT JOIN enrollee_subject es
ON es.subject_id = s.subject_id
GROUP BY s.name_subject
ORDER BY s.name_subject