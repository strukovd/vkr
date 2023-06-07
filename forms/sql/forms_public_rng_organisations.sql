create table rng_organisations
(
    idrref       varchar(36)  not null
        constraint rng_organisations_pkey
            primary key,
    version      varchar(50)  not null,
    marked       varchar(5)   not null,
    predefinedid varchar(36)  not null,
    parentidrref varchar(36)  not null,
    code         varchar(9)   not null,
    description  varchar(50)  not null,
    fld2067      varchar(10)  not null,
    fld2068      varchar(150) not null,
    fld12821     varchar(5)   not null,
    fld12822     numeric(5)   not null,
    fld12823     varchar(50)  not null,
    fld12824rref varchar(36) default NULL::character varying,
    fld13503     varchar(36) default NULL::character varying,
    fld532       varchar(36)  not null,
    fld13702     varchar(36) default NULL::character varying,
    uuid         varchar(40)  not null
);

alter table rng_organisations
    owner to postgres;

create index rng_organisations_idrref_idx
    on rng_organisations (idrref);

INSERT INTO public.rng_organisations (idrref, version, marked, predefinedid, parentidrref, code, description, fld2067, fld2068, fld12821, fld12822, fld12823, fld12824rref, fld13503, fld532, fld13702, uuid) VALUES ('0x80b9005056976f2511e6684d7259ee90', '0x00000000131acd5e', '0x00', '0x00000000000000000000000000000000', '0x00000000000000000000000000000000', '000000001', 'ОсОО "Газпром Кыргызстан"', 'ГП', 'ОсОО "Газпром Кыргызстан"', '0x00', 0, '', '0x00000000000000000000000000000000', '', 'd1c89225-cc19-4a5c-9e58-417a3993d4b7', '0', '7259EE90-684D-11E6-80B9-005056976F25');
INSERT INTO public.rng_organisations (idrref, version, marked, predefinedid, parentidrref, code, description, fld2067, fld2068, fld12821, fld12822, fld12823, fld12824rref, fld13503, fld532, fld13702, uuid) VALUES ('0x80b9005056976f2511e675b20b0d9be4', '0x0000000013513181', '0x00', '0x00000000000000000000000000000000', '0x00000000000000000000000000000000', '000000003', 'Чуйгаз', 'ЧГ', 'Филиал "Чуйгаз"', '0x00', 0, '', '0x00000000000000000000000000000000', '', '20917f53-665c-4d1f-8f69-5be28bdfea1d', '0', '0B0D9BE4-75B2-11E6-80B9-005056976F25');
INSERT INTO public.rng_organisations (idrref, version, marked, predefinedid, parentidrref, code, description, fld2067, fld2068, fld12821, fld12822, fld12823, fld12824rref, fld13503, fld532, fld13702, uuid) VALUES ('0x80b9005056976f2511e675b21bc9f7fe', '0x0000000013513180', '0x00', '0x00000000000000000000000000000000', '0x00000000000000000000000000000000', '000000004', 'Ошгаз', 'ОШ', 'Филиал "Ошгаз"', '0x00', 0, '', '0x00000000000000000000000000000000', '', 'dd41da11-52b1-48eb-848b-d35c71857c9b', '0', '1BC9F7FE-75B2-11E6-80B9-005056976F25');
INSERT INTO public.rng_organisations (idrref, version, marked, predefinedid, parentidrref, code, description, fld2067, fld2068, fld12821, fld12822, fld12823, fld12824rref, fld13503, fld532, fld13702, uuid) VALUES ('0x80b9005056976f2511e675bcee0155b8', '0x000000001351317f', '0x00', '0x00000000000000000000000000000000', '0x00000000000000000000000000000000', '000000005', 'Жалалабатгаз', 'ЖА', 'Филиал "Жалалабатгаз"', '0x00', 0, '', '0x00000000000000000000000000000000', '', '6fa653c8-320d-4fa8-ad5a-d8f6c9f4a3b1', '0', 'EE0155B8-75BC-11E6-80B9-005056976F25');
INSERT INTO public.rng_organisations (idrref, version, marked, predefinedid, parentidrref, code, description, fld2067, fld2068, fld12821, fld12822, fld12823, fld12824rref, fld13503, fld532, fld13702, uuid) VALUES ('0x80b9005056976f2511e675bea935d656', '0x00000000136b3dff', '0x00', '0x00000000000000000000000000000000', '0x00000000000000000000000000000000', '000000006', 'Баткенская ЭГС', 'БТ', 'Баткенская ЭГС', '0x00', 0, '', '0x00000000000000000000000000000000', '', '23b05247-41aa-4cf7-a195-60794f070868', '0', 'A935D656-75BE-11E6-80B9-005056976F25');
INSERT INTO public.rng_organisations (idrref, version, marked, predefinedid, parentidrref, code, description, fld2067, fld2068, fld12821, fld12822, fld12823, fld12824rref, fld13503, fld532, fld13702, uuid) VALUES ('0x80bc001dd8b71c1f11e6263587e8cd88', '0x00000000138c9e83', '0x00', '0x00000000000000000000000000000000', '0x00000000000000000000000000000000', '000000002', 'Бишкекгаз', 'БШ', 'Филиал "Бишкекгаз"', '0x00', 0, '', '0x00000000000000000000000000000000', '', '335505f6-6865-4915-97c8-3fa8f63ac92c', '0', '87E8CD88-2635-11E6-80BC-001DD8B71C1F');