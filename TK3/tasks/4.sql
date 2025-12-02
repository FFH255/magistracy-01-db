CREATE OR REPLACE PROCEDURE change_landlord(
    p_property_code int,
    p_fio text
)
LANGUAGE plpgsql
AS $$
    BEGIN

        UPDATE properties_descriptions_xml
        SET description = regexp_replace(
                description::text,
                '(Собственник=")[^"]*(")',
                '\1' || p_fio || '\2')
        WHERE property_code = p_property_code;

    END;
$$;

CALL change_landlord(2, 'Фадеев В.В.');
