SELECT
    (xpath('/object/Адрес/Улица/text()', description::xml))[1]::text as street,
    (xpath('/object/Адрес/Номер_дома/text()', description::xml))[1]::text AS building_number,
    (xpath('/object/Адрес/Номер_квартиры/text()', description::xml))[1]::text AS room_number,
    (xpath('/object/Адрес/Название_района/text()', description::xml))[1]::text AS district,
    (xpath('/object/Адрес/Город/text()', description::xml))[1]::text AS city
FROM properties_descriptions_xml
WHERE
    (xpath('/object/Адрес/Название_района/text()', description::xml))[1]::text = 'Сокольники'
ORDER BY
    (xpath('/object/Адрес/Название_района/text()', description::xml))[1]::text;