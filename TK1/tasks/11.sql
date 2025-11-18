-- Создается таблица с суммой баллов абитуриентов по предметам ЕГЭ в соответствии
-- с поданными заявлениями.
-- https://stepik.org/lesson/310420/step/2?unit=292726

CREATE TABLE applicant AS
SELECT
    pe.program_id as program_id,
    es.enrollee_id as enrollee_id,
    SUM(es.result) as itog
FROM program_enrollee pe
         INNER JOIN program_subject ps
                    ON pe.program_id = ps.program_id
         INNER JOIN enrollee_subject es
                    ON ps.subject_id = es.subject_id
WHERE pe.enrollee_id = es.enrollee_id
GROUP BY pe.program_id, es.enrollee_id
ORDER BY pe.program_id, itog desc;

DROP TABLE applicant;

SELECT * from applicant;