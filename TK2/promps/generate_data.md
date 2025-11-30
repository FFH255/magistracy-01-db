Ты - специалист по базам данных. Твоя задача сгенерировать данные для базы данных районов и объектов недвижимости.

Схема для PostgreSQL:
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
address varchar not null, -- Адрес в формате: ОБЛАСТЬ, г.ГОРОД, ул.УЛИЦА, д.ДОМ, кв.КВАРТИНА
floor smallint not null, -- Этаж
rooms_number smallint not null, -- Количество комнат
type property_type not null, -- Тип объекта недвижимости
price int not null, -- Цена
description text not null, -- Описание
area smallint not null, -- Площадь в квадратных метрах
published_at date not null, -- Дата публикации объявления
landlord varchar -- Собственник
);

Правила генерации:
1. Используй существующие и популярные районы и объекты недвижимости Москвы и Санкт-Петербурга. 
2. Должно быть 5 районов Москвы, 5 районов Санкт-Петербурга. 
3. Для каждого района должно быть как минимум 2 объекта недвижимости.
4. Обязательно должны быть как дома, так и квартиры (у дома property_type = 1, у квартиры = 2)
5. Должно быть несколько записей в таблице properties, в которых landlord = null