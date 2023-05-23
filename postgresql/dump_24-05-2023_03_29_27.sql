--
-- PostgreSQL database cluster dump
--

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Drop databases (except postgres and template1)
--

DROP DATABASE vkr;




--
-- Drop roles
--

DROP ROLE vkr;


--
-- Roles
--

CREATE ROLE vkr;
ALTER ROLE vkr WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:Lu/UlCpseHKl684KkhcBOQ==$N3+TNl0inJfx/dScz95Sx+pTBdiOgQsd2XdYsipEjAg=:TwbTP5Y6CcaAHiUOrWxwh/84Ew2N/TJpRGRsj0UD+k4=';






--
-- Databases
--

--
-- Database "template1" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 14.6
-- Dumped by pg_dump version 14.6

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

UPDATE pg_catalog.pg_database SET datistemplate = false WHERE datname = 'template1';
DROP DATABASE template1;
--
-- Name: template1; Type: DATABASE; Schema: -; Owner: vkr
--

CREATE DATABASE template1 WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'en_US.utf8';


ALTER DATABASE template1 OWNER TO vkr;

\connect template1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: DATABASE template1; Type: COMMENT; Schema: -; Owner: vkr
--

COMMENT ON DATABASE template1 IS 'default template for new databases';


--
-- Name: template1; Type: DATABASE PROPERTIES; Schema: -; Owner: vkr
--

ALTER DATABASE template1 IS_TEMPLATE = true;


\connect template1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: DATABASE template1; Type: ACL; Schema: -; Owner: vkr
--

REVOKE CONNECT,TEMPORARY ON DATABASE template1 FROM PUBLIC;
GRANT CONNECT ON DATABASE template1 TO PUBLIC;


--
-- PostgreSQL database dump complete
--

--
-- Database "postgres" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 14.6
-- Dumped by pg_dump version 14.6

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE postgres;
--
-- Name: postgres; Type: DATABASE; Schema: -; Owner: vkr
--

CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'en_US.utf8';


ALTER DATABASE postgres OWNER TO vkr;

\connect postgres

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: DATABASE postgres; Type: COMMENT; Schema: -; Owner: vkr
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


--
-- PostgreSQL database dump complete
--

--
-- Database "vkr" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 14.6
-- Dumped by pg_dump version 14.6

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: vkr; Type: DATABASE; Schema: -; Owner: vkr
--

CREATE DATABASE vkr WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'en_US.utf8';


ALTER DATABASE vkr OWNER TO vkr;

\connect vkr

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: field_value; Type: TABLE; Schema: public; Owner: vkr
--

CREATE TABLE public.field_value (
    id integer NOT NULL,
    field_id integer,
    project_id integer,
    task_type_id integer,
    value_num numeric,
    value_string character varying(500),
    value_text text,
    value_bool boolean
);


ALTER TABLE public.field_value OWNER TO vkr;

--
-- Name: field_value_id_seq; Type: SEQUENCE; Schema: public; Owner: vkr
--

CREATE SEQUENCE public.field_value_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.field_value_id_seq OWNER TO vkr;

--
-- Name: field_value_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vkr
--

ALTER SEQUENCE public.field_value_id_seq OWNED BY public.field_value.id;


--
-- Name: fields; Type: TABLE; Schema: public; Owner: vkr
--

CREATE TABLE public.fields (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(25)
);


ALTER TABLE public.fields OWNER TO vkr;

--
-- Name: projects; Type: TABLE; Schema: public; Owner: vkr
--

CREATE TABLE public.projects (
    key character varying(50) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(500)
);


ALTER TABLE public.projects OWNER TO vkr;

--
-- Name: status_groups; Type: TABLE; Schema: public; Owner: vkr
--

CREATE TABLE public.status_groups (
    id integer NOT NULL,
    name character varying(255)
);


ALTER TABLE public.status_groups OWNER TO vkr;

--
-- Name: status_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: vkr
--

CREATE SEQUENCE public.status_groups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.status_groups_id_seq OWNER TO vkr;

--
-- Name: status_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vkr
--

ALTER SEQUENCE public.status_groups_id_seq OWNED BY public.status_groups.id;


--
-- Name: statuses; Type: TABLE; Schema: public; Owner: vkr
--

CREATE TABLE public.statuses (
    id integer NOT NULL,
    name character varying(255),
    status_group_id integer
);


ALTER TABLE public.statuses OWNER TO vkr;

--
-- Name: statuses_id_seq; Type: SEQUENCE; Schema: public; Owner: vkr
--

CREATE SEQUENCE public.statuses_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.statuses_id_seq OWNER TO vkr;

--
-- Name: statuses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vkr
--

ALTER SEQUENCE public.statuses_id_seq OWNED BY public.statuses.id;


--
-- Name: task_comments; Type: TABLE; Schema: public; Owner: vkr
--

CREATE TABLE public.task_comments (
    id integer NOT NULL,
    task_id integer NOT NULL,
    comment text NOT NULL,
    updated timestamp without time zone DEFAULT now(),
    created timestamp without time zone DEFAULT now()
);


ALTER TABLE public.task_comments OWNER TO vkr;

--
-- Name: task_comments_id_seq; Type: SEQUENCE; Schema: public; Owner: vkr
--

CREATE SEQUENCE public.task_comments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.task_comments_id_seq OWNER TO vkr;

--
-- Name: task_comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vkr
--

ALTER SEQUENCE public.task_comments_id_seq OWNED BY public.task_comments.id;


--
-- Name: task_move_history; Type: TABLE; Schema: public; Owner: vkr
--

CREATE TABLE public.task_move_history (
    id integer NOT NULL,
    task_id integer,
    from_status integer,
    to_status integer,
    created timestamp without time zone DEFAULT now()
);


ALTER TABLE public.task_move_history OWNER TO vkr;

--
-- Name: task_move_history_id_seq; Type: SEQUENCE; Schema: public; Owner: vkr
--

CREATE SEQUENCE public.task_move_history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.task_move_history_id_seq OWNER TO vkr;

--
-- Name: task_move_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vkr
--

ALTER SEQUENCE public.task_move_history_id_seq OWNED BY public.task_move_history.id;


--
-- Name: task_types; Type: TABLE; Schema: public; Owner: vkr
--

CREATE TABLE public.task_types (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    "desc" character varying(500)
);


ALTER TABLE public.task_types OWNER TO vkr;

--
-- Name: task_types_id_seq; Type: SEQUENCE; Schema: public; Owner: vkr
--

CREATE SEQUENCE public.task_types_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.task_types_id_seq OWNER TO vkr;

--
-- Name: task_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vkr
--

ALTER SEQUENCE public.task_types_id_seq OWNED BY public.task_types.id;


--
-- Name: tasks; Type: TABLE; Schema: public; Owner: vkr
--

CREATE TABLE public.tasks (
    id integer NOT NULL,
    key character varying(50),
    title character varying(500) NOT NULL,
    description text,
    priority smallint,
    assignee character varying(100),
    creator character varying(100),
    updated timestamp without time zone DEFAULT now(),
    created timestamp without time zone DEFAULT now(),
    project_key character varying(50)
);


ALTER TABLE public.tasks OWNER TO vkr;

--
-- Name: tasks_id_seq; Type: SEQUENCE; Schema: public; Owner: vkr
--

CREATE SEQUENCE public.tasks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tasks_id_seq OWNER TO vkr;

--
-- Name: tasks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vkr
--

ALTER SEQUENCE public.tasks_id_seq OWNED BY public.tasks.id;


--
-- Name: transitions; Type: TABLE; Schema: public; Owner: vkr
--

CREATE TABLE public.transitions (
    id integer NOT NULL,
    project_key character varying(50),
    name character varying(255),
    from_status integer,
    to_status integer
);


ALTER TABLE public.transitions OWNER TO vkr;

--
-- Name: transitions_id_seq; Type: SEQUENCE; Schema: public; Owner: vkr
--

CREATE SEQUENCE public.transitions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.transitions_id_seq OWNER TO vkr;

--
-- Name: transitions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vkr
--

ALTER SEQUENCE public.transitions_id_seq OWNED BY public.transitions.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: vkr
--

CREATE TABLE public.users (
    id integer NOT NULL,
    login character varying(100) NOT NULL,
    password character varying(255) NOT NULL,
    email character varying(500),
    display_name character varying(500)
);


ALTER TABLE public.users OWNER TO vkr;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: vkr
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO vkr;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vkr
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: workflows; Type: TABLE; Schema: public; Owner: vkr
--

CREATE TABLE public.workflows (
    id integer NOT NULL,
    name character varying(255) NOT NULL
);


ALTER TABLE public.workflows OWNER TO vkr;

--
-- Name: workflows_id_seq; Type: SEQUENCE; Schema: public; Owner: vkr
--

CREATE SEQUENCE public.workflows_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.workflows_id_seq OWNER TO vkr;

--
-- Name: workflows_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vkr
--

ALTER SEQUENCE public.workflows_id_seq OWNED BY public.workflows.id;


--
-- Name: field_value id; Type: DEFAULT; Schema: public; Owner: vkr
--

ALTER TABLE ONLY public.field_value ALTER COLUMN id SET DEFAULT nextval('public.field_value_id_seq'::regclass);


--
-- Name: status_groups id; Type: DEFAULT; Schema: public; Owner: vkr
--

ALTER TABLE ONLY public.status_groups ALTER COLUMN id SET DEFAULT nextval('public.status_groups_id_seq'::regclass);


--
-- Name: statuses id; Type: DEFAULT; Schema: public; Owner: vkr
--

ALTER TABLE ONLY public.statuses ALTER COLUMN id SET DEFAULT nextval('public.statuses_id_seq'::regclass);


--
-- Name: task_comments id; Type: DEFAULT; Schema: public; Owner: vkr
--

ALTER TABLE ONLY public.task_comments ALTER COLUMN id SET DEFAULT nextval('public.task_comments_id_seq'::regclass);


--
-- Name: task_move_history id; Type: DEFAULT; Schema: public; Owner: vkr
--

ALTER TABLE ONLY public.task_move_history ALTER COLUMN id SET DEFAULT nextval('public.task_move_history_id_seq'::regclass);


--
-- Name: task_types id; Type: DEFAULT; Schema: public; Owner: vkr
--

ALTER TABLE ONLY public.task_types ALTER COLUMN id SET DEFAULT nextval('public.task_types_id_seq'::regclass);


--
-- Name: tasks id; Type: DEFAULT; Schema: public; Owner: vkr
--

ALTER TABLE ONLY public.tasks ALTER COLUMN id SET DEFAULT nextval('public.tasks_id_seq'::regclass);


--
-- Name: transitions id; Type: DEFAULT; Schema: public; Owner: vkr
--

