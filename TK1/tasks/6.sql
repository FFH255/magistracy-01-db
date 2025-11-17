-- Посчитать, сколько дополнительных баллов получит каждый абитуриент.

SELECT
    e.name_enrollee as enrollee_name,
    SUM(COALESCE(a.bonus, 0)) as bonus
FROM enrollee e
LEFT JOIN enrollee_achievement ea
ON e.enrollee_id = ea.enrollee_id
LEFT JOIN achievement a
ON ea.achievement_id = a.achievement_id
GROUP BY e.name_enrollee
ORDER BY  e.name_enrollee