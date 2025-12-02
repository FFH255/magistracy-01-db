SELECT
    (xpath('/object/Адрес/@Область', description::xml))[1]::text || ' ' ||
    'г. ' || (xpath('/object/Адрес/Город/text()', description::xml))[1]::text || ' ' ||
    (xpath('/object/Адрес/Улица/text()', description::xml))[1]::text || ' ' ||
    'д. ' || (xpath('/object/Адрес/Номер_дома/text()', description::xml))[1]::text || ' '
    'кв. ' || (xpath('/object/Адрес/Номер_квартиры/text()', description::xml))[1]::text || ' '
        as address
FROM properties_descriptions_xml
WHERE
    (xpath('/object/Адрес/@Область', description::xml))[1]::text = 'МОСКОВСКАЯ ОБЛАСТЬ'
AND
    ((xpath('/object/Площадь/Жилая_площадь/text()', description::xml))[1]::text)::numeric
    /
    ((xpath('/object/Площадь/Общая_площадь/text()', description::xml))[1]::text)::numeric
    > 0.8
ORDER BY
    (xpath('/object/Адрес/Название_района/text()', description::xml))[1]::text;