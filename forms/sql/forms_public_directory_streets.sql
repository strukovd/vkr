create table directory_streets
(
    id      serial not null
        constraint directory_streets_pk
            primary key,
    name    varchar(255),
    visible boolean,
    "order" smallint,
    city_id integer
);

alter table directory_streets
    owner to postgres;

INSERT INTO public.directory_streets (id, name, visible, "order", city_id) VALUES (1, 'ул. Джакшылыка', true, 1, 2);
INSERT INTO public.directory_streets (id, name, visible, "order", city_id) VALUES (2, 'ул. Бешбармака', true, 2, 2);
INSERT INTO public.directory_streets (id, name, visible, "order", city_id) VALUES (3, 'ул. Базарная', true, 1, 3);
INSERT INTO public.directory_streets (id, name, visible, "order", city_id) VALUES (4, 'ул. Тюлебердиева', true, 2, 3);
INSERT INTO public.directory_streets (id, name, visible, "order", city_id) VALUES (5, 'пеп. Донской', true, 1, 1);
INSERT INTO public.directory_streets (id, name, visible, "order", city_id) VALUES (6, 'ул. Панфилова', true, 2, 1);
INSERT INTO public.directory_streets (id, name, visible, "order", city_id) VALUES (7, 'ул. Орозбекова', true, 3, 1);
INSERT INTO public.directory_streets (id, name, visible, "order", city_id) VALUES (8, 'ул. Киевская', true, 4, 1);
INSERT INTO public.directory_streets (id, name, visible, "order", city_id) VALUES (9, 'ул. Московская', true, 5, 1);