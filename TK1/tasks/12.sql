-- Из таблицы удаляются абитуриенты, если они не набрали минимального балла по
-- предмету, необходимому для поступления на образовательную программу.
-- https://stepik.org/lesson/310420/step/3?unit=292726

DELETE FROM applicant a
    USING program_subject ps, enrollee_subject es
WHERE a.program_id = ps.program_id
  AND ps.subject_id = es.subject_id
  AND a.enrollee_id = es.enrollee_id
  AND ps.min_result > es.result;

SELECT * FROM applicant;