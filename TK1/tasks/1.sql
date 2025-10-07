select e.name_enrollee, s.name_subject
from enrollee e
         inner join enrollee_subject es
                    on e.enrollee_id = es.enrollee_id
         inner join subject s
                    on es.subject_id = s.subject_id
order by s.name_subject;
