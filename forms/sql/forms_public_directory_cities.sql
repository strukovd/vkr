create table directory_cities
(
    id         serial not null
        constraint directory_cities_pk
            primary key,
    name       varchar(255),
    visible    boolean default true,
    "order"    smallint,
    country_id integer
);

alter table directory_cities
    owner to postgres;

INSERT INTO public.directory_cities (id, name, visible, "order", country_id) VALUES (3, 'Нарын', true, null, 3);
INSERT INTO public.directory_cities (id, name, visible, "order", country_id) VALUES (2, 'Ош', true, null, 3);
INSERT INTO public.directory_cities (id, name, visible, "order", country_id) VALUES (7, 'Санкт-Питербург', true, null, 5);
INSERT INTO public.directory_cities (id, name, visible, "order", country_id) VALUES (1, 'Бишкек', true, null, 3);
INSERT INTO public.directory_cities (id, name, visible, "order", country_id) VALUES (8, 'Краснодар', true, null, 5);
INSERT INTO public.directory_cities (id, name, visible, "order", country_id) VALUES (6, 'Москва', true, null, 5);
INSERT INTO public.directory_cities (id, name, visible, "order", country_id) VALUES (5, 'Алмата', true, null, 4);
INSERT INTO public.directory_cities (id, name, visible, "order", country_id) VALUES (4, 'Нур-султан', true, null, 4);