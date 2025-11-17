-- Вывести образовательные программы, минимальные баллы по каждому предмету
-- которых, превышают заданное значение.

CREATE OR REPLACE FUNCTION get_programs_where_results_is_greater_that(result INT)
    RETURNS TABLE (
                        program_id INT,
                        program_name VARCHAR
                  )
    LANGUAGE sql
AS $$
SELECT
    p.program_id as program_id,
    p.name_program as program_name
FROM program p
    INNER JOIN program_subject ps
        ON p.program_id = ps.program_id
GROUP BY p.program_id, p.name_program
HAVING MIN(ps.min_result) > result
ORDER BY p.name_program;
$$;

SELECT * FROM get_programs_where_results_is_greater_that(70);