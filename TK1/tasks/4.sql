SELECT p.name_program
FROM program p
INNER JOIN program_subject ps
ON p.program_id = ps.program_id
GROUP BY p.name_program
HAVING MIN(ps.min_result) > 70