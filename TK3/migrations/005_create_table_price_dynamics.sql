-- динамика изменения цен
CREATE TABLE price_dynamics (
    property_code INT NOT NULL, -- код объекта недвижимости
    new_price INT NOT NULL, -- новая цена
    changed_at TIMESTAMP NOT NULL -- дата изменения цены
);