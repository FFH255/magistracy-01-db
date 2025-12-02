-- districts - районы
create table if not exists districts (
    code serial primary key, -- Код Района
    name varchar not null -- Название района
);

-- Тип объекта недвижимости: 1 - дом, 2 - квартира
create type property_type as enum ('1', '2');

-- properties - объекты недвижимости
create table if not exists properties (
    code serial primary key, -- Код объекта недвижимости
    district_code int references districts(code) not null, -- Код района
    address varchar not null, -- Адрес в формате: ХХХ, г.ХХХ, ул.ХХХ, д.ХХ, кв.ХХ
    floor smallint not null, -- Этаж
    rooms_number smallint not null, -- Количество комнат
    type property_type not null, -- Тип объекта недвижимости
    price int not null, -- Цена
    description text not null, -- Описание
    area smallint not null, -- Площадь в квадратных метрах
    published_at date not null, -- Дата публикации объявления
    landlord varchar -- Собственник
);

-- properties_description - описание объектов недвижимости
create table if not exists properties_description (
    property_code int references properties(code) not null, -- Код объекта недвижимости
    description jsonb -- Описание объекта недвижимости
);

-- Поле description в таблицу properties_description хранит информацию в формате json:
-- {
--     "Стоимость": стоимость объекта объекта недвижимости,
--     "Комнаты": количество комнат,
--     "Собственник": собственник объекта недвижимости,
--     "Этаж": этаж объекта недвижимости,
--     "Площадь": массив, содержащий 2 элемента, общая площадь и жилая
--     площадь объекта,
--     "Адрес": {
--     "Область":
--     "Город":
--     "Район": название района
--     "Улица":
--     "Номер дома":
--     "Номер квартиры":
-- }