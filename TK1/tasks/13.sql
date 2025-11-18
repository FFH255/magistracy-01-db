-- Абитуриентам, у которых есть медаль или значок ГТО, добавляются
-- дополнительные баллы.
-- https://stepik.org/lesson/310420/step/4?unit=292726

UPDATE applicant
SET itog = itog + enrollee_bonus.bonus
FROM (
         SELECT
             ea.enrollee_id as enrollee_id,
             SUM(bonus) as bonus
         FROM enrollee_achievement ea
                  LEFT JOIN achievement a USING(achievement_id)
         GROUP BY ea.enrollee_id
     ) enrollee_bonus
WHERE applicant.enrollee_id = enrollee_bonus.enrollee_id;

SELECT * FROM applicant;