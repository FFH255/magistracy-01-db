-- Вывести образовательные программы, на которые для поступления необходим определенный предмет ЕГЭ

CREATE OR REPLACE FUNCTION get_programs_by_subject(subject_name VARCHAR)
    RETURNS TABLE (
                        program_id INT,
                        program_name VARCHAR
                  )
    LANGUAGE sql
AS $$
SELECT
    p.program_id as program_id,
    p.name_program AS program_name
FROM program_subject ps
         INNER JOIN program p ON ps.program_id = p.program_id
         INNER JOIN subject s ON ps.subject_id = s.subject_id
WHERE s.name_subject = subject_name
ORDER BY p.name_program;
$$;

SELECT * FROM get_programs_by_subject('Математика');