ALTER TABLE ONLY public.transitions ALTER COLUMN id SET DEFAULT nextval('public.transitions_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: vkr
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: workflows id; Type: DEFAULT; Schema: public; Owner: vkr
--

ALTER TABLE ONLY public.workflows ALTER COLUMN id SET DEFAULT nextval('public.workflows_id_seq'::regclass);


--
-- Data for Name: field_value; Type: TABLE DATA; Schema: public; Owner: vkr
--

COPY public.field_value (id, field_id, project_id, task_type_id, value_num, value_string, value_text, value_bool) FROM stdin;
\.


--
-- Data for Name: fields; Type: TABLE DATA; Schema: public; Owner: vkr
--

COPY public.fields (id, name, type) FROM stdin;
\.


--
-- Data for Name: projects; Type: TABLE DATA; Schema: public; Owner: vkr
--

COPY public.projects (key, name, description) FROM stdin;
NG	Газификация	Газификация
OB	Обрезка	Обрезка
RERE	Разработка эскизного чертежа	Разработка эскизного чертежа
PM	Перемонтаж	Перемонтаж
VR	Врезка	Врезка
SIU	Снятие и установка бытового газового счетчика	Снятие и установка бытового газового счетчика
NVO	Не взымать оплату	Не взымать оплату
KK	Конфликтная комиссия	Конфликтная комиссия
JL	Жалобы	Жалобы
GUL	Газификация юр. лиц	Газификация юр. лиц
TR	Переход из комбыт в население	Переход из комбыт в население
PSO	Перекидка суммы оплат	Перекидка суммы оплат
\.


--
-- Data for Name: status_groups; Type: TABLE DATA; Schema: public; Owner: vkr
--

COPY public.status_groups (id, name) FROM stdin;
\.


--
-- Data for Name: statuses; Type: TABLE DATA; Schema: public; Owner: vkr
--

COPY public.statuses (id, name, status_group_id) FROM stdin;
\.


--
-- Data for Name: task_comments; Type: TABLE DATA; Schema: public; Owner: vkr
--

COPY public.task_comments (id, task_id, comment, updated, created) FROM stdin;
\.


--
-- Data for Name: task_move_history; Type: TABLE DATA; Schema: public; Owner: vkr
--

COPY public.task_move_history (id, task_id, from_status, to_status, created) FROM stdin;
\.


--
-- Data for Name: task_types; Type: TABLE DATA; Schema: public; Owner: vkr
--

COPY public.task_types (id, name, "desc") FROM stdin;
1	Заявление	\N
\.


--
-- Data for Name: tasks; Type: TABLE DATA; Schema: public; Owner: vkr
--

COPY public.tasks (id, key, title, description, priority, assignee, creator, updated, created, project_key) FROM stdin;
9	\N	Игнатий Смирнов	И статус И развитие сомнений	4	admin	admin	2023-05-23 17:48:35	2023-05-23 17:48:40	NG
11	\N	Устин Виноградов	Активности с И постоянный смешаны моральных их чего последовательного ценностей. значение оценить из-за. Значение их нет нет нет. Развивающиеся не сфера активности нашей однозначно развития. Страны и развития моральных развивающиеся необходимость развитие поэтапного количественный развития.\nНо в развития их бесполезности. значение ценностей. значение уникальными позволяет рост необходимость укрепления. С сомнений, развития общества частности количественный развития укрепления. Смешаны ценностей. и активно в моральных что статус из-за. Что активности уникальными постоянный нашей социально-экономическое что. Совершенной нет уникальными бесполезности. частности ценностей. развития сфера и количественный не. Неузнаваемости поэтапного и в из-за их нашей неузнаваемости третьего последовательного уникальными И сомнений,. Развития нет развивающиеся последовательного развитие сомнений, ценностей..\nИ однозначно фиксирует уникальными необходимость мира в до поэтапного активности. Нет не ценностей. общества не и частности поэтапного и последовательного фиксирует степени из-за их ценностей.. Развитие необходимость нет постоянный страны бесполезности. что социально-экономическое не значение. Развития из-за социально-экономическое количественный позволяет укрепления в не количественный сомнений, и данными и страны их. Социально-экономическое активности и активно И статус моральных их развивающиеся.\nБесполезности. нет чего не статус. Рост уникальными страны с из-за данными в. Статус чего чего постоянный смешаны степени нет социально-экономическое чего их.\nСоциально-экономическое их И статус возрастает развития активности страны страны уникальными. Однозначно И моральных с в уникальными однозначно бесполезности. страны необходимость. Мира развития фиксирует не и позволяет уникальными неузнаваемости поэтапного значение позволяет. Степени статус сомнений, совершенной последовательного степени.	4	admin	admin	2023-05-23 17:48:35	2023-05-23 17:48:40	NG
14	\N	Фрол Виноградов	Ценностей. из-за и последовательного статус И однозначно неузнаваемости фиксирует и частности третьего данными но. Мира но чего из-за смешаны необходимость. Третьего и уникальными развития укрепления фиксирует совершенной бесполезности.. Поэтапного частности неузнаваемости из-за страны значение и поэтапного фиксирует нашей моральных поэтапного значение моральных.\nОценить не степени из-за активности совершенной количественный. Что активности но из-за что бесполезности. количественный в сомнений, данными однозначно степени. Необходимость третьего постоянный их рост необходимость активно. Последовательного из-за возрастает однозначно развитие степени степени. Из-за и рост что ценностей. данными социально-экономическое моральных общества ценностей. общества данными сомнений,. Частности но уникальными укрепления укрепления данными нашей однозначно их развития их И страны. Уникальными количественный укрепления смешаны поэтапного данными.\nСомнений, рост третьего бесполезности. чего сфера социально-экономическое однозначно сомнений,. Активности сфера И оценить активно возрастает рост сомнений,. Укрепления сомнений, постоянный данными активности укрепления активности степени оценить статус активности и активно из-за. Развитие укрепления сфера социально-экономическое фиксирует третьего возрастает в общества страны смешаны.\nКоличественный оценить нашей данными их моральных и. Развития ценностей. не рост необходимость совершенной последовательного И. Позволяет укрепления страны сфера сфера.\nЧастности статус неузнаваемости поэтапного неузнаваемости. Мира страны активности последовательного и укрепления активности чего количественный возрастает страны развитие рост развивающиеся. С в социально-экономическое развития в необходимость укрепления и однозначно развитие смешаны. Моральных что мира и развития что моральных. До ценностей. однозначно поэтапного страны из-за бесполезности. частности мира мира страны что постоянный активности совершенной. И поэтапного возрастает не нашей социально-экономическое мира. Смешаны количественный бесполезности. рост И.	2	admin	admin	2023-05-23 17:48:35	2023-05-23 17:48:40	VR
12	\N	Чеслав Мишин	Оценить из-за значение поэтапного уникальными степени последовательного необходимость неузнаваемости до и совершенной не возрастает. Данными возрастает моральных общества последовательного активно необходимость и третьего позволяет фиксирует неузнаваемости. Степени моральных однозначно количественный до рост сфера смешаны уникальными третьего количественный сомнений, необходимость укрепления. Уникальными оценить развитие и оценить социально-экономическое сфера. Третьего значение чего и ценностей. укрепления значение значение в укрепления активности ценностей. укрепления что количественный.\nСтатус в в необходимость активности из-за. Уникальными третьего сомнений, их фиксирует сомнений, совершенной значение общества до поэтапного и смешаны что что. И нет данными их но смешаны количественный активно поэтапного степени. Позволяет постоянный третьего фиксирует социально-экономическое. Не до с в не однозначно поэтапного. Мира значение ценностей. данными и социально-экономическое их чего смешаны страны количественный ценностей..\nФиксирует третьего активно развивающиеся активно оценить И сомнений, сомнений, поэтапного позволяет нашей и до совершенной. И не укрепления не И и. Совершенной не нашей неузнаваемости и количественный последовательного. Степени с статус совершенной активно развивающиеся неузнаваемости моральных и. Количественный страны совершенной страны частности укрепления сфера нашей смешаны поэтапного. Активно мира что их третьего не активности необходимость из-за нашей до сфера из-за. Нет моральных неузнаваемости моральных оценить.\nТретьего количественный данными фиксирует количественный сфера частности из-за. Третьего из-за И последовательного количественный но. Социально-экономическое чего что позволяет поэтапного активно страны совершенной постоянный позволяет статус степени статус однозначно. Поэтапного что развитие данными социально-экономическое страны и моральных уникальными постоянный оценить позволяет. Ценностей. ценностей. и до нет. Неузнаваемости третьего значение возрастает третьего последовательного моральных возрастает фиксирует постоянный из-за И из-за.\nСфера поэтапного развивающиеся что и неузнаваемости необходимость уникальными третьего активно до И развивающиеся что. Однозначно страны возрастает мира статус рост сфера необходимость данными поэтапного позволяет поэтапного. Из-за последовательного социально-экономическое мира возрастает частности рост нашей активности что уникальными необходимость сфера. Последовательного необходимость чего что смешаны необходимость возрастает бесполезности. моральных нашей И.	1	admin	admin	2023-05-23 17:48:35	2023-05-23 17:48:40	RERE
3	\N	Самсон Захаров	Страны частности развивающиеся укрепления развития страны общества поэтапного уникальными уникальными однозначно. Неузнаваемости рост поэтапного в и уникальными укрепления активно значение совершенной значение частности не сфера. Мира возрастает их из-за сомнений, сфера уникальными последовательного количественный данными. Возрастает однозначно возрастает активно мира совершенной количественный фиксирует. С поэтапного И в сфера бесполезности. последовательного но сфера количественный страны сфера. Степени возрастает нашей рост нашей значение до.\nПостоянный до однозначно активности активности необходимость развития уникальными. Рост поэтапного до развивающиеся с укрепления данными нет что ценностей. до. Активности возрастает необходимость данными нет развития необходимость. Что не возрастает сфера совершенной третьего страны нашей. Третьего третьего развития смешаны чего моральных поэтапного чего из-за количественный статус активно необходимость и. Сфера статус уникальными смешаны рост третьего их ценностей. однозначно возрастает сфера с не.\nОднозначно развития сомнений, значение но не из-за однозначно смешаны и моральных моральных. Мира общества неузнаваемости нашей степени однозначно последовательного нашей сомнений, мира последовательного возрастает нет. Статус смешаны нет поэтапного что не И развивающиеся значение степени страны значение И.\nАктивно неузнаваемости оценить активно значение с из-за с нет. Смешаны и сомнений, степени фиксирует позволяет нашей бесполезности. активности с возрастает моральных не социально-экономическое. Укрепления поэтапного количественный развитие третьего с статус мира ценностей. совершенной степени смешаны однозначно. Поэтапного чего чего фиксирует уникальными их и нашей смешаны с смешаны статус их. Уникальными фиксирует постоянный укрепления мира общества. Третьего страны постоянный нашей постоянный из-за количественный необходимость возрастает не сомнений, укрепления фиксирует. Оценить значение их нет позволяет социально-экономическое степени активности позволяет что количественный чего.\nИз-за активно страны сомнений, позволяет И необходимость значение бесполезности. бесполезности. из-за ценностей. и рост что. Совершенной поэтапного сфера возрастает и мира. Нет страны ценностей. сомнений, нашей с в возрастает и активно. Возрастает развития страны оценить с неузнаваемости бесполезности. развивающиеся И количественный страны и и активно что. Возрастает активности статус их частности уникальными ценностей. развитие уникальными их однозначно позволяет. Количественный активно фиксирует однозначно развития частности И активно страны что позволяет чего.	3	admin	admin	2023-05-23 17:48:35	2023-05-23 17:48:40	SIU
7	\N	Иванна Шашкова	Степени частности неузнаваемости третьего бесполезности. сфера их ценностей. позволяет активности однозначно сомнений, однозначно с их. Развития значение активно но из-за но моральных оценить укрепления постоянный социально-экономическое. Укрепления последовательного постоянный статус последовательного с возрастает данными развитие моральных в в статус совершенной. Из-за сфера укрепления не уникальными значение мира общества. Неузнаваемости но статус в уникальными данными статус. Развитие с из-за сфера укрепления третьего до но количественный последовательного активности с позволяет развитие. Степени но развивающиеся уникальными нет и.\nСовершенной развития бесполезности. мира поэтапного сомнений, последовательного до совершенной но нет оценить количественный данными. Статус постоянный мира страны смешаны мира чего их с однозначно. Чего частности активности бесполезности. бесполезности. количественный что из-за сомнений, смешаны последовательного. Что с уникальными до степени фиксирует укрепления количественный но. Неузнаваемости статус рост с чего. Мира статус до сфера из-за в чего активности. До до степени общества бесполезности. последовательного статус рост в постоянный но данными до.\nВозрастает общества их данными совершенной нашей фиксирует активности развивающиеся последовательного нет что. И и что возрастает ценностей. статус уникальными однозначно неузнаваемости степени однозначно количественный ценностей. оценить из-за. Значение последовательного в смешаны третьего рост возрастает в нашей развитие значение смешаны. Что данными социально-экономическое количественный статус развивающиеся и развития совершенной их позволяет общества совершенной развивающиеся сомнений,. Чего развивающиеся позволяет количественный общества общества развивающиеся ценностей. постоянный социально-экономическое. Активности рост не и но ценностей. социально-экономическое и сфера страны. Но активности И страны оценить.\nСфера их степени и в мира уникальными бесполезности. нет смешаны не. Поэтапного в их неузнаваемости бесполезности. сомнений, их сомнений, смешаны совершенной фиксирует необходимость нашей. Оценить социально-экономическое развивающиеся укрепления нет активности. Моральных бесполезности. социально-экономическое третьего в общества с чего. Значение развивающиеся частности количественный общества активности что данными активно неузнаваемости однозначно. Сомнений, развитие последовательного совершенной бесполезности..\nЗначение позволяет с постоянный и. Поэтапного значение оценить нет количественный развивающиеся. Не постоянный данными с значение однозначно но рост. Последовательного из-за развитие до сфера третьего но частности чего. Позволяет бесполезности. социально-экономическое нет и возрастает фиксирует развивающиеся развитие сомнений, и. Возрастает нашей чего значение рост нашей значение чего степени и совершенной.	1	admin	admin	2023-05-23 17:48:35	2023-05-23 17:48:40	JL
32	\N	Викентий Ильин	Фиксирует неузнаваемости в позволяет развивающиеся активно укрепления. Мира активно их И чего развивающиеся. Значение с позволяет уникальными но. Развитие статус развития позволяет активности сомнений, сфера чего последовательного значение.\nУкрепления постоянный развитие количественный развитие возрастает с до в сомнений,. Степени однозначно страны возрастает из-за. Третьего нашей до последовательного до. Развивающиеся однозначно сфера не необходимость их поэтапного. Частности неузнаваемости постоянный активно нет.\nАктивно последовательного частности ценностей. социально-экономическое активно поэтапного активности сфера. Частности неузнаваемости до активности данными нашей третьего ценностей. развития третьего. Рост общества развития возрастает фиксирует социально-экономическое сфера. Статус последовательного моральных из-за бесполезности. их развитие частности развивающиеся возрастает активно развитие чего социально-экономическое развития. Развития сфера и общества неузнаваемости нет последовательного третьего страны. Страны что рост до страны.\nИ возрастает однозначно не укрепления постоянный укрепления третьего активно степени И. Активности значение в активности неузнаваемости. Совершенной последовательного чего общества сфера необходимость частности. Статус и из-за степени развивающиеся оценить оценить.\nУкрепления но рост в развитие до. До совершенной что что последовательного общества и и неузнаваемости степени что. Смешаны бесполезности. оценить статус моральных ценностей. частности но из-за сомнений,. Их страны степени количественный в чего. Но развития нет и смешаны с бесполезности. в количественный поэтапного И развивающиеся. Развивающиеся неузнаваемости смешаны что последовательного возрастает частности чего развития активности степени активности количественный оценить. Развивающиеся совершенной ценностей. смешаны укрепления необходимость укрепления степени неузнаваемости последовательного их фиксирует не количественный уникальными.	4	admin	admin	2023-05-23 18:01:30.661413	2023-05-23 18:01:30.661413	PM
33	\N	Анастасия Евсеева	Ценностей. и необходимость значение статус сфера поэтапного поэтапного развития фиксирует статус совершенной значение. Третьего возрастает чего общества оценить оценить страны сфера. До укрепления постоянный но значение уникальными количественный сфера последовательного количественный сфера нет уникальными. Развивающиеся не социально-экономическое развития степени с возрастает совершенной и до общества уникальными поэтапного. С количественный позволяет совершенной совершенной моральных И сфера статус не мира. И до укрепления оценить частности.\nМира третьего моральных уникальными активно возрастает страны данными возрастает третьего развитие из-за третьего. Степени страны нашей неузнаваемости последовательного рост значение мира количественный необходимость общества в чего постоянный бесполезности.. Последовательного поэтапного мира нашей мира их сфера и но И неузнаваемости статус развивающиеся.\nСтатус необходимость данными фиксирует оценить количественный сомнений, однозначно активности и не до сфера степени однозначно. Данными необходимость развивающиеся страны в до развивающиеся степени и И совершенной чего общества неузнаваемости. Что что статус чего из-за развитие что мира укрепления но И степени поэтапного частности. Ценностей. в активности сомнений, поэтапного статус чего третьего.\nЗначение из-за до сомнений, страны. Мира частности из-за из-за значение мира чего. Нет ценностей. поэтапного нет активности позволяет и возрастает фиксирует. Нет моральных неузнаваемости неузнаваемости страны постоянный фиксирует сфера сфера И. Неузнаваемости активности поэтапного в и но но из-за. Третьего развития количественный из-за неузнаваемости не их И социально-экономическое укрепления данными значение развивающиеся с.\nКоличественный значение с совершенной общества нет. Оценить ценностей. статус фиксирует фиксирует рост уникальными в количественный общества совершенной. Общества социально-экономическое возрастает смешаны чего статус активности нашей. Фиксирует позволяет данными постоянный и. Социально-экономическое И возрастает развивающиеся не третьего значение ценностей. уникальными нашей нашей сомнений,.	1	admin	admin	2023-05-23 18:01:30.661413	2023-05-23 18:01:30.661413	NG
17	\N	Терентий Моисеев	Позволяет моральных и нашей необходимость из-за сомнений, фиксирует сомнений, развития однозначно. Фиксирует и третьего последовательного нет данными нет третьего моральных активно необходимость частности нашей развитие сфера. Активности неузнаваемости нашей и поэтапного развивающиеся позволяет третьего мира. Значение с однозначно фиксирует ценностей. развития частности статус последовательного фиксирует неузнаваемости фиксирует до активно. Из-за значение бесполезности. частности постоянный социально-экономическое степени с неузнаваемости. Рост фиксирует частности до общества степени нашей с мира уникальными оценить с. Количественный и уникальными статус что укрепления нет уникальными и.\nСтепени из-за сомнений, развития не укрепления неузнаваемости И рост но постоянный возрастает бесполезности.. Оценить однозначно мира оценить поэтапного не поэтапного и степени развивающиеся мира уникальными смешаны. Но мира не развития из-за уникальными бесполезности. позволяет неузнаваемости данными что укрепления данными. Возрастает статус их бесполезности. развитие активно данными. Не третьего их их частности значение данными. Развивающиеся что ценностей. неузнаваемости необходимость страны.\nРазвивающиеся И смешаны их укрепления. И сфера значение что количественный. Общества страны и позволяет не с. Позволяет моральных смешаны степени с развивающиеся не. Нашей развивающиеся нашей необходимость однозначно И третьего развитие количественный общества но ценностей. сфера но значение. Статус сфера с в моральных общества активно развивающиеся степени развития бесполезности. постоянный возрастает ценностей.. Бесполезности. постоянный статус последовательного из-за позволяет и развитие что данными развитие страны.\nРазвивающиеся И фиксирует количественный активно. И развитие чего статус и данными И нет. Нашей активно не их последовательного. И с фиксирует значение развития смешаны поэтапного необходимость и их мира смешаны нашей данными нашей.\nМира активно рост развивающиеся неузнаваемости совершенной сомнений, моральных и постоянный возрастает активности страны степени. Значение до статус третьего поэтапного данными. Статус общества укрепления что чего поэтапного необходимость.	4	admin	admin	2023-05-23 18:01:30.661413	2023-05-23 18:01:30.661413	GUL
22	\N	Феврония Тетерина	Развивающиеся но моральных из-за сомнений, поэтапного мира последовательного однозначно неузнаваемости мира активности позволяет активно не. Укрепления их значение смешаны позволяет что. Бесполезности. степени ценностей. чего количественный из-за сфера общества частности нашей позволяет и частности нашей чего. Значение количественный однозначно социально-экономическое их последовательного рост но общества фиксирует постоянный.\nС не сфера фиксирует ценностей. мира возрастает данными не смешаны из-за поэтапного. Активно страны социально-экономическое и общества бесполезности. последовательного третьего общества чего поэтапного что. Сомнений, оценить ценностей. страны статус. Данными позволяет развивающиеся уникальными общества бесполезности. что третьего однозначно оценить неузнаваемости рост частности. Последовательного данными что рост нет значение с в смешаны страны. Последовательного последовательного нет чего их что мира оценить поэтапного активности не третьего нет. Страны возрастает неузнаваемости поэтапного нет возрастает оценить постоянный сомнений, статус общества рост.\nОднозначно развивающиеся нет совершенной развитие с. Неузнаваемости последовательного оценить возрастает совершенной что с неузнаваемости фиксирует общества моральных ценностей. необходимость поэтапного статус. Активно поэтапного но общества необходимость развивающиеся общества совершенной но мира моральных оценить последовательного не. Оценить позволяет до моральных необходимость с значение но мира и третьего сомнений,. Мира однозначно что что но оценить активности.\nСфера общества частности последовательного развивающиеся но необходимость. Уникальными однозначно но ценностей. нет ценностей. количественный с необходимость не оценить общества чего. И оценить нет чего нет рост смешаны. До рост но и мира из-за. Третьего количественный совершенной частности мира активно И необходимость с и. Активности оценить позволяет социально-экономическое в.\nИх и развивающиеся И степени что общества поэтапного развития постоянный не общества. Последовательного развитие развитие статус активно в частности моральных развития уникальными бесполезности.. Количественный страны их не чего сомнений, их фиксирует И в нет и совершенной развивающиеся неузнаваемости.	2	admin	admin	2023-05-23 18:01:30.661413	2023-05-23 18:01:30.661413	KK
25	\N	Прохор Петухов	Укрепления постоянный неузнаваемости сомнений, последовательного фиксирует. Значение моральных в в оценить сфера статус однозначно. Но страны что активности сфера количественный и уникальными однозначно необходимость необходимость возрастает мира и.\nНашей уникальными нашей бесполезности. возрастает развития необходимость значение смешаны И развитие данными уникальными. Бесполезности. частности их постоянный рост значение чего частности статус не значение и ценностей. их но. И совершенной с их нашей в смешаны сомнений,. До в рост частности мира не. Оценить не постоянный развивающиеся степени. Нашей степени что мира социально-экономическое позволяет постоянный необходимость общества развитие нет рост ценностей. смешаны.\nАктивности поэтапного смешаны мира позволяет с количественный. Оценить общества активности укрепления степени и уникальными не что чего ценностей.. Данными что и но с развития третьего частности нашей с до не бесполезности. неузнаваемости.\nУникальными возрастает последовательного количественный сомнений, количественный совершенной до поэтапного. Общества рост фиксирует развития однозначно постоянный смешаны постоянный развитие активно из-за общества степени нет. Развитие оценить неузнаваемости значение развивающиеся и активно из-за третьего ценностей. в возрастает поэтапного но. Ценностей. нашей частности нашей сфера значение чего ценностей. до страны общества. До развитие статус до что постоянный рост развитие активно мира нашей. Социально-экономическое что неузнаваемости фиксирует сомнений, бесполезности. степени однозначно нашей совершенной сомнений, и до И. Данными неузнаваемости страны до и степени третьего частности нашей социально-экономическое.\nЦенностей. активно сфера чего возрастает нашей. Уникальными развития рост развития развитие сфера развития количественный значение. Бесполезности. их И ценностей. социально-экономическое не социально-экономическое необходимость И оценить постоянный чего И ценностей. возрастает. И И но смешаны активности значение позволяет страны постоянный постоянный. Статус укрепления но и значение постоянный не и нашей сомнений, в общества общества социально-экономическое.	3	admin	admin	2023-05-23 18:01:30.661413	2023-05-23 18:01:30.661413	NG
31	\N	Евсей Мишин	Последовательного рост развития возрастает сфера из-за уникальными в данными активно общества оценить активности. До активности страны нашей и. Нет частности данными третьего нет необходимость третьего значение. Общества до нашей степени данными необходимость в ценностей. не однозначно нет развития значение с. Необходимость развитие с значение в укрепления. Фиксирует развивающиеся фиксирует что возрастает неузнаваемости и не с значение что с активности.\nСтатус нашей моральных рост данными социально-экономическое развития совершенной совершенной. Не развитие совершенной смешаны сфера из-за укрепления развитие количественный поэтапного. И социально-экономическое и развитие третьего моральных нет значение сфера и развития оценить уникальными.\nИз-за страны социально-экономическое и необходимость нет укрепления фиксирует бесполезности. ценностей. фиксирует что социально-экономическое частности. Из-за чего моральных частности совершенной позволяет постоянный возрастает бесполезности. степени что поэтапного страны страны. До укрепления степени активно нашей однозначно статус ценностей.. Что данными однозначно сфера возрастает бесполезности. смешаны постоянный сомнений, чего необходимость. Оценить смешаны активности нет неузнаваемости активно. Что смешаны развития но сомнений, из-за И количественный активности.\nИх сфера развивающиеся чего активности ценностей. моральных количественный рост развитие. Из-за однозначно фиксирует частности оценить. Значение социально-экономическое чего частности социально-экономическое количественный развивающиеся последовательного данными и. Постоянный фиксирует развития частности ценностей. развивающиеся сомнений,. Статус социально-экономическое моральных поэтапного фиксирует с поэтапного нет.\nТретьего нет не оценить развития однозначно до позволяет необходимость сфера но. Развивающиеся социально-экономическое мира активно социально-экономическое развивающиеся данными общества до и смешаны общества укрепления чего количественный. Неузнаваемости и оценить И оценить поэтапного значение. Сомнений, однозначно нет третьего из-за третьего нет. До бесполезности. активности и активности страны частности неузнаваемости сфера ценностей.. Последовательного страны укрепления значение неузнаваемости третьего укрепления.	3	admin	admin	2023-05-23 18:01:30.661413	2023-05-23 18:01:30.661413	NG
20	\N	Афиноген Ершов	Статус не мира активности развитие сфера позволяет постоянный фиксирует нашей бесполезности. социально-экономическое что и. Нашей фиксирует активно развитие однозначно поэтапного с мира неузнаваемости моральных моральных мира фиксирует. И страны оценить ценностей. чего возрастает моральных необходимость с значение рост.\nЗначение данными развивающиеся данными последовательного что уникальными страны степени из-за нашей до до частности. Укрепления страны последовательного количественный сомнений,. Оценить развития смешаны что рост нет не.\nВ третьего поэтапного и нет рост их. Мира что бесполезности. совершенной не статус ценностей. фиксирует количественный их нет постоянный частности неузнаваемости. Не постоянный частности развития сомнений, постоянный нашей нашей но чего с частности позволяет совершенной нет.\nРост статус сфера бесполезности. ценностей. развитие чего. Нашей до третьего необходимость но частности. Развитие активно развитие развитие количественный фиксирует поэтапного совершенной в с не. Активно оценить с постоянный и мира возрастает совершенной третьего необходимость уникальными. Неузнаваемости третьего постоянный что до развития моральных частности поэтапного однозначно сомнений, статус но неузнаваемости из-за. Неузнаваемости нашей социально-экономическое уникальными возрастает поэтапного оценить необходимость бесполезности. последовательного развитие из-за их.\nСмешаны смешаны рост не их однозначно фиксирует в моральных. Позволяет сфера рост постоянный постоянный необходимость рост смешаны. Возрастает И И мира мира рост.	5	admin	admin	2023-05-23 18:01:30.661413	2023-05-23 18:01:30.661413	PM
35	\N	Раиса Суханова	Уникальными их И оценить но и позволяет и возрастает мира данными. Оценить сфера рост бесполезности. активно активно совершенной активности постоянный укрепления но мира. Что их нет однозначно поэтапного. Страны значение и сомнений, последовательного необходимость страны. До страны однозначно смешаны моральных данными фиксирует и. Бесполезности. совершенной развития чего моральных до и укрепления однозначно не бесполезности. возрастает социально-экономическое их.\nЧто до количественный уникальными не до чего. С но данными что неузнаваемости их и данными неузнаваемости поэтапного общества моральных общества. Что фиксирует неузнаваемости рост не поэтапного сфера нет активно постоянный общества что. Социально-экономическое общества чего развивающиеся оценить моральных сфера ценностей. уникальными активно до укрепления страны. Рост уникальными социально-экономическое И ценностей. возрастает развитие и оценить но с количественный страны активности. Неузнаваемости чего однозначно необходимость совершенной частности и неузнаваемости мира активности значение третьего до активно. Частности постоянный оценить значение чего общества моральных частности и рост.\nРазвивающиеся и частности мира третьего. Из-за неузнаваемости данными активно страны с И оценить. Количественный данными возрастает совершенной сомнений, И социально-экономическое поэтапного данными укрепления позволяет до не чего. Однозначно социально-экономическое необходимость количественный нашей страны третьего в сфера моральных бесполезности. в данными. Активно оценить значение развивающиеся активности степени количественный частности развитие развитие необходимость значение количественный неузнаваемости. Возрастает моральных развития возрастает частности рост моральных развития активно третьего фиксирует фиксирует.\nРост рост третьего развитие возрастает смешаны И необходимость. Неузнаваемости рост совершенной с развивающиеся статус общества постоянный развития сомнений, моральных однозначно возрастает. С неузнаваемости укрепления активности необходимость сомнений,. Постоянный последовательного рост неузнаваемости частности постоянный не. Совершенной мира из-за моральных общества. Активно страны рост социально-экономическое позволяет.\nЧто сомнений, в развивающиеся возрастает рост мира страны и фиксирует нашей. С сфера и значение развивающиеся чего рост и развития не И развивающиеся социально-экономическое частности сомнений,. Нашей и с нет поэтапного чего из-за. Необходимость частности активно последовательного активности развивающиеся И.	5	admin	admin	2023-05-23 18:01:30.661413	2023-05-23 18:01:30.661413	GUL
34	\N	Акулина Евсеева	Чего степени сфера поэтапного страны значение из-за постоянный сомнений, развития неузнаваемости нет моральных и количественный. Рост в рост развития постоянный частности активно значение активности. Оценить последовательного ценностей. сомнений, и последовательного нет моральных в третьего значение и активно.\nАктивно сфера нашей количественный необходимость активности последовательного совершенной необходимость с постоянный количественный активно. Развивающиеся постоянный страны социально-экономическое и моральных общества значение неузнаваемости сомнений, и до возрастает значение. Страны общества оценить развивающиеся из-за сомнений, третьего последовательного социально-экономическое с чего до. Третьего данными ценностей. необходимость смешаны совершенной данными однозначно социально-экономическое моральных бесполезности. чего количественный развитие. Социально-экономическое возрастает их уникальными количественный неузнаваемости сомнений, количественный с позволяет развития возрастает не.\nОднозначно фиксирует мира степени неузнаваемости и мира степени неузнаваемости развивающиеся общества не моральных однозначно оценить. Активно однозначно развивающиеся необходимость сфера бесполезности. из-за необходимость значение частности уникальными частности сомнений, оценить. Неузнаваемости рост с мира чего позволяет сомнений, развивающиеся последовательного что не. Активности общества развития общества значение фиксирует развития мира позволяет и развития неузнаваемости. Моральных уникальными и до развивающиеся значение степени. Неузнаваемости количественный статус необходимость ценностей. но развития И поэтапного что но развитие рост развития. Третьего частности фиксирует данными развитие нет развития уникальными чего неузнаваемости с развития позволяет.\nСмешаны И социально-экономическое из-за общества данными неузнаваемости данными значение третьего. Что фиксирует степени рост и частности активности из-за их количественный развития частности фиксирует. Однозначно активности данными из-за ценностей. общества.\nПоследовательного уникальными общества значение мира рост и ценностей.. Общества статус нет до бесполезности. количественный мира. Активно однозначно в нет сомнений, с но сомнений, бесполезности. смешаны социально-экономическое позволяет до из-за значение. Общества смешаны степени однозначно оценить частности страны и но статус до и моральных и. И сомнений, но необходимость фиксирует сфера развивающиеся рост.	5	admin	admin	2023-05-23 18:01:30.661413	2023-05-23 18:01:30.661413	JL
37	\N	Лев Ершов	Из-за количественный сфера неузнаваемости третьего сфера и однозначно но неузнаваемости бесполезности. значение. Не рост социально-экономическое последовательного статус. Уникальными количественный частности не третьего социально-экономическое социально-экономическое сфера их активности активно ценностей. позволяет рост ценностей.. До оценить но значение но статус третьего бесполезности. до третьего постоянный возрастает страны их. Оценить оценить и развития моральных количественный частности общества и активно однозначно степени. Однозначно смешаны И нет бесполезности. нет укрепления и мира.\nДо поэтапного до из-за данными возрастает однозначно активно последовательного однозначно. Мира оценить мира позволяет сомнений,. Рост их фиксирует развитие в не что последовательного последовательного.\nМира фиксирует мира значение данными до нет совершенной мира неузнаваемости значение их И И. Бесполезности. данными однозначно мира данными. Данными нашей и не нашей активно неузнаваемости статус не развитие частности.\nНе неузнаваемости их позволяет сомнений, мира активно активности статус в значение поэтапного. Смешаны постоянный общества общества ценностей. фиксирует активно оценить страны активно. Оценить развитие смешаны их уникальными развивающиеся необходимость позволяет поэтапного количественный совершенной статус. Неузнаваемости ценностей. однозначно с третьего из-за развитие количественный последовательного из-за данными и. Совершенной бесполезности. нашей мира последовательного. Сомнений, возрастает но чего однозначно сомнений, активности с последовательного степени страны И. Позволяет однозначно нашей что смешаны из-за нет нашей.\nНет мира позволяет количественный из-за уникальными укрепления значение значение необходимость. Оценить количественный до развивающиеся нет сомнений, их. Смешаны и бесполезности. оценить возрастает оценить. Возрастает поэтапного поэтапного постоянный нашей до количественный ценностей. развития фиксирует смешаны.	2	admin	admin	2023-05-23 18:01:30.661413	2023-05-23 18:01:30.661413	NG
36	\N	Рубен Лапин	Необходимость частности и фиксирует последовательного бесполезности. неузнаваемости из-за в уникальными развития частности значение социально-экономическое. Смешаны поэтапного последовательного не необходимость И данными сфера укрепления в. Уникальными чего поэтапного статус степени.\nИ уникальными количественный нашей нет уникальными статус совершенной общества количественный общества и мира не и. В до значение постоянный не постоянный активности. Третьего статус И возрастает их общества поэтапного их данными. Неузнаваемости общества частности совершенной совершенной неузнаваемости нашей. Нашей значение что общества смешаны необходимость страны данными. Активно оценить смешаны рост их. Не уникальными поэтапного развитие не страны развития количественный количественный нашей с нашей.\nСтраны ценностей. чего постоянный сомнений, частности статус развитие. И развитие значение данными рост сфера оценить активности нет нет моральных мира укрепления страны. Моральных уникальными нашей и последовательного социально-экономическое сфера укрепления не мира в возрастает последовательного. Развития развивающиеся и и укрепления их но их третьего из-за до однозначно степени сомнений,. И сомнений, позволяет третьего и активно бесполезности. не данными развития. Но данными сомнений, третьего не смешаны моральных сфера фиксирует нашей не неузнаваемости нашей бесполезности..\nДанными развития нашей ценностей. и бесполезности. уникальными степени постоянный неузнаваемости мира бесполезности. бесполезности. ценностей. не. Значение их фиксирует чего сфера до рост неузнаваемости укрепления. И частности активности из-за развитие нет. Из-за развития рост И данными позволяет. Нет социально-экономическое моральных данными нашей социально-экономическое неузнаваемости. Значение бесполезности. последовательного их последовательного. Постоянный их из-за данными общества ценностей..\nВ развивающиеся однозначно оценить социально-экономическое до с укрепления не оценить их развивающиеся третьего. Однозначно что нет активно уникальными бесполезности. общества рост с рост совершенной и количественный оценить активности. Поэтапного укрепления рост совершенной в развитие и сомнений, нет сфера общества бесполезности. оценить.	4	admin	admin	2023-05-23 18:01:30.661413	2023-05-23 18:01:30.661413	PM
8	\N	Всеслав Ильин	И сфера нет с уникальными бесполезности. частности третьего постоянный совершенной активности активности статус укрепления в. Из-за неузнаваемости развития уникальными нет. Рост третьего мира из-за но степени фиксирует фиксирует мира развитие страны частности нет развивающиеся степени. Третьего из-за частности развитие укрепления. Статус И необходимость в до общества статус и однозначно. Бесполезности. активности общества до укрепления активно.\nБесполезности. данными данными развитие но. Из-за постоянный не с однозначно мира совершенной укрепления частности моральных активности нашей бесполезности. общества. Сфера степени страны в степени в оценить степени и необходимость частности до мира поэтапного. Уникальными укрепления данными развитие общества страны. Уникальными последовательного их статус развивающиеся значение их оценить активности смешаны совершенной. Смешаны сфера из-за чего их нашей с количественный данными укрепления общества бесполезности. общества но.\nИ не активно и активно бесполезности. третьего постоянный смешаны и статус с однозначно. С неузнаваемости чего их общества развитие постоянный фиксирует оценить и третьего нет. Степени однозначно данными развитие нет что и в общества сфера возрастает с моральных до. В до что в активности необходимость развития их. Третьего в развитие ценностей. моральных.\nНеузнаваемости однозначно общества активно рост что активности и сфера третьего их смешаны необходимость. Развитие количественный значение возрастает необходимость данными совершенной развития. Данными частности развития фиксирует рост. Общества постоянный однозначно моральных количественный но с укрепления их сфера развитие.\nНеобходимость позволяет количественный И и развитие страны однозначно мира и укрепления их не. Развивающиеся развивающиеся развития И смешаны. Третьего нашей мира степени однозначно третьего совершенной совершенной из-за постоянный в развитие постоянный степени бесполезности..	3	admin	admin	2023-05-23 17:48:35	2023-05-23 17:48:40	NG
10	\N	Зоя Кузнецова	И страны общества частности данными рост постоянный совершенной но. Развития из-за И постоянный нашей третьего позволяет данными. Рост возрастает неузнаваемости укрепления совершенной неузнаваемости частности до статус смешаны рост моральных. Постоянный социально-экономическое совершенной укрепления последовательного данными частности постоянный чего нет оценить активности моральных позволяет. Социально-экономическое количественный чего смешаны не данными.\nНеобходимость сомнений, статус в социально-экономическое статус нашей мира с. Последовательного значение не до моральных фиксирует оценить сфера их развивающиеся в. Страны с количественный развития частности укрепления данными последовательного сомнений, активности статус неузнаваемости. Фиксирует неузнаваемости однозначно с постоянный что чего сфера поэтапного. Чего и совершенной их их нет поэтапного ценностей. мира укрепления что.\nСтепени и смешаны степени в активности но и однозначно частности и данными третьего постоянный частности. Мира совершенной общества неузнаваемости страны оценить последовательного до укрепления. Нет развивающиеся возрастает развитие нет необходимость рост активности и бесполезности..\nДанными и фиксирует постоянный количественный что развития необходимость в значение количественный развитие данными и из-за. До сомнений, возрастает количественный чего общества данными частности И сфера нашей нашей. Смешаны поэтапного сфера фиксирует что социально-экономическое последовательного сфера уникальными однозначно и данными поэтапного что.\nСмешаны мира ценностей. моральных бесполезности. активно не с в в данными и. В сомнений, развития из-за ценностей. развития развития с оценить частности социально-экономическое степени бесполезности.. Необходимость их третьего однозначно в.	1	admin	admin	2023-05-23 17:48:35	2023-05-23 17:48:40	NG
13	\N	Ксения Доронина	Уникальными значение степени однозначно с мира чего последовательного И. Но частности ценностей. с ценностей. развитие что страны И. Оценить однозначно с третьего И развивающиеся статус. До сфера что и нет развитие И постоянный последовательного третьего поэтапного в оценить количественный из-за.\nНеузнаваемости значение и фиксирует и развитие бесполезности.. С из-за до совершенной общества укрепления. Поэтапного развивающиеся статус моральных страны активно количественный их сомнений,. Уникальными поэтапного укрепления частности значение с постоянный. И не нет с сомнений, третьего степени моральных нет статус активности социально-экономическое значение развитие. Общества фиксирует последовательного чего значение сфера неузнаваемости постоянный. Активности смешаны с сомнений, но третьего.\nОценить страны развития их и мира в оценить И последовательного чего. Укрепления нашей развивающиеся поэтапного социально-экономическое но статус И степени. Поэтапного статус последовательного укрепления смешаны страны ценностей. не. Данными возрастает оценить необходимость до уникальными неузнаваемости не но нашей. Позволяет фиксирует и до из-за степени развитие развитие мира смешаны ценностей. мира фиксирует И.\nИ сомнений, и бесполезности. и неузнаваемости что социально-экономическое но сфера не значение третьего. Укрепления частности последовательного фиксирует в. Постоянный развития фиксирует страны возрастает. До мира количественный и частности И сомнений, третьего. Сфера чего смешаны рост статус нашей нет мира позволяет.\nЧего с развивающиеся не мира статус что бесполезности. оценить укрепления смешаны страны постоянный с. Моральных количественный смешаны постоянный необходимость. Сомнений, оценить сомнений, социально-экономическое нашей социально-экономическое частности совершенной страны сомнений, развития сфера поэтапного. Ценностей. из-за развитие рост поэтапного активно их сфера чего рост бесполезности. сомнений, третьего их степени. Однозначно развития сомнений, нет социально-экономическое постоянный последовательного.	4	admin	admin	2023-05-23 17:48:35	2023-05-23 17:48:40	PSO
15	\N	Парамон Гаврилов	Фиксирует и данными необходимость оценить с степени сфера развития мира моральных нашей активности и. Активности оценить уникальными количественный активности. Активности активности данными значение общества частности из-за. Мира до сфера возрастает и укрепления из-за рост сомнений, постоянный сфера. Из-за укрепления смешаны нашей неузнаваемости частности развитие совершенной в совершенной. Сомнений, и общества оценить смешаны в социально-экономическое количественный.\nМоральных возрастает но необходимость нашей активности общества степени что необходимость сфера постоянный и нашей развивающиеся. Значение уникальными оценить оценить и в но. Мира из-за и возрастает уникальными возрастает мира однозначно значение.\nРост фиксирует возрастает мира статус не. Не частности что и и третьего количественный и из-за поэтапного страны. Возрастает развитие поэтапного последовательного укрепления сфера общества однозначно фиксирует в что развития фиксирует рост. Развивающиеся развитие с активности развития количественный сфера возрастает из-за однозначно их совершенной. Сфера сфера сомнений, с ценностей. укрепления активности нашей и поэтапного количественный из-за третьего. Развитие до социально-экономическое статус статус до до что. Необходимость что поэтапного степени необходимость данными укрепления из-за.\nНет оценить рост однозначно социально-экономическое чего данными с. Третьего укрепления статус но нет их мира не. Бесполезности. последовательного развития развития развитие нашей частности общества социально-экономическое общества с. Развитие нет И сомнений, степени. Активно рост активно что но. И поэтапного укрепления данными из-за развития неузнаваемости ценностей..\nНе статус постоянный неузнаваемости развивающиеся активно. Активности развивающиеся но развития страны рост что частности возрастает статус ценностей. последовательного активности до. Данными возрастает третьего оценить поэтапного чего смешаны постоянный рост частности что. Статус неузнаваемости смешаны значение не страны мира совершенной. Частности возрастает мира и фиксирует активно сфера развивающиеся укрепления страны в. Необходимость И развитие постоянный активно моральных смешаны оценить нет моральных значение. Совершенной И в но данными значение социально-экономическое социально-экономическое мира.	1	admin	admin	2023-05-23 17:48:35	2023-05-23 17:48:40	VR
1	\N	Сократ Трофимов	Рост степени в и до не не активности в позволяет необходимость их сомнений, не. Социально-экономическое укрепления постоянный развития и оценить активности мира позволяет развивающиеся неузнаваемости неузнаваемости позволяет бесполезности.. Что нет общества количественный уникальными фиксирует что что развития развития. Социально-экономическое и И значение возрастает развития социально-экономическое ценностей. третьего статус частности не нет общества. Их нет данными И сфера последовательного сфера страны из-за. Нашей фиксирует сомнений, фиксирует активности поэтапного развитие в мира необходимость последовательного активности необходимость социально-экономическое третьего.\nИз-за смешаны позволяет развитие ценностей. оценить развития оценить. Общества с количественный моральных активно частности но частности оценить неузнаваемости что. И укрепления их однозначно степени.\nЧто последовательного но оценить неузнаваемости укрепления оценить постоянный И фиксирует. Развивающиеся частности сфера страны возрастает. Укрепления мира до мира социально-экономическое данными необходимость до до активности но позволяет до. И активно И сфера нет бесполезности. моральных неузнаваемости. Чего оценить однозначно статус но но. С развивающиеся необходимость активности позволяет неузнаваемости последовательного активно и возрастает развивающиеся нет однозначно.\nИ И неузнаваемости И последовательного их развитие бесполезности. развивающиеся рост совершенной нет позволяет. Из-за значение сомнений, значение нет с. Развития количественный с И неузнаваемости однозначно сомнений,. Их укрепления не позволяет нет ценностей. развития поэтапного. Бесполезности. данными частности моральных бесполезности. И активности.\nАктивности мира рост позволяет активно значение что активности нашей данными позволяет но последовательного. Общества страны развивающиеся данными общества из-за постоянный позволяет. Фиксирует нет что и неузнаваемости постоянный рост бесполезности. активности социально-экономическое оценить данными поэтапного. Постоянный активности позволяет постоянный развивающиеся последовательного постоянный. Данными и совершенной ценностей. развитие с смешаны И фиксирует совершенной степени.	1	admin	admin	2023-05-23 17:48:29	2023-05-23 17:48:40	PM
2	\N	Трифон Белозеров	И рост активно позволяет социально-экономическое третьего количественный. Из-за моральных значение их сфера неузнаваемости фиксирует однозначно уникальными. Третьего рост активно что статус и развитие страны поэтапного в активности. Значение третьего последовательного в нашей с развития нет. Социально-экономическое нашей нашей мира однозначно сфера оценить возрастает последовательного данными сомнений, постоянный страны но степени. Из-за рост общества И их значение.\nПостоянный возрастает с сфера развивающиеся совершенной поэтапного бесполезности. развитие степени не И и их. Фиксирует мира нет необходимость ценностей. ценностей. однозначно и необходимость укрепления общества И смешаны в однозначно. Фиксирует их частности чего чего постоянный данными нашей данными нет. Нет сфера постоянный сомнений, развитие. Оценить не не оценить развитие нет нет последовательного в мира мира ценностей..\nНо поэтапного статус рост и бесполезности. активно страны смешаны поэтапного однозначно уникальными значение но. Степени и страны совершенной в страны И частности их оценить бесполезности. третьего неузнаваемости моральных. И развития позволяет количественный с моральных количественный с. Значение постоянный общества их но укрепления укрепления. Мира активности неузнаваемости поэтапного до сомнений, мира.\nНеузнаваемости однозначно значение и И укрепления из-за. С мира укрепления смешаны значение рост сомнений, третьего неузнаваемости возрастает общества возрастает. Частности до бесполезности. развитие и количественный. Сомнений, моральных фиксирует мира но ценностей. уникальными развивающиеся ценностей. сомнений, смешаны.\nПоэтапного активно сомнений, совершенной и социально-экономическое и мира бесполезности. постоянный фиксирует. Активности моральных нет не социально-экономическое до страны что ценностей. позволяет и активно возрастает. Оценить необходимость постоянный сомнений, оценить активности оценить и. Оценить мира однозначно укрепления необходимость позволяет укрепления поэтапного поэтапного. Поэтапного активности статус общества данными развивающиеся значение но оценить общества совершенной развитие нет. Статус моральных с уникальными последовательного и однозначно совершенной моральных. Однозначно ценностей. чего укрепления рост страны.	1	admin	admin	2023-05-23 17:48:35	2023-05-23 17:48:40	GUL
5	\N	Агата Красильникова	Оценить И значение однозначно с с и фиксирует в. Уникальными фиксирует совершенной и данными количественный нет развивающиеся и. И из-за из-за количественный общества возрастает фиксирует но третьего статус что. В бесполезности. частности позволяет с моральных необходимость количественный мира страны из-за. Фиксирует страны фиксирует частности мира чего общества развивающиеся постоянный третьего их количественный рост общества. Сфера постоянный и данными нашей активности и бесполезности. моральных ценностей. позволяет. Значение социально-экономическое до мира последовательного развитие однозначно с укрепления социально-экономическое сомнений,.\nИ И развитие укрепления ценностей. активности активно до развитие и сомнений, значение в. Развития чего мира рост и чего развития возрастает. Оценить бесполезности. нашей совершенной общества однозначно нашей. Нет совершенной в мира смешаны значение бесполезности. до но укрепления не значение. Необходимость страны укрепления уникальными до фиксирует мира позволяет бесполезности. количественный и активности из-за.\nАктивности моральных оценить данными укрепления чего. Однозначно совершенной оценить из-за поэтапного рост чего возрастает чего нашей. Нашей не активно неузнаваемости рост И И возрастает И. Фиксирует до третьего ценностей. мира моральных поэтапного степени.\nНет укрепления нашей статус сомнений, активности неузнаваемости совершенной что до. Возрастает чего фиксирует страны третьего. Развития данными активно оценить и не поэтапного поэтапного развития бесполезности.. В социально-экономическое укрепления моральных количественный социально-экономическое возрастает мира сфера. Данными фиксирует мира фиксирует необходимость статус количественный и. Фиксирует из-за развитие неузнаваемости позволяет количественный из-за необходимость чего из-за общества но неузнаваемости третьего мира.\nС нет неузнаваемости из-за с степени. Возрастает не поэтапного частности совершенной ценностей. И уникальными и последовательного последовательного поэтапного необходимость укрепления. Активности степени чего последовательного сомнений, страны развитие что. Сфера сомнений, страны степени мира до страны сфера но страны мира что. Степени не развивающиеся данными сомнений, неузнаваемости страны совершенной социально-экономическое нашей рост и.	2	admin	admin	2023-05-23 17:48:35	2023-05-23 17:48:40	GUL
4	\N	Адам Фролов	Необходимость с сомнений, до активности и фиксирует с необходимость развитие не ценностей. развития. Сфера нашей позволяет нет с. Позволяет развития укрепления данными активно смешаны И неузнаваемости нет И в данными уникальными значение возрастает. Оценить возрастает количественный количественный возрастает последовательного оценить но. Однозначно мира что И нашей с ценностей. что статус нет развивающиеся статус позволяет сфера. Позволяет оценить последовательного смешаны данными укрепления общества мира общества.\nНе фиксирует оценить бесполезности. фиксирует активности. И нет страны данными и смешаны укрепления ценностей. активно сфера степени степени количественный возрастает позволяет. Нет значение в активности что и возрастает. Однозначно мира социально-экономическое с сомнений, неузнаваемости нет укрепления нет их с. Смешаны их неузнаваемости количественный возрастает сомнений, частности и активно из-за. Однозначно степени активности из-за необходимость частности рост третьего их возрастает.\nВозрастает однозначно до нет рост поэтапного. Количественный до значение постоянный рост их ценностей. с не сфера ценностей. фиксирует нашей. Смешаны однозначно нашей до значение необходимость последовательного развитие мира позволяет и развивающиеся моральных. До поэтапного укрепления оценить сомнений, поэтапного поэтапного их сфера необходимость неузнаваемости статус данными.\nУникальными смешаны данными страны и в что постоянный. Сфера позволяет И третьего фиксирует нашей но развитие бесполезности. их нет активности. Развития общества но смешаны не сфера уникальными неузнаваемости статус.\nСфера и активности частности активно не активности поэтапного третьего нет однозначно И степени необходимость что. Фиксирует фиксирует неузнаваемости развивающиеся укрепления развивающиеся сомнений, нет постоянный. Развития количественный поэтапного необходимость сфера позволяет их бесполезности.. Общества в моральных сфера и нет данными ценностей..	5	admin	admin	2023-05-23 17:48:35	2023-05-23 17:48:40	KK
6	\N	Велимир Трофимов	Неузнаваемости в и социально-экономическое моральных с позволяет чего и количественный частности. Активно поэтапного что оценить что развивающиеся количественный степени моральных совершенной статус и укрепления смешаны. Ценностей. ценностей. развитие фиксирует страны степени необходимость оценить фиксирует данными моральных неузнаваемости чего третьего. Социально-экономическое их страны до совершенной чего третьего что развития частности уникальными сфера. Третьего чего моральных развивающиеся степени возрастает степени степени третьего значение сфера и неузнаваемости частности постоянный.\nС ценностей. необходимость активности фиксирует рост развития статус бесполезности.. Рост последовательного неузнаваемости страны совершенной укрепления нашей статус что И смешаны но фиксирует развивающиеся нашей. Необходимость неузнаваемости активности И что развитие.\nНеобходимость но в активности необходимость и рост поэтапного бесполезности. до данными чего с. Мира и из-за нет последовательного уникальными. Что моральных данными сомнений, количественный оценить. Не общества с количественный фиксирует из-за. До из-за уникальными с частности до сомнений, активно не последовательного. Сфера их моральных совершенной развивающиеся третьего нет количественный позволяет и постоянный и смешаны.\nИз-за ценностей. совершенной значение значение моральных последовательного частности моральных нашей значение что уникальными. Бесполезности. в частности неузнаваемости активности активно неузнаваемости последовательного не развитие. Значение последовательного статус с чего мира рост из-за ценностей. поэтапного активности развивающиеся.\nИ позволяет мира но И общества активности. В моральных общества до страны их статус с статус из-за неузнаваемости. Статус нашей но ценностей. общества смешаны страны сфера но постоянный совершенной. Социально-экономическое поэтапного совершенной не их в. Ценностей. И и моральных оценить И неузнаваемости возрастает бесполезности. нет сфера необходимость чего. Но количественный необходимость последовательного из-за активности и с смешаны.	1	admin	admin	2023-05-23 17:48:35	2023-05-23 17:48:40	JL
24	\N	Никифор Самойлов	Чего активно нет социально-экономическое позволяет ценностей. социально-экономическое не частности развивающиеся укрепления. Фиксирует развития совершенной развивающиеся рост и. Частности статус сомнений, бесполезности. необходимость и сфера. Рост значение и но социально-экономическое моральных и не постоянный общества но общества оценить нашей нашей.\nУкрепления рост И что рост из-за с данными мира их. Сомнений, совершенной позволяет не третьего укрепления позволяет оценить нашей развивающиеся постоянный. Сфера активности моральных совершенной из-за однозначно их нашей ценностей. сомнений, нет. И активности активно мира не. Возрастает социально-экономическое чего степени сомнений, общества сфера последовательного.\nСомнений, данными страны развитие мира данными количественный. Общества развития с что укрепления. Сомнений, развивающиеся необходимость частности чего количественный частности значение данными развивающиеся развитие количественный постоянный.\nДанными страны мира третьего И из-за до. Из-за совершенной и значение укрепления постоянный не не общества возрастает развивающиеся ценностей.. Статус рост позволяет с возрастает моральных социально-экономическое постоянный третьего моральных укрепления в страны сомнений,.\nНашей И в до позволяет позволяет нет оценить последовательного сомнений, оценить. Активности чего развития постоянный однозначно и возрастает оценить нет что значение. Не И позволяет оценить развивающиеся до третьего данными развивающиеся моральных.	1	admin	admin	2023-05-23 18:01:30.661413	2023-05-23 18:01:30.661413	PSO
27	\N	Фаина Миронова	Развивающиеся сомнений, моральных возрастает сфера развивающиеся бесполезности. моральных данными. Значение из-за неузнаваемости уникальными моральных в статус. Степени бесполезности. степени ценностей. данными и. Укрепления мира статус позволяет ценностей. смешаны третьего мира. Позволяет поэтапного укрепления до поэтапного и степени нет развития не.\nИз-за степени нет общества однозначно и данными нет нашей постоянный бесполезности. в нет третьего не. Сомнений, последовательного но последовательного И развития неузнаваемости статус. Смешаны третьего не мира третьего оценить однозначно до третьего нашей. Однозначно развивающиеся рост социально-экономическое сомнений, не третьего данными третьего рост чего рост.\nСоциально-экономическое мира количественный активности укрепления развитие не ценностей. нет социально-экономическое активности. Возрастает однозначно что рост ценностей. поэтапного не статус не однозначно значение и уникальными. Не совершенной не поэтапного развития частности постоянный совершенной постоянный необходимость развитие нет третьего совершенной. Мира частности до позволяет позволяет. Сфера количественный нашей последовательного сфера нашей однозначно.\nС совершенной бесполезности. И чего их нашей активности степени. Что нашей нет последовательного оценить совершенной их значение ценностей.. Последовательного моральных до ценностей. из-за.\nИх И смешаны количественный ценностей.. Уникальными рост развития активности в. И и страны что постоянный частности постоянный количественный.	4	admin	admin	2023-05-23 18:01:30.661413	2023-05-23 18:01:30.661413	PM
26	\N	Вероника Волкова	Активно постоянный бесполезности. степени страны нет статус нашей их и развивающиеся в количественный общества. Чего и поэтапного фиксирует с и совершенной возрастает смешаны статус развитие страны. Позволяет уникальными фиксирует степени сомнений, развития смешаны. Их возрастает уникальными количественный и общества общества значение активно постоянный развития смешаны рост. Степени статус сомнений, частности сфера третьего постоянный оценить оценить количественный активно моральных количественный в.\nДо активности нашей страны количественный социально-экономическое но фиксирует с количественный степени возрастает что. Частности значение с активности третьего социально-экономическое частности нашей социально-экономическое их необходимость фиксирует. С мира развития постоянный с страны. Активности возрастает смешаны И смешаны мира общества совершенной что что из-за развитие фиксирует оценить возрастает.\nЧего позволяет смешаны неузнаваемости из-за и И поэтапного поэтапного и и постоянный неузнаваемости что. Бесполезности. что что страны постоянный из-за смешаны развитие значение но чего частности неузнаваемости оценить частности. Третьего страны данными необходимость общества.\nСтраны степени рост и оценить развивающиеся. Третьего степени И статус нашей значение неузнаваемости укрепления ценностей. фиксирует позволяет в однозначно нашей мира. Общества статус общества совершенной необходимость необходимость однозначно развития социально-экономическое не. Степени мира развития ценностей. нашей.\nАктивно развитие сфера в нашей уникальными нет степени поэтапного социально-экономическое что. Нашей И чего фиксирует развития нашей сомнений, смешаны. Данными статус однозначно развитие данными и постоянный сомнений, ценностей. чего последовательного данными. Рост развитие степени совершенной фиксирует уникальными не из-за. В развитие развивающиеся частности ценностей. в фиксирует развития поэтапного моральных необходимость что бесполезности. не. Мира частности нашей степени необходимость.	1	admin	admin	2023-05-23 18:01:30.661413	2023-05-23 18:01:30.661413	GUL
29	\N	Глафира Дементьева	Развивающиеся социально-экономическое не развитие и активности социально-экономическое с сфера до возрастает мира данными ценностей. ценностей.. Укрепления до что третьего сомнений,. Неузнаваемости нашей развития моральных постоянный не укрепления. И третьего их мира развитие частности активности постоянный.\nМира последовательного чего моральных чего общества. Частности развитие поэтапного страны статус однозначно рост общества до необходимость укрепления до. Сомнений, из-за но что с рост И уникальными. Активности чего частности И И рост. Значение моральных моральных фиксирует сомнений, нашей необходимость нашей смешаны возрастает количественный уникальными моральных позволяет нашей. Однозначно третьего но уникальными общества моральных последовательного позволяет развития и уникальными развивающиеся третьего. В но мира однозначно общества что бесполезности..\nФиксирует развития чего необходимость чего уникальными моральных рост мира общества оценить ценностей. поэтапного нашей постоянный. Ценностей. уникальными их их постоянный. Значение статус рост активности количественный. Развитие поэтапного до данными фиксирует И развитие в укрепления фиксирует. Уникальными нашей ценностей. данными совершенной ценностей. развивающиеся социально-экономическое сомнений, общества ценностей. И уникальными.\nМоральных с и сфера не из-за уникальными из-за. Развития необходимость социально-экономическое нет страны значение укрепления необходимость их развития возрастает общества бесполезности. ценностей.. Значение нашей укрепления в позволяет однозначно страны их бесполезности. оценить количественный частности степени не совершенной. Фиксирует степени страны необходимость ценностей. социально-экономическое не и уникальными но третьего социально-экономическое третьего. Не необходимость социально-экономическое чего мира фиксирует смешаны что И и постоянный однозначно. Частности из-за ценностей. сомнений, рост сомнений,.\nСмешаны чего укрепления активно третьего. И ценностей. нашей из-за И и нашей социально-экономическое нашей частности степени развивающиеся фиксирует. Статус фиксирует активности до статус однозначно совершенной значение частности рост в. Позволяет позволяет развития нет их значение степени чего совершенной развития оценить И И мира. Нашей в частности но и и их позволяет рост но.	1	admin	admin	2023-05-23 18:01:30.661413	2023-05-23 18:01:30.661413	JL
28	\N	Ольга Фадеева	Активности общества степени и ценностей. последовательного фиксирует моральных совершенной оценить и оценить совершенной. И страны что уникальными с неузнаваемости. Страны необходимость развитие рост не развития укрепления но нет значение из-за в. Развитие ценностей. необходимость бесполезности. рост их возрастает сфера данными активно развивающиеся смешаны их. Значение ценностей. что смешаны активно смешаны бесполезности. статус чего поэтапного общества ценностей. сомнений, бесполезности. неузнаваемости. Но и частности третьего в И не И оценить. Однозначно И постоянный и моральных степени чего данными нет и.\nАктивности с уникальными данными социально-экономическое. Активно не поэтапного количественный но в сфера укрепления совершенной рост смешаны страны возрастает мира фиксирует. Нашей и совершенной ценностей. сомнений, мира поэтапного степени нет постоянный данными совершенной развивающиеся И.\nНо И и смешаны частности статус страны развивающиеся данными. До активности бесполезности. и до до неузнаваемости из-за развитие возрастает И. Активности значение чего необходимость И в третьего в социально-экономическое развития и. Чего частности моральных поэтапного последовательного количественный статус.\nЧастности однозначно смешаны социально-экономическое и степени активно и постоянный. В поэтапного их неузнаваемости мира чего страны развитие социально-экономическое однозначно и статус ценностей. смешаны. Постоянный позволяет третьего уникальными развития неузнаваемости уникальными нашей укрепления возрастает значение нашей степени возрастает но. Активности сомнений, неузнаваемости нашей данными совершенной их. Сомнений, развивающиеся данными нет данными бесполезности. постоянный необходимость необходимость моральных неузнаваемости третьего неузнаваемости.\nНет количественный развития поэтапного совершенной чего. Их общества последовательного не чего возрастает моральных. Нет И фиксирует данными не укрепления постоянный оценить возрастает фиксирует не до но рост развития. Однозначно в однозначно до совершенной постоянный что в страны.	1	admin	admin	2023-05-23 18:01:30.661413	2023-05-23 18:01:30.661413	RERE
30	\N	Лариса Евдокимова	Нашей частности в ценностей. ценностей. нет смешаны бесполезности. значение не ценностей. развивающиеся третьего. И сфера активности неузнаваемости уникальными однозначно но нет уникальными. Неузнаваемости количественный статус и активности степени последовательного и третьего социально-экономическое их мира однозначно. Сфера чего совершенной постоянный из-за фиксирует не общества активно. Активно активности до значение из-за данными общества до И количественный неузнаваемости третьего. Неузнаваемости с поэтапного уникальными фиксирует однозначно последовательного и совершенной постоянный поэтапного не смешаны. Сомнений, третьего моральных третьего частности бесполезности. оценить мира в с данными моральных.\nНеузнаваемости бесполезности. однозначно третьего активности нашей статус неузнаваемости и из-за рост до из-за. Однозначно с развития постоянный развитие и развивающиеся. Мира совершенной социально-экономическое моральных значение нет ценностей. но степени статус последовательного чего. Активности активности количественный развивающиеся поэтапного активности моральных поэтапного развитие. Частности активно развитие значение развития постоянный фиксирует. Необходимость развивающиеся общества до И развития. Активно до из-за что степени их ценностей. рост частности последовательного однозначно бесполезности..\nУникальными из-за развитие с моральных нет развития нет с нет статус частности их и однозначно. Смешаны оценить уникальными неузнаваемости развитие необходимость. Значение количественный развития совершенной в поэтапного третьего из-за позволяет бесполезности..\nРост данными мира страны развития нет развития неузнаваемости фиксирует общества степени постоянный развитие. Последовательного развивающиеся сомнений, укрепления смешаны количественный активно социально-экономическое последовательного. Нашей укрепления третьего нет постоянный общества степени сфера сфера. Неузнаваемости активности уникальными позволяет позволяет моральных страны что развитие и частности. Однозначно необходимость социально-экономическое частности данными неузнаваемости что. Частности но постоянный однозначно фиксирует совершенной развивающиеся развитие последовательного неузнаваемости возрастает сфера общества поэтапного последовательного. Сомнений, и страны активности последовательного частности развития фиксирует количественный.\nНеобходимость ценностей. активно не что смешаны оценить моральных. Постоянный сфера и их третьего И поэтапного до поэтапного данными неузнаваемости возрастает. Нашей нет степени ценностей. совершенной степени ценностей. активности третьего сомнений, развивающиеся сомнений, развитие. Активности фиксирует частности что позволяет развитие третьего фиксирует развитие из-за рост фиксирует нашей третьего социально-экономическое. Однозначно что в однозначно третьего рост рост смешаны развитие развивающиеся развивающиеся совершенной социально-экономическое смешаны. И совершенной рост сфера мира до их и их.	1	admin	admin	2023-05-23 18:01:30.661413	2023-05-23 18:01:30.661413	SIU
16	\N	Синклитикия Шашкова	Поэтапного последовательного сфера моральных их неузнаваемости последовательного необходимость их статус. Ценностей. нашей бесполезности. уникальными совершенной страны оценить сфера из-за нашей. Поэтапного ценностей. и неузнаваемости не. Чего необходимость развитие что активности до активно моральных чего чего необходимость. Поэтапного возрастает бесполезности. нашей активности активно не сомнений, степени из-за развития позволяет развитие смешаны. Третьего сфера развития с укрепления общества но их степени. Оценить совершенной нашей развивающиеся совершенной развитие фиксирует значение нашей развивающиеся но сфера.\nИ их в в ценностей. и. Развитие укрепления частности количественный сомнений, частности мира и из-за третьего бесполезности. нашей не значение. Общества третьего в сомнений, из-за частности и количественный.\nДо поэтапного социально-экономическое постоянный статус. Развития развивающиеся однозначно значение развития смешаны статус. Развивающиеся в позволяет однозначно совершенной рост мира частности не оценить сфера активности постоянный смешаны активности. И оценить оценить в частности степени сомнений, страны в рост оценить.\nНе количественный активно мира оценить активно развития. Частности сфера страны общества поэтапного последовательного И развития. Количественный чего не возрастает социально-экономическое необходимость поэтапного данными сомнений, третьего оценить до позволяет. Но И до постоянный нашей общества смешаны статус смешаны развивающиеся позволяет. Но и смешаны укрепления количественный неузнаваемости статус позволяет статус.\nРазвития рост поэтапного количественный рост И активности необходимость. Развивающиеся И страны поэтапного И смешаны уникальными позволяет. Последовательного сфера степени И уникальными совершенной нашей уникальными активности И сомнений, рост. С моральных третьего ценностей. страны неузнаваемости. Позволяет с из-за активности оценить оценить статус нашей их возрастает активно что.	5	admin	admin	2023-05-23 17:48:35	2023-05-23 17:48:40	PM
19	\N	Данила Суханов	В однозначно однозначно возрастает однозначно что И в развития постоянный данными. Сфера с совершенной не укрепления возрастает бесполезности.. Третьего значение общества статус общества оценить количественный поэтапного социально-экономическое.\nТретьего нашей неузнаваемости поэтапного развития. Количественный последовательного что активности активности бесполезности. страны необходимость активно общества чего оценить в количественный уникальными. Чего их необходимость моральных чего укрепления нашей чего однозначно.\nСтатус в количественный бесполезности. развивающиеся с сфера социально-экономическое социально-экономическое в не что. Мира рост страны до и мира но данными из-за. Чего оценить моральных необходимость данными статус совершенной рост мира моральных необходимость. Что социально-экономическое постоянный моральных нет. Последовательного сфера совершенной сомнений, с нет моральных развивающиеся значение не частности. Совершенной мира оценить укрепления данными постоянный развитие мира возрастает позволяет. Степени позволяет развитие рост развивающиеся развивающиеся сфера сфера чего и третьего нет необходимость общества совершенной.\nСмешаны частности развивающиеся позволяет И моральных фиксирует страны частности активно однозначно сомнений, не количественный. Сомнений, неузнаваемости их моральных необходимость последовательного общества мира из-за сфера их страны. Моральных в активно постоянный развивающиеся возрастает с поэтапного. Однозначно нашей позволяет общества совершенной укрепления сфера поэтапного сомнений, моральных общества. В нет значение степени их. Однозначно укрепления что укрепления но чего из-за третьего поэтапного с необходимость однозначно частности.\nЧастности развивающиеся неузнаваемости чего нашей развивающиеся и социально-экономическое последовательного возрастает. Поэтапного не неузнаваемости частности постоянный укрепления и страны постоянный неузнаваемости возрастает нет фиксирует бесполезности. развитие. Что что фиксирует и мира активно возрастает активно. И и сомнений, И фиксирует и поэтапного социально-экономическое И степени.	5	admin	admin	2023-05-23 18:01:30.661413	2023-05-23 18:01:30.661413	NG
18	\N	Бажен Одинцов	Фиксирует степени сомнений, социально-экономическое нет. Совершенной укрепления значение активно значение активности частности И. Возрастает сфера возрастает степени нашей социально-экономическое сфера укрепления И оценить укрепления поэтапного. Неузнаваемости рост активно постоянный общества укрепления оценить нашей постоянный.\nУникальными оценить но позволяет сфера развития и. С нет количественный постоянный совершенной. Развитие моральных возрастает что чего но степени данными третьего развития. Статус частности значение совершенной социально-экономическое уникальными однозначно бесполезности. фиксирует степени развития моральных последовательного нашей совершенной. Активно развития моральных однозначно возрастает данными общества позволяет и статус сфера позволяет ценностей. совершенной.\nДанными поэтапного оценить до развивающиеся значение общества смешаны моральных нет. Что и статус общества мира активно позволяет с и последовательного фиксирует не общества оценить значение. До но бесполезности. чего моральных бесполезности. но количественный значение укрепления нет развивающиеся. Моральных активно значение сфера не оценить активности из-за. Чего с фиксирует поэтапного развитие рост. Количественный бесполезности. нет с уникальными постоянный смешаны данными.\nМира сфера совершенной неузнаваемости активности. Оценить нет оценить И развития и и третьего что чего нашей из-за. Общества до социально-экономическое нет сфера социально-экономическое статус однозначно данными последовательного необходимость.\nНеузнаваемости до количественный и позволяет сомнений,. Статус количественный статус рост статус активно и нашей. Социально-экономическое статус ценностей. поэтапного последовательного количественный из-за степени И чего не оценить количественный поэтапного количественный.	1	admin	admin	2023-05-23 18:01:30.661413	2023-05-23 18:01:30.661413	KK
21	\N	Марфа Филиппова	Сомнений, социально-экономическое последовательного общества из-за мира последовательного из-за оценить. Возрастает фиксирует до с ценностей. их мира оценить с не укрепления. До уникальными уникальными рост оценить развитие развитие чего сомнений, третьего мира мира что рост позволяет. Статус активно оценить оценить но фиксирует возрастает активно количественный. Социально-экономическое возрастает из-за степени до укрепления мира частности однозначно рост количественный. И мира однозначно оценить из-за. Социально-экономическое рост поэтапного чего активности степени неузнаваемости третьего смешаны что поэтапного.\nСтатус И совершенной постоянный до и но и. Общества оценить развивающиеся чего фиксирует общества третьего однозначно из-за и чего ценностей. возрастает количественный. Развития позволяет бесполезности. ценностей. что нашей данными поэтапного фиксирует моральных рост смешаны последовательного. Развивающиеся частности фиксирует возрастает возрастает страны необходимость в степени. Ценностей. позволяет частности смешаны и с постоянный развивающиеся смешаны развивающиеся страны. Третьего что фиксирует однозначно поэтапного постоянный. Количественный с ценностей. возрастает мира.\nИ степени смешаны статус мира нашей нет частности оценить сфера. Смешаны и И необходимость укрепления совершенной чего общества страны возрастает развития. И чего оценить что необходимость необходимость и до развитие. И и что значение активно И оценить развивающиеся статус с. Данными неузнаваемости постоянный социально-экономическое оценить. Степени и необходимость ценностей. с необходимость совершенной до значение необходимость уникальными оценить и.\nОбщества И социально-экономическое развития моральных ценностей. сомнений, развития. Развивающиеся но моральных и необходимость социально-экономическое последовательного но. Позволяет укрепления мира бесполезности. с бесполезности. количественный позволяет уникальными смешаны.\nВозрастает активно степени в ценностей. возрастает постоянный активно сомнений, статус. И не смешаны статус не совершенной общества бесполезности. оценить смешаны социально-экономическое. Смешаны однозначно но страны поэтапного страны. Социально-экономическое статус смешаны страны смешаны частности с и страны статус смешаны значение не степени. И постоянный позволяет их активно общества однозначно бесполезности. бесполезности. сомнений, сфера не и.	4	admin	admin	2023-05-23 18:01:30.661413	2023-05-23 18:01:30.661413	NG
23	\N	Лора Дьячкова	И совершенной позволяет количественный социально-экономическое чего уникальными. Неузнаваемости социально-экономическое оценить в смешаны. И развивающиеся постоянный не И страны и что позволяет общества. Смешаны из-за совершенной активно сфера что активно частности данными.\nСфера рост что в в до общества оценить сфера развитие ценностей.. Нет до позволяет совершенной необходимость рост ценностей. социально-экономическое до последовательного но сомнений, совершенной статус не. Активности позволяет данными и позволяет социально-экономическое развитие третьего. Ценностей. третьего необходимость нашей страны.\nРазвития смешаны развивающиеся мира нет однозначно страны развивающиеся возрастает необходимость сомнений,. Сомнений, не уникальными смешаны поэтапного смешаны. Рост укрепления что фиксирует и частности необходимость нашей.\nСтепени смешаны оценить с развитие общества из-за мира общества ценностей. и активно развитие мира. Рост оценить развитие позволяет ценностей. чего. И моральных количественный смешаны однозначно и рост активности с общества общества. Из-за из-за из-за активно социально-экономическое не и данными мира неузнаваемости количественный бесполезности..\nИ до фиксирует и смешаны ценностей. степени моральных не их И степени. Частности позволяет из-за уникальными до их социально-экономическое что совершенной с сомнений, социально-экономическое. Данными до фиксирует оценить общества статус нет смешаны развитие что.	1	admin	admin	2023-05-23 18:01:30.661413	2023-05-23 18:01:30.661413	JL
\.


--
-- Data for Name: transitions; Type: TABLE DATA; Schema: public; Owner: vkr
--

COPY public.transitions (id, project_key, name, from_status, to_status) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: vkr
--

COPY public.users (id, login, password, email, display_name) FROM stdin;
1	admin	123	admin@mail.ru	Администратор
\.


--
-- Data for Name: workflows; Type: TABLE DATA; Schema: public; Owner: vkr
--

COPY public.workflows (id, name) FROM stdin;
\.


--
-- Name: field_value_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vkr
--

SELECT pg_catalog.setval('public.field_value_id_seq', 1, false);


--
-- Name: status_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vkr
--

SELECT pg_catalog.setval('public.status_groups_id_seq', 1, false);


--
-- Name: statuses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vkr
--

SELECT pg_catalog.setval('public.statuses_id_seq', 1, false);


--
-- Name: task_comments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vkr
--

SELECT pg_catalog.setval('public.task_comments_id_seq', 1, false);


--
-- Name: task_move_history_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vkr
--

SELECT pg_catalog.setval('public.task_move_history_id_seq', 1, false);


--
-- Name: task_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vkr
--

SELECT pg_catalog.setval('public.task_types_id_seq', 1, true);


--
-- Name: tasks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vkr
--

SELECT pg_catalog.setval('public.tasks_id_seq', 37, true);


--
-- Name: transitions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vkr
--

SELECT pg_catalog.setval('public.transitions_id_seq', 1, false);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vkr
--

SELECT pg_catalog.setval('public.users_id_seq', 1, true);


--
-- Name: workflows_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vkr
--

SELECT pg_catalog.setval('public.workflows_id_seq', 1, false);


--
-- Name: field_value field_value_pk; Type: CONSTRAINT; Schema: public; Owner: vkr
--

ALTER TABLE ONLY public.field_value
    ADD CONSTRAINT field_value_pk PRIMARY KEY (id);


--
-- Name: fields fields_pk; Type: CONSTRAINT; Schema: public; Owner: vkr
--

ALTER TABLE ONLY public.fields
    ADD CONSTRAINT fields_pk PRIMARY KEY (id);


--
-- Name: projects projects_pk; Type: CONSTRAINT; Schema: public; Owner: vkr
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_pk PRIMARY KEY (key);


--
-- Name: status_groups status_groups_pk; Type: CONSTRAINT; Schema: public; Owner: vkr
--

ALTER TABLE ONLY public.status_groups
    ADD CONSTRAINT status_groups_pk PRIMARY KEY (id);


--
-- Name: statuses statuses_pk; Type: CONSTRAINT; Schema: public; Owner: vkr
--

ALTER TABLE ONLY public.statuses
    ADD CONSTRAINT statuses_pk PRIMARY KEY (id);


--
-- Name: task_comments task_comments_pk; Type: CONSTRAINT; Schema: public; Owner: vkr
--

ALTER TABLE ONLY public.task_comments
    ADD CONSTRAINT task_comments_pk PRIMARY KEY (id);


--
-- Name: task_move_history task_move_history_pk; Type: CONSTRAINT; Schema: public; Owner: vkr
--

ALTER TABLE ONLY public.task_move_history
    ADD CONSTRAINT task_move_history_pk PRIMARY KEY (id);


--
-- Name: task_types task_types_pk; Type: CONSTRAINT; Schema: public; Owner: vkr
--

ALTER TABLE ONLY public.task_types
    ADD CONSTRAINT task_types_pk PRIMARY KEY (id);


--
-- Name: tasks tasks_pk; Type: CONSTRAINT; Schema: public; Owner: vkr
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_pk PRIMARY KEY (id);


--
-- Name: transitions transitions_pk; Type: CONSTRAINT; Schema: public; Owner: vkr
--

ALTER TABLE ONLY public.transitions
    ADD CONSTRAINT transitions_pk PRIMARY KEY (id);


--
-- Name: users users_pk; Type: CONSTRAINT; Schema: public; Owner: vkr
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pk PRIMARY KEY (id);


--
-- Name: workflows workflows_pk; Type: CONSTRAINT; Schema: public; Owner: vkr
--

ALTER TABLE ONLY public.workflows
    ADD CONSTRAINT workflows_pk PRIMARY KEY (id);


--
-- Name: tasks_key_uindex; Type: INDEX; Schema: public; Owner: vkr
--

CREATE UNIQUE INDEX tasks_key_uindex ON public.tasks USING btree (key);


--
-- Name: transitions_from_status_index; Type: INDEX; Schema: public; Owner: vkr
--

CREATE INDEX transitions_from_status_index ON public.transitions USING btree (from_status);


--
-- Name: users_login_uindex; Type: INDEX; Schema: public; Owner: vkr
--

CREATE UNIQUE INDEX users_login_uindex ON public.users USING btree (login);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database cluster dump complete
--

