-- Вывести образовательные программы, на которые для поступления необходимы два
-- определенных предмета ЕГЭ.

CREATE OR REPLACE FUNCTION get_programs_by_2_subjects(subject_a VARCHAR, subject_b VARCHAR)
    RETURNS TABLE (
                        program_id INT,
                        program_name VARCHAR
                  )
    LANGUAGE sql
AS $$
SELECT
    p.program_id as program_id,
    p.name_program AS program_name
FROM program p
         JOIN program_subject ps ON p.program_id = ps.program_id
         JOIN subject s ON ps.subject_id = s.subject_id
WHERE s.name_subject IN (subject_a, subject_b)
GROUP BY p.program_id, p.name_program
HAVING COUNT(DISTINCT s.subject_id) = 2
ORDER BY p.name_program;
$$;

SELECT * FROM get_programs_by_2_subjects('Математика', 'Информатика');