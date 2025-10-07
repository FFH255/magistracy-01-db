SELECT
    e.name_enrollee as "Абитуриент",
    SUM(COALESCE(a.bonus, 0)) as "Дополнительные баллы"
FROM enrollee e
LEFT JOIN enrollee_achievement ea
ON e.enrollee_id = ea.enrollee_id
LEFT JOIN achievement a
ON ea.achievement_id = a.achievement_id
GROUP BY e.name_enrollee
ORDER BY  e.name_enrollee