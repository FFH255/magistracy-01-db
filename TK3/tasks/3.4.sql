SELECT
    (xpath('/object/@id', description::xml))[1]::text as code,
    UNNEST(xpath('/object/Динамика_стоимости/Стоимость/text()', description::xml))::text AS price,
    UNNEST(xpath('/object/Динамика_стоимости/Стоимость/@Дата_установки_стоимости', description::xml))::text AS changed_at
FROM properties_descriptions_xml
WHERE property_code = 1
ORDER BY changed_at;