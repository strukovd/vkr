create table options
(
    id       serial not null
        constraint options_pk
            primary key,
    name     jsonb,
    value    varchar,
    "order"  smallint,
    visible  boolean default true,
    input_id varchar(30)
        constraint options_inputs_id_fk
            references inputs
            on update cascade on delete cascade
);

alter table options
    owner to postgres;

INSERT INTO public.options (id, name, value, "order", visible, input_id) VALUES (11, '{"kg": "Плита", "ru": "Плита"}', '11800', 2, true, 'planned_gas-using_devices');
INSERT INTO public.options (id, name, value, "order", visible, input_id) VALUES (12, '{"kg": "Котел", "ru": "Котел"}', '11801', 2, true, 'planned_gas-using_devices');
INSERT INTO public.options (id, name, value, "order", visible, input_id) VALUES (13, '{"kg": "Газовая колонка", "ru": "Газовая колонка"}', '11802', 2, true, 'planned_gas-using_devices');
INSERT INTO public.options (id, name, value, "order", visible, input_id) VALUES (10, '{"kg": "Государственный сектор", "ru": "Государственный сектор"}', '10011', 2, true, 'housing_type');
INSERT INTO public.options (id, name, value, "order", visible, input_id) VALUES (8, '{"kg": "Технологические нужды", "ru": "Технологические нужды"}', '11806', 2, true, 'gas_consumption_pattern');
INSERT INTO public.options (id, name, value, "order", visible, input_id) VALUES (5, '{"kg": "Отопление", "ru": "Отопление"}', '11803', 2, true, 'gas_consumption_pattern');
INSERT INTO public.options (id, name, value, "order", visible, input_id) VALUES (7, '{"kg": "Пищеприготовление", "ru": "Пищеприготовление"}', '11805', 2, true, 'gas_consumption_pattern');
INSERT INTO public.options (id, name, value, "order", visible, input_id) VALUES (9, '{"kg": "Частный сектор", "ru": "Частный сектор"}', '10010', 2, true, 'housing_type');
INSERT INTO public.options (id, name, value, "order", visible, input_id) VALUES (1, '{"kg": "Эркек", "ru": "Мужской"}', '10267', 1, true, 'gender');
INSERT INTO public.options (id, name, value, "order", visible, input_id) VALUES (3, '{"kg": "Есть", "ru": "Есть"}', '10006', 2, true, 'technical_conditions');
INSERT INTO public.options (id, name, value, "order", visible, input_id) VALUES (6, '{"kg": "Горячее водоснабжение", "ru": "Горячее водоснабжение"}', '11804', 2, true, 'gas_consumption_pattern');
INSERT INTO public.options (id, name, value, "order", visible, input_id) VALUES (2, '{"kg": "Кыз", "ru": "Женский"}', '10266', 2, true, 'gender');
INSERT INTO public.options (id, name, value, "order", visible, input_id) VALUES (4, '{"kg": "Нету", "ru": "Нету"}', '10007', 2, true, 'technical_conditions');
INSERT INTO public.options (id, name, value, "order", visible, input_id) VALUES (14, '{"kg": "Бишкек", "ru": "Бишкек"}', '12400', 1, true, 'region_jira');
INSERT INTO public.options (id, name, value, "order", visible, input_id) VALUES (15, '{"kg": "Токмокская ЭГС", "ru": "Токмокская ЭГС"}', '12401', 2, true, 'region_jira');
INSERT INTO public.options (id, name, value, "order", visible, input_id) VALUES (16, '{"kg": "Кантская ЭГС", "ru": "Кантская ЭГС"}', '12402', 3, true, 'region_jira');
INSERT INTO public.options (id, name, value, "order", visible, input_id) VALUES (17, '{"kg": "Кара-Балтинская ЭГС", "ru": "Кара-Балтинская ЭГС"}', '12403', 4, true, 'region_jira');
INSERT INTO public.options (id, name, value, "order", visible, input_id) VALUES (18, '{"kg": "Ленинская ЭГС", "ru": "Ленинская ЭГС"}', '12404', 5, true, 'region_jira');
INSERT INTO public.options (id, name, value, "order", visible, input_id) VALUES (19, '{"kg": "Аманбаевская ЭГС", "ru": "Аманбаевская ЭГС"}', '12405', 6, true, 'region_jira');
INSERT INTO public.options (id, name, value, "order", visible, input_id) VALUES (20, '{"kg": "Чуйгаз", "ru": "Чуйгаз"}', '12406', 7, true, 'region_jira');