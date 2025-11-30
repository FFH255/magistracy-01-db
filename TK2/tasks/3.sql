INSERT INTO properties_description (property_code, description)
SELECT
    p.code,
    jsonb_build_object(
            'Стоимость', p.price,
            'Комнаты', p.rooms_number,
            'Собственник', COALESCE(p.landlord, 'Нет данных'),
            'Этаж', p.floor,
            'Площадь', jsonb_build_array(p.area, null),
            'Адрес', jsonb_build_object(
                    'Область', split_part(p.address, ', ', 1),
                    'Город', split_part(split_part(p.address, ', ', 2), '. ', 2),
                    'Район', d.name,
                    'Улица', split_part(p.address, ', ', 3),
                    'Номер дома', split_part(split_part(p.address, ', ', 4), '. ', 2),
                    'Номер квартиры', CASE
                                          WHEN p.type = '1' THEN 'Нет'
                                          ELSE split_part(split_part(p.address, ', ', 5), '. ', 2)
                        END
                     )
    ) AS description
FROM properties p
         JOIN districts d ON d.code = p.district_code;
