-- Вывести абитуриентов, которые не могут быть зачислены на образовательную
-- программу.

CREATE OR REPLACE FUNCTION get_rejected_enrollees_of(pid INT)
    RETURNS TABLE (
                        enrollee_id INT,
                        enrollee_name VARCHAR
                  )
    LANGUAGE sql
AS $$
    SELECT
        e.enrollee_id as enrollee_id,
        e.name_enrollee as enrollee_name
    FROM enrollee e
             INNER JOIN enrollee_subject es
                        USING (enrollee_id)
             INNER JOIN program_subject ps
                        USING(subject_id)
    WHERE es.result < ps.min_result
      AND ps.program_id = pid;
$$;

SELECT * from get_rejected_enrollees_of(8);