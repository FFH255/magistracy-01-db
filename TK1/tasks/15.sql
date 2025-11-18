-- Формируется список абитуриентов, рекомендованных к зачислению (вставляется
-- столбец для нумерации, осуществляется нумерация студентов по образовательной
-- программе, выбираются абитуриенты с наибольшими баллами в соответствии с планом
-- набора).
-- https://stepik.org/lesson/310420/step/6?unit=292726

-- add rank column
ALTER TABLE applicant_order ADD rank INT;

-- ranking
UPDATE applicant_order
SET rank = ranked.rank
FROM (
         SELECT
             program_id,
             enrollee_id,
             ROW_NUMBER() OVER (PARTITION BY program_id ORDER BY enrollee_id) as rank
         FROM applicant_order
     ) AS ranked
WHERE applicant_order.program_id = ranked.program_id
  AND applicant_order.enrollee_id = ranked.enrollee_id;

SELECT * FROM applicant_order;

-- create students table
CREATE TABLE student
AS (
    SELECT
        p.name_program as name_program,
        e.name_enrollee as name_enrollee,
        ao.itog as itog
    FROM enrollee e
             INNER JOIN applicant_order ao
                        USING(enrollee_id)
             INNER JOIN program p
                        USING(program_id)
    WHERE ao.rank <= p.plan
    ORDER BY p.name_program, ao.itog desc
);

SELECT * FROM student;