create table rng_types_sector
(
    description varchar(250),
    uuid        varchar(40)
);

alter table rng_types_sector
    owner to postgres;

INSERT INTO public.rng_types_sector (description, uuid) VALUES ('Государственный сектор', '7928F28E-EF80-93C9-16A6-365643FFFD4E');
INSERT INTO public.rng_types_sector (description, uuid) VALUES ('Частный сектор', '32098AD0-2F6D-B135-E670-9D8F36378344');