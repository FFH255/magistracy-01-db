-- 5.7 Вывести список объектов недвижимости и отклонение от средней стоимости по
-- району, где располагается данный объект недвижимости.

-- {
--     "Стоимость": стоимость объекта объекта недвижимости,
--     "Комнаты": количество комнат,
--     "Собственник": собственник объекта недвижимости,
--     "Этаж": этаж объекта недвижимости,
--     "Площадь": массив, содержащий 2 элемента, общая площадь и жилая
--     площадь объекта,
--     "Адрес": {
--         "Область":
--         "Город":
--         "Район": название района
--         "Улица":
--         "Номер дома":
--         "Номер квартиры":
--     }
-- }

WITH district_of_target AS (
    SELECT
        description -> 'Адрес' ->> 'Район' AS district
    FROM properties_description
    WHERE property_code = 1
),
     avg_price_target_district AS (
         SELECT
             AVG((pd.description ->> 'Стоимость')::numeric) AS avg_price,
             d.district
         FROM properties_description pd
                  JOIN district_of_target d
                       ON d.district = pd.description -> 'Адрес' ->> 'Район'
         GROUP BY d.district
     )
SELECT
    pd.property_code,
    pd.description ->> 'Стоимость' AS price,
    pd.description -> 'Адрес' ->> 'Район' AS district,
    ROUND(
            (pd.description ->> 'Стоимость')::numeric - aptd.avg_price,
            2
    ) AS deviation
FROM properties_description pd
         JOIN avg_price_target_district aptd
              ON aptd.district = pd.description -> 'Адрес' ->> 'Район'
ORDER BY pd.property_code;
