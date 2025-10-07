\c "magistracy-01-db-tk-1"

-- Факультет
create table department (
                            department_id serial primary key,
                            name_department varchar(255) not null
);

-- Образовательная программа
create table program (
                         program_id serial primary key,
                         name_program varchar(255) not null,
                         plan integer not null  check ( plan > 0 ),
                         department_id integer references department(department_id)
);

-- Предмет ЕГЭ
create table subject (
                         subject_id serial primary key,
                         name_subject varchar(255) not null
);

-- Абитуриент
create table enrollee (
                          enrollee_id serial primary key,
                          name_enrollee varchar(255) not null
);

-- Достижение
create table achievement (
                             achievement_id serial primary key,
                             name_achievement varchar(255) not null,
                             bonus integer check ( bonus > 0 and bonus <= 100 )
);

create table program_subject (
                                 program_subject_id serial primary key,
                                 program_id integer references program(program_id),
                                 subject_id integer references subject(subject_id),
                                 min_result integer not null check ( min_result >= 0 )
);

create table program_enrollee (
                                  program_enrollee_id serial primary key,
                                  program_id integer references program(program_id),
                                  enrollee_id integer references enrollee(enrollee_id)
);

create table enrollee_subject (
                                  enrollee_subject_id serial primary key,
                                  enrollee_id integer references enrollee(enrollee_id),
                                  subject_id integer references subject(subject_id),
                                  result integer not null check ( result >= 0 )
);

create table enrollee_achievement (
                                      enrollee_achievement_id serial primary key,
                                      enrollee_id integer references enrollee(enrollee_id),
                                      achievement_id integer references achievement(achievement_id)
);