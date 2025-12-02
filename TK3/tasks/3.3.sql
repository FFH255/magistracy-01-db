SELECT
    (xpath('/object/Адрес/@Область', description::xml))[1]::text || ' ' ||
    'г. ' || (xpath('/object/Адрес/Город/text()', description::xml))[1]::text || ' ' ||
    (xpath('/object/Адрес/Улица/text()', description::xml))[1]::text || ' ' ||
    'д. ' || (xpath('/object/Адрес/Номер_дома/text()', description::xml))[1]::text || ' '
        'кв. ' || (xpath('/object/Адрес/Номер_квартиры/text()', description::xml))[1]::text || ' '
        as address,
    (xpath('/object/Адрес/Название_района/text()', description::xml))[1]::text as district,
    (xpath('/object/@Рейтинг', description::xml))[1]::text as rating
FROM properties_descriptions_xml;