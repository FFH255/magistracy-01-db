CREATE OR REPLACE PROCEDURE fill_properties_descriptions_xml()
    LANGUAGE plpgsql
AS $$
BEGIN
    TRUNCATE TABLE properties_descriptions_xml;

    INSERT INTO properties_descriptions_xml (property_code, description)
    SELECT
        p.code,
        '<object id="' || p.code || '" ' ||
        'Собственник="' || COALESCE(p.landlord, 'Нет данных') || '" ' ||
        'Рейтинг="' || COALESCE(rating.rating::text, '0') || '">' ||
        '<Динамика_стоимости>' ||
        COALESCE(
                (SELECT STRING_AGG(
                                '<Стоимость Дата_установки_стоимости="' ||
                                TO_CHAR(changed_at, 'YYYY-MM-DD"T"HH24:MI:SS') ||
                                '">' || new_price || '</Стоимость>',
                                '')
                 FROM price_dynamics pd
                 WHERE pd.property_code = p.code),
                '<Стоимость Дата_установки_стоимости="' ||
                p.published_at ||
                '">' || p.price || '</Стоимость>'
        ) ||
        '</Динамика_стоимости>' ||
        '<Этаж>' || p.floor || '</Этаж>' ||
        '<Площадь>' ||
        '<Общая_площадь>' || p.area || '</Общая_площадь>' ||
        '<Жилая_площадь>' ||
        (pd.description::jsonb->'Площадь'->>1)::text ||
        '</Жилая_площадь>' ||
        '</Площадь>' ||
        '<Адрес Область="' ||
        (pd.description::jsonb->'Адрес'->>'Область')::text || '">' ||
        '<Город>' ||
        (pd.description::jsonb->'Адрес'->>'Город')::text || '</Город>' ||
        '<Название_района>' || d.name || '</Название_района>' ||
        '<Улица>' || (pd.description::jsonb->'Адрес'->>'Улица')::text || '</Улица>' ||
        '<Номер_дома>' || (pd.description::jsonb->'Адрес'->>'Номер дома')::text || '</Номер_дома>' ||
        '<Номер_квартиры>' || (pd.description::jsonb->'Адрес'->>'Номер квартиры')::text || '</Номер_квартиры>' ||
        '</Адрес>' ||
        '</object>'
    FROM properties p
             JOIN districts d ON d.code = p.district_code
             LEFT JOIN properties_description pd ON pd.property_code = p.code
             LEFT JOIN (
        SELECT
            code,
            ROW_NUMBER() OVER (PARTITION BY district_code ORDER BY price DESC) as rating
        FROM properties
        WHERE type = '2'
    ) rating ON rating.code = p.code
    ORDER BY p.code;
END;
$$;

CALL fill_properties_descriptions_xml();