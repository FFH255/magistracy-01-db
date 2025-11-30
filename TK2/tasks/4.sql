UPDATE properties_description
SET description = jsonb_set(
        description,
        '{Площадь,1}',
        to_jsonb(
                ((description->'Площадь'->>0)::numeric * (0.5 + random() * 0.5))::numeric(10, 0)
        )
                  )
WHERE description->'Площадь' IS NOT NULL;
