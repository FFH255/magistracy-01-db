-- Вывести абитуриентов, которые хотят поступать на определенную образовательную программу.

CREATE OR REPLACE FUNCTION get_enrollees_by_program(p_program_id INT)
    RETURNS TABLE (
                      enrollee_id INT,
                      name_enrollee VARCHAR
                  )
    LANGUAGE sql
AS $$
SELECT e.enrollee_id, e.name_enrollee
FROM enrollee e
    JOIN program_enrollee pe ON pe.enrollee_id = e.enrollee_id
WHERE pe.program_id = p_program_id
    ORDER BY e.name_enrollee;
$$;

SELECT * FROM get_enrollees_by_program(1);