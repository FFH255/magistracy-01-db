-- Абитуриенты сортируются в соответствии с набранными баллами по каждой
-- образовательной программе;
-- https://stepik.org/lesson/310420/step/5?unit=292726

CREATE TABLE applicant_order
AS
SELECT * FROM applicant a
ORDER BY program_id, itog desc;

DROP TABLE applicant;

SELECT * FROM applicant_order;