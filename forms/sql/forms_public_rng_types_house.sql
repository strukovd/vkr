create table rng_types_house
(
    description varchar(250),
    uuid        varchar(40)
);

alter table rng_types_house
    owner to postgres;

INSERT INTO public.rng_types_house (description, uuid) VALUES ('Многоэтажный дом', 'EB2A33F4-49DD-11E7-80CA-005056976F25');
INSERT INTO public.rng_types_house (description, uuid) VALUES ('Частный дом', '1868972B-49DE-11E7-80CA-005056976F25');