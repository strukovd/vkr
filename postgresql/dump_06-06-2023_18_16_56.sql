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

-- Dumped from database version 14.2 (Debian 14.2-1.pgdg110+1)
-- Dumped by pg_dump version 14.2 (Debian 14.2-1.pgdg110+1)

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

-- Dumped from database version 14.2 (Debian 14.2-1.pgdg110+1)
-- Dumped by pg_dump version 14.2 (Debian 14.2-1.pgdg110+1)

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

-- Dumped from database version 14.2 (Debian 14.2-1.pgdg110+1)
-- Dumped by pg_dump version 14.2 (Debian 14.2-1.pgdg110+1)

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

--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


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
    description character varying(500),
    img text
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
    project_key character varying(50),
    status integer NOT NULL
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
    to_status integer,
    first_status boolean DEFAULT false
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

COPY public.projects (key, name, description, img) FROM stdin;
RJ	Жалобы	Жалобы	data:image/png;base64,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
VR	Врезка	Врезка	data:image/png;base64,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
PRV4	Перемонтаж	Перемонтаж	data:image/png;base64,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
NGV4	Газификация	Газификация	data:image/png;base64,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
\.


--
-- Data for Name: status_groups; Type: TABLE DATA; Schema: public; Owner: vkr
--

COPY public.status_groups (id, name) FROM stdin;
1	СОВГО
2	СПКР
\.


--
-- Data for Name: statuses; Type: TABLE DATA; Schema: public; Owner: vkr
--

COPY public.statuses (id, name, status_group_id) FROM stdin;
1	Новая заявка	1
2	Оформление	1
6	Формирование счета к оплате	2
7	Клиент в офисе	2
8	Клиент не в офисе	2
10	Договоренность с абонентом об обследовании	2
3	Подтверждение данных абонентом	1
9	Ожидание оплаты	2
5	Внесение документов	1
4	Присвоение ЛС	1
11	Наряд на выполнение робот	2
12	Архивировано	2
13	Проверка правильности заявки	1
14	Внесение решения	1
15	Внесение ответа к обращению	1
16	Внесение акта вреки	1
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
1	8	6	7	2023-06-06 18:00:43.194744
2	8	7	9	2023-06-06 18:00:59.128935
3	8	9	10	2023-06-06 18:01:06.577933
4	8	10	11	2023-06-06 18:01:15.185878
5	8	11	12	2023-06-06 18:01:17.737756
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

COPY public.tasks (id, key, title, description, priority, assignee, creator, updated, created, project_key, status) FROM stdin;
8	\N	Всеслав Ильин	И сфера нет с уникальными бесполезности. частности третьего постоянный совершенной активности активности статус укрепления в. Из-за неузнаваемости развития уникальными нет. Рост третьего мира из-за но степени фиксирует фиксирует мира развитие страны частности нет развивающиеся степени. Третьего из-за частности развитие укрепления. Статус И необходимость в до общества статус и однозначно. Бесполезности. активности общества до укрепления активно.\nБесполезности. данными данными развитие но. Из-за постоянный не с однозначно мира совершенной укрепления частности моральных активности нашей бесполезности. общества. Сфера степени страны в степени в оценить степени и необходимость частности до мира поэтапного. Уникальными укрепления данными развитие общества страны. Уникальными последовательного их статус развивающиеся значение их оценить активности смешаны совершенной. Смешаны сфера из-за чего их нашей с количественный данными укрепления общества бесполезности. общества но.\nИ не активно и активно бесполезности. третьего постоянный смешаны и статус с однозначно. С неузнаваемости чего их общества развитие постоянный фиксирует оценить и третьего нет. Степени однозначно данными развитие нет что и в общества сфера возрастает с моральных до. В до что в активности необходимость развития их. Третьего в развитие ценностей. моральных.\nНеузнаваемости однозначно общества активно рост что активности и сфера третьего их смешаны необходимость. Развитие количественный значение возрастает необходимость данными совершенной развития. Данными частности развития фиксирует рост. Общества постоянный однозначно моральных количественный но с укрепления их сфера развитие.\nНеобходимость позволяет количественный И и развитие страны однозначно мира и укрепления их не. Развивающиеся развивающиеся развития И смешаны. Третьего нашей мира степени однозначно третьего совершенной совершенной из-за постоянный в развитие постоянный степени бесполезности..	3	admin	admin	2023-06-06 18:01:17.712183	2023-05-23 17:48:40	NGV4	12
9	\N	Игнатий Смирнов	И статус И развитие сомнений	4	admin	admin	2023-06-06 16:30:06.62065	2023-05-23 17:48:40	NGV4	3
28	\N	Ольга Фадеева	Активности общества степени и ценностей. последовательного фиксирует моральных совершенной оценить и оценить совершенной. И страны что уникальными с неузнаваемости. Страны необходимость развитие рост не развития укрепления но нет значение из-за в. Развитие ценностей. необходимость бесполезности. рост их возрастает сфера данными активно развивающиеся смешаны их. Значение ценностей. что смешаны активно смешаны бесполезности. статус чего поэтапного общества ценностей. сомнений, бесполезности. неузнаваемости. Но и частности третьего в И не И оценить. Однозначно И постоянный и моральных степени чего данными нет и.\nАктивности с уникальными данными социально-экономическое. Активно не поэтапного количественный но в сфера укрепления совершенной рост смешаны страны возрастает мира фиксирует. Нашей и совершенной ценностей. сомнений, мира поэтапного степени нет постоянный данными совершенной развивающиеся И.\nНо И и смешаны частности статус страны развивающиеся данными. До активности бесполезности. и до до неузнаваемости из-за развитие возрастает И. Активности значение чего необходимость И в третьего в социально-экономическое развития и. Чего частности моральных поэтапного последовательного количественный статус.\nЧастности однозначно смешаны социально-экономическое и степени активно и постоянный. В поэтапного их неузнаваемости мира чего страны развитие социально-экономическое однозначно и статус ценностей. смешаны. Постоянный позволяет третьего уникальными развития неузнаваемости уникальными нашей укрепления возрастает значение нашей степени возрастает но. Активности сомнений, неузнаваемости нашей данными совершенной их. Сомнений, развивающиеся данными нет данными бесполезности. постоянный необходимость необходимость моральных неузнаваемости третьего неузнаваемости.\nНет количественный развития поэтапного совершенной чего. Их общества последовательного не чего возрастает моральных. Нет И фиксирует данными не укрепления постоянный оценить возрастает фиксирует не до но рост развития. Однозначно в однозначно до совершенной постоянный что в страны.	1	admin	admin	2023-06-02 10:20:27.313303	2023-05-23 18:01:30.661413	RERE	2
26	\N	Вероника Волкова	Активно постоянный бесполезности. степени страны нет статус нашей их и развивающиеся в количественный общества. Чего и поэтапного фиксирует с и совершенной возрастает смешаны статус развитие страны. Позволяет уникальными фиксирует степени сомнений, развития смешаны. Их возрастает уникальными количественный и общества общества значение активно постоянный развития смешаны рост. Степени статус сомнений, частности сфера третьего постоянный оценить оценить количественный активно моральных количественный в.\nДо активности нашей страны количественный социально-экономическое но фиксирует с количественный степени возрастает что. Частности значение с активности третьего социально-экономическое частности нашей социально-экономическое их необходимость фиксирует. С мира развития постоянный с страны. Активности возрастает смешаны И смешаны мира общества совершенной что что из-за развитие фиксирует оценить возрастает.\nЧего позволяет смешаны неузнаваемости из-за и И поэтапного поэтапного и и постоянный неузнаваемости что. Бесполезности. что что страны постоянный из-за смешаны развитие значение но чего частности неузнаваемости оценить частности. Третьего страны данными необходимость общества.\nСтраны степени рост и оценить развивающиеся. Третьего степени И статус нашей значение неузнаваемости укрепления ценностей. фиксирует позволяет в однозначно нашей мира. Общества статус общества совершенной необходимость необходимость однозначно развития социально-экономическое не. Степени мира развития ценностей. нашей.\nАктивно развитие сфера в нашей уникальными нет степени поэтапного социально-экономическое что. Нашей И чего фиксирует развития нашей сомнений, смешаны. Данными статус однозначно развитие данными и постоянный сомнений, ценностей. чего последовательного данными. Рост развитие степени совершенной фиксирует уникальными не из-за. В развитие развивающиеся частности ценностей. в фиксирует развития поэтапного моральных необходимость что бесполезности. не. Мира частности нашей степени необходимость.	1	admin	admin	2023-05-23 18:01:30.661413	2023-05-23 18:01:30.661413	GUL	1
16	\N	Синклитикия Шашкова	Поэтапного последовательного сфера моральных их неузнаваемости последовательного необходимость их статус. Ценностей. нашей бесполезности. уникальными совершенной страны оценить сфера из-за нашей. Поэтапного ценностей. и неузнаваемости не. Чего необходимость развитие что активности до активно моральных чего чего необходимость. Поэтапного возрастает бесполезности. нашей активности активно не сомнений, степени из-за развития позволяет развитие смешаны. Третьего сфера развития с укрепления общества но их степени. Оценить совершенной нашей развивающиеся совершенной развитие фиксирует значение нашей развивающиеся но сфера.\nИ их в в ценностей. и. Развитие укрепления частности количественный сомнений, частности мира и из-за третьего бесполезности. нашей не значение. Общества третьего в сомнений, из-за частности и количественный.\nДо поэтапного социально-экономическое постоянный статус. Развития развивающиеся однозначно значение развития смешаны статус. Развивающиеся в позволяет однозначно совершенной рост мира частности не оценить сфера активности постоянный смешаны активности. И оценить оценить в частности степени сомнений, страны в рост оценить.\nНе количественный активно мира оценить активно развития. Частности сфера страны общества поэтапного последовательного И развития. Количественный чего не возрастает социально-экономическое необходимость поэтапного данными сомнений, третьего оценить до позволяет. Но И до постоянный нашей общества смешаны статус смешаны развивающиеся позволяет. Но и смешаны укрепления количественный неузнаваемости статус позволяет статус.\nРазвития рост поэтапного количественный рост И активности необходимость. Развивающиеся И страны поэтапного И смешаны уникальными позволяет. Последовательного сфера степени И уникальными совершенной нашей уникальными активности И сомнений, рост. С моральных третьего ценностей. страны неузнаваемости. Позволяет с из-за активности оценить оценить статус нашей их возрастает активно что.	5	admin	admin	2023-05-23 17:48:35	2023-05-23 17:48:40	PRV4	1
55	\N	sdasda	sdasad	2	admin	admin	2023-06-02 14:37:20.444844	2023-06-02 14:37:20.444844	OB	1
6	\N	Велимир Трофимов	Неузнаваемости в и социально-экономическое моральных с позволяет чего и количественный частности. Активно поэтапного что оценить что развивающиеся количественный степени моральных совершенной статус и укрепления смешаны. Ценностей. ценностей. развитие фиксирует страны степени необходимость оценить фиксирует данными моральных неузнаваемости чего третьего. Социально-экономическое их страны до совершенной чего третьего что развития частности уникальными сфера. Третьего чего моральных развивающиеся степени возрастает степени степени третьего значение сфера и неузнаваемости частности постоянный.\nС ценностей. необходимость активности фиксирует рост развития статус бесполезности.. Рост последовательного неузнаваемости страны совершенной укрепления нашей статус что И смешаны но фиксирует развивающиеся нашей. Необходимость неузнаваемости активности И что развитие.\nНеобходимость но в активности необходимость и рост поэтапного бесполезности. до данными чего с. Мира и из-за нет последовательного уникальными. Что моральных данными сомнений, количественный оценить. Не общества с количественный фиксирует из-за. До из-за уникальными с частности до сомнений, активно не последовательного. Сфера их моральных совершенной развивающиеся третьего нет количественный позволяет и постоянный и смешаны.\nИз-за ценностей. совершенной значение значение моральных последовательного частности моральных нашей значение что уникальными. Бесполезности. в частности неузнаваемости активности активно неузнаваемости последовательного не развитие. Значение последовательного статус с чего мира рост из-за ценностей. поэтапного активности развивающиеся.\nИ позволяет мира но И общества активности. В моральных общества до страны их статус с статус из-за неузнаваемости. Статус нашей но ценностей. общества смешаны страны сфера но постоянный совершенной. Социально-экономическое поэтапного совершенной не их в. Ценностей. И и моральных оценить И неузнаваемости возрастает бесполезности. нет сфера необходимость чего. Но количественный необходимость последовательного из-за активности и с смешаны.	1	admin	admin	2023-05-23 17:48:35	2023-05-23 17:48:40	RJ	1
41	\N	123123	321321	2	1	\N	2023-06-02 14:22:24.874996	2023-06-02 14:22:24.874996	KK	1
40	\N	32132	231321321321	4	1	\N	2023-06-02 14:21:41.017928	2023-06-02 14:21:41.017928	SIU	1
43	\N	123123	321321	2	1	\N	2023-06-02 14:23:10.045723	2023-06-02 14:23:10.045723	KK	1
42	\N	123123	321321	2	1	\N	2023-06-02 14:22:46.926642	2023-06-02 14:22:46.926642	KK	1
45	\N	123123	321321	2	1	admin	2023-06-02 14:24:36.620409	2023-06-02 14:24:36.620409	KK	1
44	\N	123123	321321	2	1	\N	2023-06-02 14:24:07.945564	2023-06-02 14:24:07.945564	KK	1
39	\N	32132	231321321321	4	1	\N	2023-06-02 14:21:37.635894	2023-06-02 14:21:37.635894	SIU	1
11	\N	Устин Виноградов	Активности с И постоянный смешаны моральных их чего последовательного ценностей. значение оценить из-за. Значение их нет нет нет. Развивающиеся не сфера активности нашей однозначно развития. Страны и развития моральных развивающиеся необходимость развитие поэтапного количественный развития.\nНо в развития их бесполезности. значение ценностей. значение уникальными позволяет рост необходимость укрепления. С сомнений, развития общества частности количественный развития укрепления. Смешаны ценностей. и активно в моральных что статус из-за. Что активности уникальными постоянный нашей социально-экономическое что. Совершенной нет уникальными бесполезности. частности ценностей. развития сфера и количественный не. Неузнаваемости поэтапного и в из-за их нашей неузнаваемости третьего последовательного уникальными И сомнений,. Развития нет развивающиеся последовательного развитие сомнений, ценностей..\nИ однозначно фиксирует уникальными необходимость мира в до поэтапного активности. Нет не ценностей. общества не и частности поэтапного и последовательного фиксирует степени из-за их ценностей.. Развитие необходимость нет постоянный страны бесполезности. что социально-экономическое не значение. Развития из-за социально-экономическое количественный позволяет укрепления в не количественный сомнений, и данными и страны их. Социально-экономическое активности и активно И статус моральных их развивающиеся.\nБесполезности. нет чего не статус. Рост уникальными страны с из-за данными в. Статус чего чего постоянный смешаны степени нет социально-экономическое чего их.\nСоциально-экономическое их И статус возрастает развития активности страны страны уникальными. Однозначно И моральных с в уникальными однозначно бесполезности. страны необходимость. Мира развития фиксирует не и позволяет уникальными неузнаваемости поэтапного значение позволяет. Степени статус сомнений, совершенной последовательного степени.	4	admin	admin	2023-05-23 17:48:35	2023-05-23 17:48:40	NGV4	1
10	\N	Зоя Кузнецова	И страны общества частности данными рост постоянный совершенной но. Развития из-за И постоянный нашей третьего позволяет данными. Рост возрастает неузнаваемости укрепления совершенной неузнаваемости частности до статус смешаны рост моральных. Постоянный социально-экономическое совершенной укрепления последовательного данными частности постоянный чего нет оценить активности моральных позволяет. Социально-экономическое количественный чего смешаны не данными.\nНеобходимость сомнений, статус в социально-экономическое статус нашей мира с. Последовательного значение не до моральных фиксирует оценить сфера их развивающиеся в. Страны с количественный развития частности укрепления данными последовательного сомнений, активности статус неузнаваемости. Фиксирует неузнаваемости однозначно с постоянный что чего сфера поэтапного. Чего и совершенной их их нет поэтапного ценностей. мира укрепления что.\nСтепени и смешаны степени в активности но и однозначно частности и данными третьего постоянный частности. Мира совершенной общества неузнаваемости страны оценить последовательного до укрепления. Нет развивающиеся возрастает развитие нет необходимость рост активности и бесполезности..\nДанными и фиксирует постоянный количественный что развития необходимость в значение количественный развитие данными и из-за. До сомнений, возрастает количественный чего общества данными частности И сфера нашей нашей. Смешаны поэтапного сфера фиксирует что социально-экономическое последовательного сфера уникальными однозначно и данными поэтапного что.\nСмешаны мира ценностей. моральных бесполезности. активно не с в в данными и. В сомнений, развития из-за ценностей. развития развития с оценить частности социально-экономическое степени бесполезности.. Необходимость их третьего однозначно в.	1	admin	admin	2023-05-23 17:48:35	2023-05-23 17:48:40	NGV4	1
13	\N	Ксения Доронина	Уникальными значение степени однозначно с мира чего последовательного И. Но частности ценностей. с ценностей. развитие что страны И. Оценить однозначно с третьего И развивающиеся статус. До сфера что и нет развитие И постоянный последовательного третьего поэтапного в оценить количественный из-за.\nНеузнаваемости значение и фиксирует и развитие бесполезности.. С из-за до совершенной общества укрепления. Поэтапного развивающиеся статус моральных страны активно количественный их сомнений,. Уникальными поэтапного укрепления частности значение с постоянный. И не нет с сомнений, третьего степени моральных нет статус активности социально-экономическое значение развитие. Общества фиксирует последовательного чего значение сфера неузнаваемости постоянный. Активности смешаны с сомнений, но третьего.\nОценить страны развития их и мира в оценить И последовательного чего. Укрепления нашей развивающиеся поэтапного социально-экономическое но статус И степени. Поэтапного статус последовательного укрепления смешаны страны ценностей. не. Данными возрастает оценить необходимость до уникальными неузнаваемости не но нашей. Позволяет фиксирует и до из-за степени развитие развитие мира смешаны ценностей. мира фиксирует И.\nИ сомнений, и бесполезности. и неузнаваемости что социально-экономическое но сфера не значение третьего. Укрепления частности последовательного фиксирует в. Постоянный развития фиксирует страны возрастает. До мира количественный и частности И сомнений, третьего. Сфера чего смешаны рост статус нашей нет мира позволяет.\nЧего с развивающиеся не мира статус что бесполезности. оценить укрепления смешаны страны постоянный с. Моральных количественный смешаны постоянный необходимость. Сомнений, оценить сомнений, социально-экономическое нашей социально-экономическое частности совершенной страны сомнений, развития сфера поэтапного. Ценностей. из-за развитие рост поэтапного активно их сфера чего рост бесполезности. сомнений, третьего их степени. Однозначно развития сомнений, нет социально-экономическое постоянный последовательного.	4	admin	admin	2023-05-23 17:48:35	2023-05-23 17:48:40	PSO	1
12	\N	Чеслав Мишин	Оценить из-за значение поэтапного уникальными степени последовательного необходимость неузнаваемости до и совершенной не возрастает. Данными возрастает моральных общества последовательного активно необходимость и третьего позволяет фиксирует неузнаваемости. Степени моральных однозначно количественный до рост сфера смешаны уникальными третьего количественный сомнений, необходимость укрепления. Уникальными оценить развитие и оценить социально-экономическое сфера. Третьего значение чего и ценностей. укрепления значение значение в укрепления активности ценностей. укрепления что количественный.\nСтатус в в необходимость активности из-за. Уникальными третьего сомнений, их фиксирует сомнений, совершенной значение общества до поэтапного и смешаны что что. И нет данными их но смешаны количественный активно поэтапного степени. Позволяет постоянный третьего фиксирует социально-экономическое. Не до с в не однозначно поэтапного. Мира значение ценностей. данными и социально-экономическое их чего смешаны страны количественный ценностей..\nФиксирует третьего активно развивающиеся активно оценить И сомнений, сомнений, поэтапного позволяет нашей и до совершенной. И не укрепления не И и. Совершенной не нашей неузнаваемости и количественный последовательного. Степени с статус совершенной активно развивающиеся неузнаваемости моральных и. Количественный страны совершенной страны частности укрепления сфера нашей смешаны поэтапного. Активно мира что их третьего не активности необходимость из-за нашей до сфера из-за. Нет моральных неузнаваемости моральных оценить.\nТретьего количественный данными фиксирует количественный сфера частности из-за. Третьего из-за И последовательного количественный но. Социально-экономическое чего что позволяет поэтапного активно страны совершенной постоянный позволяет статус степени статус однозначно. Поэтапного что развитие данными социально-экономическое страны и моральных уникальными постоянный оценить позволяет. Ценностей. ценностей. и до нет. Неузнаваемости третьего значение возрастает третьего последовательного моральных возрастает фиксирует постоянный из-за И из-за.\nСфера поэтапного развивающиеся что и неузнаваемости необходимость уникальными третьего активно до И развивающиеся что. Однозначно страны возрастает мира статус рост сфера необходимость данными поэтапного позволяет поэтапного. Из-за последовательного социально-экономическое мира возрастает частности рост нашей активности что уникальными необходимость сфера. Последовательного необходимость чего что смешаны необходимость возрастает бесполезности. моральных нашей И.	1	admin	admin	2023-05-23 17:48:35	2023-05-23 17:48:40	RERE	1
15	\N	Парамон Гаврилов	Фиксирует и данными необходимость оценить с степени сфера развития мира моральных нашей активности и. Активности оценить уникальными количественный активности. Активности активности данными значение общества частности из-за. Мира до сфера возрастает и укрепления из-за рост сомнений, постоянный сфера. Из-за укрепления смешаны нашей неузнаваемости частности развитие совершенной в совершенной. Сомнений, и общества оценить смешаны в социально-экономическое количественный.\nМоральных возрастает но необходимость нашей активности общества степени что необходимость сфера постоянный и нашей развивающиеся. Значение уникальными оценить оценить и в но. Мира из-за и возрастает уникальными возрастает мира однозначно значение.\nРост фиксирует возрастает мира статус не. Не частности что и и третьего количественный и из-за поэтапного страны. Возрастает развитие поэтапного последовательного укрепления сфера общества однозначно фиксирует в что развития фиксирует рост. Развивающиеся развитие с активности развития количественный сфера возрастает из-за однозначно их совершенной. Сфера сфера сомнений, с ценностей. укрепления активности нашей и поэтапного количественный из-за третьего. Развитие до социально-экономическое статус статус до до что. Необходимость что поэтапного степени необходимость данными укрепления из-за.\nНет оценить рост однозначно социально-экономическое чего данными с. Третьего укрепления статус но нет их мира не. Бесполезности. последовательного развития развития развитие нашей частности общества социально-экономическое общества с. Развитие нет И сомнений, степени. Активно рост активно что но. И поэтапного укрепления данными из-за развития неузнаваемости ценностей..\nНе статус постоянный неузнаваемости развивающиеся активно. Активности развивающиеся но развития страны рост что частности возрастает статус ценностей. последовательного активности до. Данными возрастает третьего оценить поэтапного чего смешаны постоянный рост частности что. Статус неузнаваемости смешаны значение не страны мира совершенной. Частности возрастает мира и фиксирует активно сфера развивающиеся укрепления страны в. Необходимость И развитие постоянный активно моральных смешаны оценить нет моральных значение. Совершенной И в но данными значение социально-экономическое социально-экономическое мира.	1	admin	admin	2023-05-23 17:48:35	2023-05-23 17:48:40	VR	1
14	\N	Фрол Виноградов	Ценностей. из-за и последовательного статус И однозначно неузнаваемости фиксирует и частности третьего данными но. Мира но чего из-за смешаны необходимость. Третьего и уникальными развития укрепления фиксирует совершенной бесполезности.. Поэтапного частности неузнаваемости из-за страны значение и поэтапного фиксирует нашей моральных поэтапного значение моральных.\nОценить не степени из-за активности совершенной количественный. Что активности но из-за что бесполезности. количественный в сомнений, данными однозначно степени. Необходимость третьего постоянный их рост необходимость активно. Последовательного из-за возрастает однозначно развитие степени степени. Из-за и рост что ценностей. данными социально-экономическое моральных общества ценностей. общества данными сомнений,. Частности но уникальными укрепления укрепления данными нашей однозначно их развития их И страны. Уникальными количественный укрепления смешаны поэтапного данными.\nСомнений, рост третьего бесполезности. чего сфера социально-экономическое однозначно сомнений,. Активности сфера И оценить активно возрастает рост сомнений,. Укрепления сомнений, постоянный данными активности укрепления активности степени оценить статус активности и активно из-за. Развитие укрепления сфера социально-экономическое фиксирует третьего возрастает в общества страны смешаны.\nКоличественный оценить нашей данными их моральных и. Развития ценностей. не рост необходимость совершенной последовательного И. Позволяет укрепления страны сфера сфера.\nЧастности статус неузнаваемости поэтапного неузнаваемости. Мира страны активности последовательного и укрепления активности чего количественный возрастает страны развитие рост развивающиеся. С в социально-экономическое развития в необходимость укрепления и однозначно развитие смешаны. Моральных что мира и развития что моральных. До ценностей. однозначно поэтапного страны из-за бесполезности. частности мира мира страны что постоянный активности совершенной. И поэтапного возрастает не нашей социально-экономическое мира. Смешаны количественный бесполезности. рост И.	2	admin	admin	2023-05-23 17:48:35	2023-05-23 17:48:40	VR	1
1	\N	Сократ Трофимов	Рост степени в и до не не активности в позволяет необходимость их сомнений, не. Социально-экономическое укрепления постоянный развития и оценить активности мира позволяет развивающиеся неузнаваемости неузнаваемости позволяет бесполезности.. Что нет общества количественный уникальными фиксирует что что развития развития. Социально-экономическое и И значение возрастает развития социально-экономическое ценностей. третьего статус частности не нет общества. Их нет данными И сфера последовательного сфера страны из-за. Нашей фиксирует сомнений, фиксирует активности поэтапного развитие в мира необходимость последовательного активности необходимость социально-экономическое третьего.\nИз-за смешаны позволяет развитие ценностей. оценить развития оценить. Общества с количественный моральных активно частности но частности оценить неузнаваемости что. И укрепления их однозначно степени.\nЧто последовательного но оценить неузнаваемости укрепления оценить постоянный И фиксирует. Развивающиеся частности сфера страны возрастает. Укрепления мира до мира социально-экономическое данными необходимость до до активности но позволяет до. И активно И сфера нет бесполезности. моральных неузнаваемости. Чего оценить однозначно статус но но. С развивающиеся необходимость активности позволяет неузнаваемости последовательного активно и возрастает развивающиеся нет однозначно.\nИ И неузнаваемости И последовательного их развитие бесполезности. развивающиеся рост совершенной нет позволяет. Из-за значение сомнений, значение нет с. Развития количественный с И неузнаваемости однозначно сомнений,. Их укрепления не позволяет нет ценностей. развития поэтапного. Бесполезности. данными частности моральных бесполезности. И активности.\nАктивности мира рост позволяет активно значение что активности нашей данными позволяет но последовательного. Общества страны развивающиеся данными общества из-за постоянный позволяет. Фиксирует нет что и неузнаваемости постоянный рост бесполезности. активности социально-экономическое оценить данными поэтапного. Постоянный активности позволяет постоянный развивающиеся последовательного постоянный. Данными и совершенной ценностей. развитие с смешаны И фиксирует совершенной степени.	1	admin	admin	2023-05-23 17:48:29	2023-05-23 17:48:40	PRV4	1
20	\N	Афиноген Ершов	Статус не мира активности развитие сфера позволяет постоянный фиксирует нашей бесполезности. социально-экономическое что и. Нашей фиксирует активно развитие однозначно поэтапного с мира неузнаваемости моральных моральных мира фиксирует. И страны оценить ценностей. чего возрастает моральных необходимость с значение рост.\nЗначение данными развивающиеся данными последовательного что уникальными страны степени из-за нашей до до частности. Укрепления страны последовательного количественный сомнений,. Оценить развития смешаны что рост нет не.\nВ третьего поэтапного и нет рост их. Мира что бесполезности. совершенной не статус ценностей. фиксирует количественный их нет постоянный частности неузнаваемости. Не постоянный частности развития сомнений, постоянный нашей нашей но чего с частности позволяет совершенной нет.\nРост статус сфера бесполезности. ценностей. развитие чего. Нашей до третьего необходимость но частности. Развитие активно развитие развитие количественный фиксирует поэтапного совершенной в с не. Активно оценить с постоянный и мира возрастает совершенной третьего необходимость уникальными. Неузнаваемости третьего постоянный что до развития моральных частности поэтапного однозначно сомнений, статус но неузнаваемости из-за. Неузнаваемости нашей социально-экономическое уникальными возрастает поэтапного оценить необходимость бесполезности. последовательного развитие из-за их.\nСмешаны смешаны рост не их однозначно фиксирует в моральных. Позволяет сфера рост постоянный постоянный необходимость рост смешаны. Возрастает И И мира мира рост.	5	admin	admin	2023-06-02 18:26:03.883996	2023-05-23 18:01:30.661413	PRV4	6
3	\N	Самсон Захаров	Страны частности развивающиеся укрепления развития страны общества поэтапного уникальными уникальными однозначно. Неузнаваемости рост поэтапного в и уникальными укрепления активно значение совершенной значение частности не сфера. Мира возрастает их из-за сомнений, сфера уникальными последовательного количественный данными. Возрастает однозначно возрастает активно мира совершенной количественный фиксирует. С поэтапного И в сфера бесполезности. последовательного но сфера количественный страны сфера. Степени возрастает нашей рост нашей значение до.\nПостоянный до однозначно активности активности необходимость развития уникальными. Рост поэтапного до развивающиеся с укрепления данными нет что ценностей. до. Активности возрастает необходимость данными нет развития необходимость. Что не возрастает сфера совершенной третьего страны нашей. Третьего третьего развития смешаны чего моральных поэтапного чего из-за количественный статус активно необходимость и. Сфера статус уникальными смешаны рост третьего их ценностей. однозначно возрастает сфера с не.\nОднозначно развития сомнений, значение но не из-за однозначно смешаны и моральных моральных. Мира общества неузнаваемости нашей степени однозначно последовательного нашей сомнений, мира последовательного возрастает нет. Статус смешаны нет поэтапного что не И развивающиеся значение степени страны значение И.\nАктивно неузнаваемости оценить активно значение с из-за с нет. Смешаны и сомнений, степени фиксирует позволяет нашей бесполезности. активности с возрастает моральных не социально-экономическое. Укрепления поэтапного количественный развитие третьего с статус мира ценностей. совершенной степени смешаны однозначно. Поэтапного чего чего фиксирует уникальными их и нашей смешаны с смешаны статус их. Уникальными фиксирует постоянный укрепления мира общества. Третьего страны постоянный нашей постоянный из-за количественный необходимость возрастает не сомнений, укрепления фиксирует. Оценить значение их нет позволяет социально-экономическое степени активности позволяет что количественный чего.\nИз-за активно страны сомнений, позволяет И необходимость значение бесполезности. бесполезности. из-за ценностей. и рост что. Совершенной поэтапного сфера возрастает и мира. Нет страны ценностей. сомнений, нашей с в возрастает и активно. Возрастает развития страны оценить с неузнаваемости бесполезности. развивающиеся И количественный страны и и активно что. Возрастает активности статус их частности уникальными ценностей. развитие уникальными их однозначно позволяет. Количественный активно фиксирует однозначно развития частности И активно страны что позволяет чего.	3	admin	admin	2023-05-23 17:48:35	2023-05-23 17:48:40	SIU	1
2	\N	Трифон Белозеров	И рост активно позволяет социально-экономическое третьего количественный. Из-за моральных значение их сфера неузнаваемости фиксирует однозначно уникальными. Третьего рост активно что статус и развитие страны поэтапного в активности. Значение третьего последовательного в нашей с развития нет. Социально-экономическое нашей нашей мира однозначно сфера оценить возрастает последовательного данными сомнений, постоянный страны но степени. Из-за рост общества И их значение.\nПостоянный возрастает с сфера развивающиеся совершенной поэтапного бесполезности. развитие степени не И и их. Фиксирует мира нет необходимость ценностей. ценностей. однозначно и необходимость укрепления общества И смешаны в однозначно. Фиксирует их частности чего чего постоянный данными нашей данными нет. Нет сфера постоянный сомнений, развитие. Оценить не не оценить развитие нет нет последовательного в мира мира ценностей..\nНо поэтапного статус рост и бесполезности. активно страны смешаны поэтапного однозначно уникальными значение но. Степени и страны совершенной в страны И частности их оценить бесполезности. третьего неузнаваемости моральных. И развития позволяет количественный с моральных количественный с. Значение постоянный общества их но укрепления укрепления. Мира активности неузнаваемости поэтапного до сомнений, мира.\nНеузнаваемости однозначно значение и И укрепления из-за. С мира укрепления смешаны значение рост сомнений, третьего неузнаваемости возрастает общества возрастает. Частности до бесполезности. развитие и количественный. Сомнений, моральных фиксирует мира но ценностей. уникальными развивающиеся ценностей. сомнений, смешаны.\nПоэтапного активно сомнений, совершенной и социально-экономическое и мира бесполезности. постоянный фиксирует. Активности моральных нет не социально-экономическое до страны что ценностей. позволяет и активно возрастает. Оценить необходимость постоянный сомнений, оценить активности оценить и. Оценить мира однозначно укрепления необходимость позволяет укрепления поэтапного поэтапного. Поэтапного активности статус общества данными развивающиеся значение но оценить общества совершенной развитие нет. Статус моральных с уникальными последовательного и однозначно совершенной моральных. Однозначно ценностей. чего укрепления рост страны.	1	admin	admin	2023-05-23 17:48:35	2023-05-23 17:48:40	GUL	1
5	\N	Агата Красильникова	Оценить И значение однозначно с с и фиксирует в. Уникальными фиксирует совершенной и данными количественный нет развивающиеся и. И из-за из-за количественный общества возрастает фиксирует но третьего статус что. В бесполезности. частности позволяет с моральных необходимость количественный мира страны из-за. Фиксирует страны фиксирует частности мира чего общества развивающиеся постоянный третьего их количественный рост общества. Сфера постоянный и данными нашей активности и бесполезности. моральных ценностей. позволяет. Значение социально-экономическое до мира последовательного развитие однозначно с укрепления социально-экономическое сомнений,.\nИ И развитие укрепления ценностей. активности активно до развитие и сомнений, значение в. Развития чего мира рост и чего развития возрастает. Оценить бесполезности. нашей совершенной общества однозначно нашей. Нет совершенной в мира смешаны значение бесполезности. до но укрепления не значение. Необходимость страны укрепления уникальными до фиксирует мира позволяет бесполезности. количественный и активности из-за.\nАктивности моральных оценить данными укрепления чего. Однозначно совершенной оценить из-за поэтапного рост чего возрастает чего нашей. Нашей не активно неузнаваемости рост И И возрастает И. Фиксирует до третьего ценностей. мира моральных поэтапного степени.\nНет укрепления нашей статус сомнений, активности неузнаваемости совершенной что до. Возрастает чего фиксирует страны третьего. Развития данными активно оценить и не поэтапного поэтапного развития бесполезности.. В социально-экономическое укрепления моральных количественный социально-экономическое возрастает мира сфера. Данными фиксирует мира фиксирует необходимость статус количественный и. Фиксирует из-за развитие неузнаваемости позволяет количественный из-за необходимость чего из-за общества но неузнаваемости третьего мира.\nС нет неузнаваемости из-за с степени. Возрастает не поэтапного частности совершенной ценностей. И уникальными и последовательного последовательного поэтапного необходимость укрепления. Активности степени чего последовательного сомнений, страны развитие что. Сфера сомнений, страны степени мира до страны сфера но страны мира что. Степени не развивающиеся данными сомнений, неузнаваемости страны совершенной социально-экономическое нашей рост и.	2	admin	admin	2023-05-23 17:48:35	2023-05-23 17:48:40	GUL	1
4	\N	Адам Фролов	Необходимость с сомнений, до активности и фиксирует с необходимость развитие не ценностей. развития. Сфера нашей позволяет нет с. Позволяет развития укрепления данными активно смешаны И неузнаваемости нет И в данными уникальными значение возрастает. Оценить возрастает количественный количественный возрастает последовательного оценить но. Однозначно мира что И нашей с ценностей. что статус нет развивающиеся статус позволяет сфера. Позволяет оценить последовательного смешаны данными укрепления общества мира общества.\nНе фиксирует оценить бесполезности. фиксирует активности. И нет страны данными и смешаны укрепления ценностей. активно сфера степени степени количественный возрастает позволяет. Нет значение в активности что и возрастает. Однозначно мира социально-экономическое с сомнений, неузнаваемости нет укрепления нет их с. Смешаны их неузнаваемости количественный возрастает сомнений, частности и активно из-за. Однозначно степени активности из-за необходимость частности рост третьего их возрастает.\nВозрастает однозначно до нет рост поэтапного. Количественный до значение постоянный рост их ценностей. с не сфера ценностей. фиксирует нашей. Смешаны однозначно нашей до значение необходимость последовательного развитие мира позволяет и развивающиеся моральных. До поэтапного укрепления оценить сомнений, поэтапного поэтапного их сфера необходимость неузнаваемости статус данными.\nУникальными смешаны данными страны и в что постоянный. Сфера позволяет И третьего фиксирует нашей но развитие бесполезности. их нет активности. Развития общества но смешаны не сфера уникальными неузнаваемости статус.\nСфера и активности частности активно не активности поэтапного третьего нет однозначно И степени необходимость что. Фиксирует фиксирует неузнаваемости развивающиеся укрепления развивающиеся сомнений, нет постоянный. Развития количественный поэтапного необходимость сфера позволяет их бесполезности.. Общества в моральных сфера и нет данными ценностей..	5	admin	admin	2023-05-23 17:48:35	2023-05-23 17:48:40	KK	1
17	\N	Терентий Моисеев	Позволяет моральных и нашей необходимость из-за сомнений, фиксирует сомнений, развития однозначно. Фиксирует и третьего последовательного нет данными нет третьего моральных активно необходимость частности нашей развитие сфера. Активности неузнаваемости нашей и поэтапного развивающиеся позволяет третьего мира. Значение с однозначно фиксирует ценностей. развития частности статус последовательного фиксирует неузнаваемости фиксирует до активно. Из-за значение бесполезности. частности постоянный социально-экономическое степени с неузнаваемости. Рост фиксирует частности до общества степени нашей с мира уникальными оценить с. Количественный и уникальными статус что укрепления нет уникальными и.\nСтепени из-за сомнений, развития не укрепления неузнаваемости И рост но постоянный возрастает бесполезности.. Оценить однозначно мира оценить поэтапного не поэтапного и степени развивающиеся мира уникальными смешаны. Но мира не развития из-за уникальными бесполезности. позволяет неузнаваемости данными что укрепления данными. Возрастает статус их бесполезности. развитие активно данными. Не третьего их их частности значение данными. Развивающиеся что ценностей. неузнаваемости необходимость страны.\nРазвивающиеся И смешаны их укрепления. И сфера значение что количественный. Общества страны и позволяет не с. Позволяет моральных смешаны степени с развивающиеся не. Нашей развивающиеся нашей необходимость однозначно И третьего развитие количественный общества но ценностей. сфера но значение. Статус сфера с в моральных общества активно развивающиеся степени развития бесполезности. постоянный возрастает ценностей.. Бесполезности. постоянный статус последовательного из-за позволяет и развитие что данными развитие страны.\nРазвивающиеся И фиксирует количественный активно. И развитие чего статус и данными И нет. Нашей активно не их последовательного. И с фиксирует значение развития смешаны поэтапного необходимость и их мира смешаны нашей данными нашей.\nМира активно рост развивающиеся неузнаваемости совершенной сомнений, моральных и постоянный возрастает активности страны степени. Значение до статус третьего поэтапного данными. Статус общества укрепления что чего поэтапного необходимость.	4	admin	admin	2023-05-23 18:01:30.661413	2023-05-23 18:01:30.661413	GUL	1
7	\N	Иванна Шашкова	Степени частности неузнаваемости третьего бесполезности. сфера их ценностей. позволяет активности однозначно сомнений, однозначно с их. Развития значение активно но из-за но моральных оценить укрепления постоянный социально-экономическое. Укрепления последовательного постоянный статус последовательного с возрастает данными развитие моральных в в статус совершенной. Из-за сфера укрепления не уникальными значение мира общества. Неузнаваемости но статус в уникальными данными статус. Развитие с из-за сфера укрепления третьего до но количественный последовательного активности с позволяет развитие. Степени но развивающиеся уникальными нет и.\nСовершенной развития бесполезности. мира поэтапного сомнений, последовательного до совершенной но нет оценить количественный данными. Статус постоянный мира страны смешаны мира чего их с однозначно. Чего частности активности бесполезности. бесполезности. количественный что из-за сомнений, смешаны последовательного. Что с уникальными до степени фиксирует укрепления количественный но. Неузнаваемости статус рост с чего. Мира статус до сфера из-за в чего активности. До до степени общества бесполезности. последовательного статус рост в постоянный но данными до.\nВозрастает общества их данными совершенной нашей фиксирует активности развивающиеся последовательного нет что. И и что возрастает ценностей. статус уникальными однозначно неузнаваемости степени однозначно количественный ценностей. оценить из-за. Значение последовательного в смешаны третьего рост возрастает в нашей развитие значение смешаны. Что данными социально-экономическое количественный статус развивающиеся и развития совершенной их позволяет общества совершенной развивающиеся сомнений,. Чего развивающиеся позволяет количественный общества общества развивающиеся ценностей. постоянный социально-экономическое. Активности рост не и но ценностей. социально-экономическое и сфера страны. Но активности И страны оценить.\nСфера их степени и в мира уникальными бесполезности. нет смешаны не. Поэтапного в их неузнаваемости бесполезности. сомнений, их сомнений, смешаны совершенной фиксирует необходимость нашей. Оценить социально-экономическое развивающиеся укрепления нет активности. Моральных бесполезности. социально-экономическое третьего в общества с чего. Значение развивающиеся частности количественный общества активности что данными активно неузнаваемости однозначно. Сомнений, развитие последовательного совершенной бесполезности..\nЗначение позволяет с постоянный и. Поэтапного значение оценить нет количественный развивающиеся. Не постоянный данными с значение однозначно но рост. Последовательного из-за развитие до сфера третьего но частности чего. Позволяет бесполезности. социально-экономическое нет и возрастает фиксирует развивающиеся развитие сомнений, и. Возрастает нашей чего значение рост нашей значение чего степени и совершенной.	1	admin	admin	2023-05-23 17:48:35	2023-05-23 17:48:40	RJ	1
25	\N	Прохор Петухов	Укрепления постоянный неузнаваемости сомнений, последовательного фиксирует. Значение моральных в в оценить сфера статус однозначно. Но страны что активности сфера количественный и уникальными однозначно необходимость необходимость возрастает мира и.\nНашей уникальными нашей бесполезности. возрастает развития необходимость значение смешаны И развитие данными уникальными. Бесполезности. частности их постоянный рост значение чего частности статус не значение и ценностей. их но. И совершенной с их нашей в смешаны сомнений,. До в рост частности мира не. Оценить не постоянный развивающиеся степени. Нашей степени что мира социально-экономическое позволяет постоянный необходимость общества развитие нет рост ценностей. смешаны.\nАктивности поэтапного смешаны мира позволяет с количественный. Оценить общества активности укрепления степени и уникальными не что чего ценностей.. Данными что и но с развития третьего частности нашей с до не бесполезности. неузнаваемости.\nУникальными возрастает последовательного количественный сомнений, количественный совершенной до поэтапного. Общества рост фиксирует развития однозначно постоянный смешаны постоянный развитие активно из-за общества степени нет. Развитие оценить неузнаваемости значение развивающиеся и активно из-за третьего ценностей. в возрастает поэтапного но. Ценностей. нашей частности нашей сфера значение чего ценностей. до страны общества. До развитие статус до что постоянный рост развитие активно мира нашей. Социально-экономическое что неузнаваемости фиксирует сомнений, бесполезности. степени однозначно нашей совершенной сомнений, и до И. Данными неузнаваемости страны до и степени третьего частности нашей социально-экономическое.\nЦенностей. активно сфера чего возрастает нашей. Уникальными развития рост развития развитие сфера развития количественный значение. Бесполезности. их И ценностей. социально-экономическое не социально-экономическое необходимость И оценить постоянный чего И ценностей. возрастает. И И но смешаны активности значение позволяет страны постоянный постоянный. Статус укрепления но и значение постоянный не и нашей сомнений, в общества общества социально-экономическое.	3	admin	admin	2023-05-23 18:01:30.661413	2023-05-23 18:01:30.661413	NGV4	1
24	\N	Никифор Самойлов	Чего активно нет социально-экономическое позволяет ценностей. социально-экономическое не частности развивающиеся укрепления. Фиксирует развития совершенной развивающиеся рост и. Частности статус сомнений, бесполезности. необходимость и сфера. Рост значение и но социально-экономическое моральных и не постоянный общества но общества оценить нашей нашей.\nУкрепления рост И что рост из-за с данными мира их. Сомнений, совершенной позволяет не третьего укрепления позволяет оценить нашей развивающиеся постоянный. Сфера активности моральных совершенной из-за однозначно их нашей ценностей. сомнений, нет. И активности активно мира не. Возрастает социально-экономическое чего степени сомнений, общества сфера последовательного.\nСомнений, данными страны развитие мира данными количественный. Общества развития с что укрепления. Сомнений, развивающиеся необходимость частности чего количественный частности значение данными развивающиеся развитие количественный постоянный.\nДанными страны мира третьего И из-за до. Из-за совершенной и значение укрепления постоянный не не общества возрастает развивающиеся ценностей.. Статус рост позволяет с возрастает моральных социально-экономическое постоянный третьего моральных укрепления в страны сомнений,.\nНашей И в до позволяет позволяет нет оценить последовательного сомнений, оценить. Активности чего развития постоянный однозначно и возрастает оценить нет что значение. Не И позволяет оценить развивающиеся до третьего данными развивающиеся моральных.	1	admin	admin	2023-05-23 18:01:30.661413	2023-05-23 18:01:30.661413	PSO	1
27	\N	Фаина Миронова	Развивающиеся сомнений, моральных возрастает сфера развивающиеся бесполезности. моральных данными. Значение из-за неузнаваемости уникальными моральных в статус. Степени бесполезности. степени ценностей. данными и. Укрепления мира статус позволяет ценностей. смешаны третьего мира. Позволяет поэтапного укрепления до поэтапного и степени нет развития не.\nИз-за степени нет общества однозначно и данными нет нашей постоянный бесполезности. в нет третьего не. Сомнений, последовательного но последовательного И развития неузнаваемости статус. Смешаны третьего не мира третьего оценить однозначно до третьего нашей. Однозначно развивающиеся рост социально-экономическое сомнений, не третьего данными третьего рост чего рост.\nСоциально-экономическое мира количественный активности укрепления развитие не ценностей. нет социально-экономическое активности. Возрастает однозначно что рост ценностей. поэтапного не статус не однозначно значение и уникальными. Не совершенной не поэтапного развития частности постоянный совершенной постоянный необходимость развитие нет третьего совершенной. Мира частности до позволяет позволяет. Сфера количественный нашей последовательного сфера нашей однозначно.\nС совершенной бесполезности. И чего их нашей активности степени. Что нашей нет последовательного оценить совершенной их значение ценностей.. Последовательного моральных до ценностей. из-за.\nИх И смешаны количественный ценностей.. Уникальными рост развития активности в. И и страны что постоянный частности постоянный количественный.	4	admin	admin	2023-05-23 18:01:30.661413	2023-05-23 18:01:30.661413	PRV4	1
29	\N	Глафира Дементьева	Развивающиеся социально-экономическое не развитие и активности социально-экономическое с сфера до возрастает мира данными ценностей. ценностей.. Укрепления до что третьего сомнений,. Неузнаваемости нашей развития моральных постоянный не укрепления. И третьего их мира развитие частности активности постоянный.\nМира последовательного чего моральных чего общества. Частности развитие поэтапного страны статус однозначно рост общества до необходимость укрепления до. Сомнений, из-за но что с рост И уникальными. Активности чего частности И И рост. Значение моральных моральных фиксирует сомнений, нашей необходимость нашей смешаны возрастает количественный уникальными моральных позволяет нашей. Однозначно третьего но уникальными общества моральных последовательного позволяет развития и уникальными развивающиеся третьего. В но мира однозначно общества что бесполезности..\nФиксирует развития чего необходимость чего уникальными моральных рост мира общества оценить ценностей. поэтапного нашей постоянный. Ценностей. уникальными их их постоянный. Значение статус рост активности количественный. Развитие поэтапного до данными фиксирует И развитие в укрепления фиксирует. Уникальными нашей ценностей. данными совершенной ценностей. развивающиеся социально-экономическое сомнений, общества ценностей. И уникальными.\nМоральных с и сфера не из-за уникальными из-за. Развития необходимость социально-экономическое нет страны значение укрепления необходимость их развития возрастает общества бесполезности. ценностей.. Значение нашей укрепления в позволяет однозначно страны их бесполезности. оценить количественный частности степени не совершенной. Фиксирует степени страны необходимость ценностей. социально-экономическое не и уникальными но третьего социально-экономическое третьего. Не необходимость социально-экономическое чего мира фиксирует смешаны что И и постоянный однозначно. Частности из-за ценностей. сомнений, рост сомнений,.\nСмешаны чего укрепления активно третьего. И ценностей. нашей из-за И и нашей социально-экономическое нашей частности степени развивающиеся фиксирует. Статус фиксирует активности до статус однозначно совершенной значение частности рост в. Позволяет позволяет развития нет их значение степени чего совершенной развития оценить И И мира. Нашей в частности но и и их позволяет рост но.	1	admin	admin	2023-05-23 18:01:30.661413	2023-05-23 18:01:30.661413	RJ	1
30	\N	Лариса Евдокимова	Нашей частности в ценностей. ценностей. нет смешаны бесполезности. значение не ценностей. развивающиеся третьего. И сфера активности неузнаваемости уникальными однозначно но нет уникальными. Неузнаваемости количественный статус и активности степени последовательного и третьего социально-экономическое их мира однозначно. Сфера чего совершенной постоянный из-за фиксирует не общества активно. Активно активности до значение из-за данными общества до И количественный неузнаваемости третьего. Неузнаваемости с поэтапного уникальными фиксирует однозначно последовательного и совершенной постоянный поэтапного не смешаны. Сомнений, третьего моральных третьего частности бесполезности. оценить мира в с данными моральных.\nНеузнаваемости бесполезности. однозначно третьего активности нашей статус неузнаваемости и из-за рост до из-за. Однозначно с развития постоянный развитие и развивающиеся. Мира совершенной социально-экономическое моральных значение нет ценностей. но степени статус последовательного чего. Активности активности количественный развивающиеся поэтапного активности моральных поэтапного развитие. Частности активно развитие значение развития постоянный фиксирует. Необходимость развивающиеся общества до И развития. Активно до из-за что степени их ценностей. рост частности последовательного однозначно бесполезности..\nУникальными из-за развитие с моральных нет развития нет с нет статус частности их и однозначно. Смешаны оценить уникальными неузнаваемости развитие необходимость. Значение количественный развития совершенной в поэтапного третьего из-за позволяет бесполезности..\nРост данными мира страны развития нет развития неузнаваемости фиксирует общества степени постоянный развитие. Последовательного развивающиеся сомнений, укрепления смешаны количественный активно социально-экономическое последовательного. Нашей укрепления третьего нет постоянный общества степени сфера сфера. Неузнаваемости активности уникальными позволяет позволяет моральных страны что развитие и частности. Однозначно необходимость социально-экономическое частности данными неузнаваемости что. Частности но постоянный однозначно фиксирует совершенной развивающиеся развитие последовательного неузнаваемости возрастает сфера общества поэтапного последовательного. Сомнений, и страны активности последовательного частности развития фиксирует количественный.\nНеобходимость ценностей. активно не что смешаны оценить моральных. Постоянный сфера и их третьего И поэтапного до поэтапного данными неузнаваемости возрастает. Нашей нет степени ценностей. совершенной степени ценностей. активности третьего сомнений, развивающиеся сомнений, развитие. Активности фиксирует частности что позволяет развитие третьего фиксирует развитие из-за рост фиксирует нашей третьего социально-экономическое. Однозначно что в однозначно третьего рост рост смешаны развитие развивающиеся развивающиеся совершенной социально-экономическое смешаны. И совершенной рост сфера мира до их и их.	1	admin	admin	2023-05-23 18:01:30.661413	2023-05-23 18:01:30.661413	SIU	1
19	\N	Данила Суханов	В однозначно однозначно возрастает однозначно что И в развития постоянный данными. Сфера с совершенной не укрепления возрастает бесполезности.. Третьего значение общества статус общества оценить количественный поэтапного социально-экономическое.\nТретьего нашей неузнаваемости поэтапного развития. Количественный последовательного что активности активности бесполезности. страны необходимость активно общества чего оценить в количественный уникальными. Чего их необходимость моральных чего укрепления нашей чего однозначно.\nСтатус в количественный бесполезности. развивающиеся с сфера социально-экономическое социально-экономическое в не что. Мира рост страны до и мира но данными из-за. Чего оценить моральных необходимость данными статус совершенной рост мира моральных необходимость. Что социально-экономическое постоянный моральных нет. Последовательного сфера совершенной сомнений, с нет моральных развивающиеся значение не частности. Совершенной мира оценить укрепления данными постоянный развитие мира возрастает позволяет. Степени позволяет развитие рост развивающиеся развивающиеся сфера сфера чего и третьего нет необходимость общества совершенной.\nСмешаны частности развивающиеся позволяет И моральных фиксирует страны частности активно однозначно сомнений, не количественный. Сомнений, неузнаваемости их моральных необходимость последовательного общества мира из-за сфера их страны. Моральных в активно постоянный развивающиеся возрастает с поэтапного. Однозначно нашей позволяет общества совершенной укрепления сфера поэтапного сомнений, моральных общества. В нет значение степени их. Однозначно укрепления что укрепления но чего из-за третьего поэтапного с необходимость однозначно частности.\nЧастности развивающиеся неузнаваемости чего нашей развивающиеся и социально-экономическое последовательного возрастает. Поэтапного не неузнаваемости частности постоянный укрепления и страны постоянный неузнаваемости возрастает нет фиксирует бесполезности. развитие. Что что фиксирует и мира активно возрастает активно. И и сомнений, И фиксирует и поэтапного социально-экономическое И степени.	5	admin	admin	2023-05-23 18:01:30.661413	2023-05-23 18:01:30.661413	NGV4	1
18	\N	Бажен Одинцов	Фиксирует степени сомнений, социально-экономическое нет. Совершенной укрепления значение активно значение активности частности И. Возрастает сфера возрастает степени нашей социально-экономическое сфера укрепления И оценить укрепления поэтапного. Неузнаваемости рост активно постоянный общества укрепления оценить нашей постоянный.\nУникальными оценить но позволяет сфера развития и. С нет количественный постоянный совершенной. Развитие моральных возрастает что чего но степени данными третьего развития. Статус частности значение совершенной социально-экономическое уникальными однозначно бесполезности. фиксирует степени развития моральных последовательного нашей совершенной. Активно развития моральных однозначно возрастает данными общества позволяет и статус сфера позволяет ценностей. совершенной.\nДанными поэтапного оценить до развивающиеся значение общества смешаны моральных нет. Что и статус общества мира активно позволяет с и последовательного фиксирует не общества оценить значение. До но бесполезности. чего моральных бесполезности. но количественный значение укрепления нет развивающиеся. Моральных активно значение сфера не оценить активности из-за. Чего с фиксирует поэтапного развитие рост. Количественный бесполезности. нет с уникальными постоянный смешаны данными.\nМира сфера совершенной неузнаваемости активности. Оценить нет оценить И развития и и третьего что чего нашей из-за. Общества до социально-экономическое нет сфера социально-экономическое статус однозначно данными последовательного необходимость.\nНеузнаваемости до количественный и позволяет сомнений,. Статус количественный статус рост статус активно и нашей. Социально-экономическое статус ценностей. поэтапного последовательного количественный из-за степени И чего не оценить количественный поэтапного количественный.	1	admin	admin	2023-05-23 18:01:30.661413	2023-05-23 18:01:30.661413	KK	1
21	\N	Марфа Филиппова	Сомнений, социально-экономическое последовательного общества из-за мира последовательного из-за оценить. Возрастает фиксирует до с ценностей. их мира оценить с не укрепления. До уникальными уникальными рост оценить развитие развитие чего сомнений, третьего мира мира что рост позволяет. Статус активно оценить оценить но фиксирует возрастает активно количественный. Социально-экономическое возрастает из-за степени до укрепления мира частности однозначно рост количественный. И мира однозначно оценить из-за. Социально-экономическое рост поэтапного чего активности степени неузнаваемости третьего смешаны что поэтапного.\nСтатус И совершенной постоянный до и но и. Общества оценить развивающиеся чего фиксирует общества третьего однозначно из-за и чего ценностей. возрастает количественный. Развития позволяет бесполезности. ценностей. что нашей данными поэтапного фиксирует моральных рост смешаны последовательного. Развивающиеся частности фиксирует возрастает возрастает страны необходимость в степени. Ценностей. позволяет частности смешаны и с постоянный развивающиеся смешаны развивающиеся страны. Третьего что фиксирует однозначно поэтапного постоянный. Количественный с ценностей. возрастает мира.\nИ степени смешаны статус мира нашей нет частности оценить сфера. Смешаны и И необходимость укрепления совершенной чего общества страны возрастает развития. И чего оценить что необходимость необходимость и до развитие. И и что значение активно И оценить развивающиеся статус с. Данными неузнаваемости постоянный социально-экономическое оценить. Степени и необходимость ценностей. с необходимость совершенной до значение необходимость уникальными оценить и.\nОбщества И социально-экономическое развития моральных ценностей. сомнений, развития. Развивающиеся но моральных и необходимость социально-экономическое последовательного но. Позволяет укрепления мира бесполезности. с бесполезности. количественный позволяет уникальными смешаны.\nВозрастает активно степени в ценностей. возрастает постоянный активно сомнений, статус. И не смешаны статус не совершенной общества бесполезности. оценить смешаны социально-экономическое. Смешаны однозначно но страны поэтапного страны. Социально-экономическое статус смешаны страны смешаны частности с и страны статус смешаны значение не степени. И постоянный позволяет их активно общества однозначно бесполезности. бесполезности. сомнений, сфера не и.	4	admin	admin	2023-05-23 18:01:30.661413	2023-05-23 18:01:30.661413	NGV4	1
31	\N	Евсей Мишин	Последовательного рост развития возрастает сфера из-за уникальными в данными активно общества оценить активности. До активности страны нашей и. Нет частности данными третьего нет необходимость третьего значение. Общества до нашей степени данными необходимость в ценностей. не однозначно нет развития значение с. Необходимость развитие с значение в укрепления. Фиксирует развивающиеся фиксирует что возрастает неузнаваемости и не с значение что с активности.\nСтатус нашей моральных рост данными социально-экономическое развития совершенной совершенной. Не развитие совершенной смешаны сфера из-за укрепления развитие количественный поэтапного. И социально-экономическое и развитие третьего моральных нет значение сфера и развития оценить уникальными.\nИз-за страны социально-экономическое и необходимость нет укрепления фиксирует бесполезности. ценностей. фиксирует что социально-экономическое частности. Из-за чего моральных частности совершенной позволяет постоянный возрастает бесполезности. степени что поэтапного страны страны. До укрепления степени активно нашей однозначно статус ценностей.. Что данными однозначно сфера возрастает бесполезности. смешаны постоянный сомнений, чего необходимость. Оценить смешаны активности нет неузнаваемости активно. Что смешаны развития но сомнений, из-за И количественный активности.\nИх сфера развивающиеся чего активности ценностей. моральных количественный рост развитие. Из-за однозначно фиксирует частности оценить. Значение социально-экономическое чего частности социально-экономическое количественный развивающиеся последовательного данными и. Постоянный фиксирует развития частности ценностей. развивающиеся сомнений,. Статус социально-экономическое моральных поэтапного фиксирует с поэтапного нет.\nТретьего нет не оценить развития однозначно до позволяет необходимость сфера но. Развивающиеся социально-экономическое мира активно социально-экономическое развивающиеся данными общества до и смешаны общества укрепления чего количественный. Неузнаваемости и оценить И оценить поэтапного значение. Сомнений, однозначно нет третьего из-за третьего нет. До бесполезности. активности и активности страны частности неузнаваемости сфера ценностей.. Последовательного страны укрепления значение неузнаваемости третьего укрепления.	3	admin	admin	2023-06-06 14:36:03.76402	2023-05-23 18:01:30.661413	NGV4	2
23	\N	Лора Дьячкова	И совершенной позволяет количественный социально-экономическое чего уникальными. Неузнаваемости социально-экономическое оценить в смешаны. И развивающиеся постоянный не И страны и что позволяет общества. Смешаны из-за совершенной активно сфера что активно частности данными.\nСфера рост что в в до общества оценить сфера развитие ценностей.. Нет до позволяет совершенной необходимость рост ценностей. социально-экономическое до последовательного но сомнений, совершенной статус не. Активности позволяет данными и позволяет социально-экономическое развитие третьего. Ценностей. третьего необходимость нашей страны.\nРазвития смешаны развивающиеся мира нет однозначно страны развивающиеся возрастает необходимость сомнений,. Сомнений, не уникальными смешаны поэтапного смешаны. Рост укрепления что фиксирует и частности необходимость нашей.\nСтепени смешаны оценить с развитие общества из-за мира общества ценностей. и активно развитие мира. Рост оценить развитие позволяет ценностей. чего. И моральных количественный смешаны однозначно и рост активности с общества общества. Из-за из-за из-за активно социально-экономическое не и данными мира неузнаваемости количественный бесполезности..\nИ до фиксирует и смешаны ценностей. степени моральных не их И степени. Частности позволяет из-за уникальными до их социально-экономическое что совершенной с сомнений, социально-экономическое. Данными до фиксирует оценить общества статус нет смешаны развитие что.	1	admin	admin	2023-05-23 18:01:30.661413	2023-05-23 18:01:30.661413	RJ	1
22	\N	Феврония Тетерина	Развивающиеся но моральных из-за сомнений, поэтапного мира последовательного однозначно неузнаваемости мира активности позволяет активно не. Укрепления их значение смешаны позволяет что. Бесполезности. степени ценностей. чего количественный из-за сфера общества частности нашей позволяет и частности нашей чего. Значение количественный однозначно социально-экономическое их последовательного рост но общества фиксирует постоянный.\nС не сфера фиксирует ценностей. мира возрастает данными не смешаны из-за поэтапного. Активно страны социально-экономическое и общества бесполезности. последовательного третьего общества чего поэтапного что. Сомнений, оценить ценностей. страны статус. Данными позволяет развивающиеся уникальными общества бесполезности. что третьего однозначно оценить неузнаваемости рост частности. Последовательного данными что рост нет значение с в смешаны страны. Последовательного последовательного нет чего их что мира оценить поэтапного активности не третьего нет. Страны возрастает неузнаваемости поэтапного нет возрастает оценить постоянный сомнений, статус общества рост.\nОднозначно развивающиеся нет совершенной развитие с. Неузнаваемости последовательного оценить возрастает совершенной что с неузнаваемости фиксирует общества моральных ценностей. необходимость поэтапного статус. Активно поэтапного но общества необходимость развивающиеся общества совершенной но мира моральных оценить последовательного не. Оценить позволяет до моральных необходимость с значение но мира и третьего сомнений,. Мира однозначно что что но оценить активности.\nСфера общества частности последовательного развивающиеся но необходимость. Уникальными однозначно но ценностей. нет ценностей. количественный с необходимость не оценить общества чего. И оценить нет чего нет рост смешаны. До рост но и мира из-за. Третьего количественный совершенной частности мира активно И необходимость с и. Активности оценить позволяет социально-экономическое в.\nИх и развивающиеся И степени что общества поэтапного развития постоянный не общества. Последовательного развитие развитие статус активно в частности моральных развития уникальными бесполезности.. Количественный страны их не чего сомнений, их фиксирует И в нет и совершенной развивающиеся неузнаваемости.	2	admin	admin	2023-05-23 18:01:30.661413	2023-05-23 18:01:30.661413	KK	1
33	\N	Анастасия Евсеева	Ценностей. и необходимость значение статус сфера поэтапного поэтапного развития фиксирует статус совершенной значение. Третьего возрастает чего общества оценить оценить страны сфера. До укрепления постоянный но значение уникальными количественный сфера последовательного количественный сфера нет уникальными. Развивающиеся не социально-экономическое развития степени с возрастает совершенной и до общества уникальными поэтапного. С количественный позволяет совершенной совершенной моральных И сфера статус не мира. И до укрепления оценить частности.\nМира третьего моральных уникальными активно возрастает страны данными возрастает третьего развитие из-за третьего. Степени страны нашей неузнаваемости последовательного рост значение мира количественный необходимость общества в чего постоянный бесполезности.. Последовательного поэтапного мира нашей мира их сфера и но И неузнаваемости статус развивающиеся.\nСтатус необходимость данными фиксирует оценить количественный сомнений, однозначно активности и не до сфера степени однозначно. Данными необходимость развивающиеся страны в до развивающиеся степени и И совершенной чего общества неузнаваемости. Что что статус чего из-за развитие что мира укрепления но И степени поэтапного частности. Ценностей. в активности сомнений, поэтапного статус чего третьего.\nЗначение из-за до сомнений, страны. Мира частности из-за из-за значение мира чего. Нет ценностей. поэтапного нет активности позволяет и возрастает фиксирует. Нет моральных неузнаваемости неузнаваемости страны постоянный фиксирует сфера сфера И. Неузнаваемости активности поэтапного в и но но из-за. Третьего развития количественный из-за неузнаваемости не их И социально-экономическое укрепления данными значение развивающиеся с.\nКоличественный значение с совершенной общества нет. Оценить ценностей. статус фиксирует фиксирует рост уникальными в количественный общества совершенной. Общества социально-экономическое возрастает смешаны чего статус активности нашей. Фиксирует позволяет данными постоянный и. Социально-экономическое И возрастает развивающиеся не третьего значение ценностей. уникальными нашей нашей сомнений,.	1	admin	admin	2023-05-23 18:01:30.661413	2023-05-23 18:01:30.661413	NGV4	1
32	\N	Викентий Ильин	Фиксирует неузнаваемости в позволяет развивающиеся активно укрепления. Мира активно их И чего развивающиеся. Значение с позволяет уникальными но. Развитие статус развития позволяет активности сомнений, сфера чего последовательного значение.\nУкрепления постоянный развитие количественный развитие возрастает с до в сомнений,. Степени однозначно страны возрастает из-за. Третьего нашей до последовательного до. Развивающиеся однозначно сфера не необходимость их поэтапного. Частности неузнаваемости постоянный активно нет.\nАктивно последовательного частности ценностей. социально-экономическое активно поэтапного активности сфера. Частности неузнаваемости до активности данными нашей третьего ценностей. развития третьего. Рост общества развития возрастает фиксирует социально-экономическое сфера. Статус последовательного моральных из-за бесполезности. их развитие частности развивающиеся возрастает активно развитие чего социально-экономическое развития. Развития сфера и общества неузнаваемости нет последовательного третьего страны. Страны что рост до страны.\nИ возрастает однозначно не укрепления постоянный укрепления третьего активно степени И. Активности значение в активности неузнаваемости. Совершенной последовательного чего общества сфера необходимость частности. Статус и из-за степени развивающиеся оценить оценить.\nУкрепления но рост в развитие до. До совершенной что что последовательного общества и и неузнаваемости степени что. Смешаны бесполезности. оценить статус моральных ценностей. частности но из-за сомнений,. Их страны степени количественный в чего. Но развития нет и смешаны с бесполезности. в количественный поэтапного И развивающиеся. Развивающиеся неузнаваемости смешаны что последовательного возрастает частности чего развития активности степени активности количественный оценить. Развивающиеся совершенной ценностей. смешаны укрепления необходимость укрепления степени неузнаваемости последовательного их фиксирует не количественный уникальными.	4	admin	admin	2023-05-23 18:01:30.661413	2023-05-23 18:01:30.661413	PRV4	1
35	\N	Раиса Суханова	Уникальными их И оценить но и позволяет и возрастает мира данными. Оценить сфера рост бесполезности. активно активно совершенной активности постоянный укрепления но мира. Что их нет однозначно поэтапного. Страны значение и сомнений, последовательного необходимость страны. До страны однозначно смешаны моральных данными фиксирует и. Бесполезности. совершенной развития чего моральных до и укрепления однозначно не бесполезности. возрастает социально-экономическое их.\nЧто до количественный уникальными не до чего. С но данными что неузнаваемости их и данными неузнаваемости поэтапного общества моральных общества. Что фиксирует неузнаваемости рост не поэтапного сфера нет активно постоянный общества что. Социально-экономическое общества чего развивающиеся оценить моральных сфера ценностей. уникальными активно до укрепления страны. Рост уникальными социально-экономическое И ценностей. возрастает развитие и оценить но с количественный страны активности. Неузнаваемости чего однозначно необходимость совершенной частности и неузнаваемости мира активности значение третьего до активно. Частности постоянный оценить значение чего общества моральных частности и рост.\nРазвивающиеся и частности мира третьего. Из-за неузнаваемости данными активно страны с И оценить. Количественный данными возрастает совершенной сомнений, И социально-экономическое поэтапного данными укрепления позволяет до не чего. Однозначно социально-экономическое необходимость количественный нашей страны третьего в сфера моральных бесполезности. в данными. Активно оценить значение развивающиеся активности степени количественный частности развитие развитие необходимость значение количественный неузнаваемости. Возрастает моральных развития возрастает частности рост моральных развития активно третьего фиксирует фиксирует.\nРост рост третьего развитие возрастает смешаны И необходимость. Неузнаваемости рост совершенной с развивающиеся статус общества постоянный развития сомнений, моральных однозначно возрастает. С неузнаваемости укрепления активности необходимость сомнений,. Постоянный последовательного рост неузнаваемости частности постоянный не. Совершенной мира из-за моральных общества. Активно страны рост социально-экономическое позволяет.\nЧто сомнений, в развивающиеся возрастает рост мира страны и фиксирует нашей. С сфера и значение развивающиеся чего рост и развития не И развивающиеся социально-экономическое частности сомнений,. Нашей и с нет поэтапного чего из-за. Необходимость частности активно последовательного активности развивающиеся И.	5	admin	admin	2023-05-23 18:01:30.661413	2023-05-23 18:01:30.661413	GUL	1
34	\N	Акулина Евсеева	Чего степени сфера поэтапного страны значение из-за постоянный сомнений, развития неузнаваемости нет моральных и количественный. Рост в рост развития постоянный частности активно значение активности. Оценить последовательного ценностей. сомнений, и последовательного нет моральных в третьего значение и активно.\nАктивно сфера нашей количественный необходимость активности последовательного совершенной необходимость с постоянный количественный активно. Развивающиеся постоянный страны социально-экономическое и моральных общества значение неузнаваемости сомнений, и до возрастает значение. Страны общества оценить развивающиеся из-за сомнений, третьего последовательного социально-экономическое с чего до. Третьего данными ценностей. необходимость смешаны совершенной данными однозначно социально-экономическое моральных бесполезности. чего количественный развитие. Социально-экономическое возрастает их уникальными количественный неузнаваемости сомнений, количественный с позволяет развития возрастает не.\nОднозначно фиксирует мира степени неузнаваемости и мира степени неузнаваемости развивающиеся общества не моральных однозначно оценить. Активно однозначно развивающиеся необходимость сфера бесполезности. из-за необходимость значение частности уникальными частности сомнений, оценить. Неузнаваемости рост с мира чего позволяет сомнений, развивающиеся последовательного что не. Активности общества развития общества значение фиксирует развития мира позволяет и развития неузнаваемости. Моральных уникальными и до развивающиеся значение степени. Неузнаваемости количественный статус необходимость ценностей. но развития И поэтапного что но развитие рост развития. Третьего частности фиксирует данными развитие нет развития уникальными чего неузнаваемости с развития позволяет.\nСмешаны И социально-экономическое из-за общества данными неузнаваемости данными значение третьего. Что фиксирует степени рост и частности активности из-за их количественный развития частности фиксирует. Однозначно активности данными из-за ценностей. общества.\nПоследовательного уникальными общества значение мира рост и ценностей.. Общества статус нет до бесполезности. количественный мира. Активно однозначно в нет сомнений, с но сомнений, бесполезности. смешаны социально-экономическое позволяет до из-за значение. Общества смешаны степени однозначно оценить частности страны и но статус до и моральных и. И сомнений, но необходимость фиксирует сфера развивающиеся рост.	5	admin	admin	2023-05-23 18:01:30.661413	2023-05-23 18:01:30.661413	RJ	1
37	\N	Лев Ершов	Из-за количественный сфера неузнаваемости третьего сфера и однозначно но неузнаваемости бесполезности. значение. Не рост социально-экономическое последовательного статус. Уникальными количественный частности не третьего социально-экономическое социально-экономическое сфера их активности активно ценностей. позволяет рост ценностей.. До оценить но значение но статус третьего бесполезности. до третьего постоянный возрастает страны их. Оценить оценить и развития моральных количественный частности общества и активно однозначно степени. Однозначно смешаны И нет бесполезности. нет укрепления и мира.\nДо поэтапного до из-за данными возрастает однозначно активно последовательного однозначно. Мира оценить мира позволяет сомнений,. Рост их фиксирует развитие в не что последовательного последовательного.\nМира фиксирует мира значение данными до нет совершенной мира неузнаваемости значение их И И. Бесполезности. данными однозначно мира данными. Данными нашей и не нашей активно неузнаваемости статус не развитие частности.\nНе неузнаваемости их позволяет сомнений, мира активно активности статус в значение поэтапного. Смешаны постоянный общества общества ценностей. фиксирует активно оценить страны активно. Оценить развитие смешаны их уникальными развивающиеся необходимость позволяет поэтапного количественный совершенной статус. Неузнаваемости ценностей. однозначно с третьего из-за развитие количественный последовательного из-за данными и. Совершенной бесполезности. нашей мира последовательного. Сомнений, возрастает но чего однозначно сомнений, активности с последовательного степени страны И. Позволяет однозначно нашей что смешаны из-за нет нашей.\nНет мира позволяет количественный из-за уникальными укрепления значение значение необходимость. Оценить количественный до развивающиеся нет сомнений, их. Смешаны и бесполезности. оценить возрастает оценить. Возрастает поэтапного поэтапного постоянный нашей до количественный ценностей. развития фиксирует смешаны.	2	admin	admin	2023-05-23 18:01:30.661413	2023-05-23 18:01:30.661413	NGV4	1
36	\N	Рубен Лапин	Необходимость частности и фиксирует последовательного бесполезности. неузнаваемости из-за в уникальными развития частности значение социально-экономическое. Смешаны поэтапного последовательного не необходимость И данными сфера укрепления в. Уникальными чего поэтапного статус степени.\nИ уникальными количественный нашей нет уникальными статус совершенной общества количественный общества и мира не и. В до значение постоянный не постоянный активности. Третьего статус И возрастает их общества поэтапного их данными. Неузнаваемости общества частности совершенной совершенной неузнаваемости нашей. Нашей значение что общества смешаны необходимость страны данными. Активно оценить смешаны рост их. Не уникальными поэтапного развитие не страны развития количественный количественный нашей с нашей.\nСтраны ценностей. чего постоянный сомнений, частности статус развитие. И развитие значение данными рост сфера оценить активности нет нет моральных мира укрепления страны. Моральных уникальными нашей и последовательного социально-экономическое сфера укрепления не мира в возрастает последовательного. Развития развивающиеся и и укрепления их но их третьего из-за до однозначно степени сомнений,. И сомнений, позволяет третьего и активно бесполезности. не данными развития. Но данными сомнений, третьего не смешаны моральных сфера фиксирует нашей не неузнаваемости нашей бесполезности..\nДанными развития нашей ценностей. и бесполезности. уникальными степени постоянный неузнаваемости мира бесполезности. бесполезности. ценностей. не. Значение их фиксирует чего сфера до рост неузнаваемости укрепления. И частности активности из-за развитие нет. Из-за развития рост И данными позволяет. Нет социально-экономическое моральных данными нашей социально-экономическое неузнаваемости. Значение бесполезности. последовательного их последовательного. Постоянный их из-за данными общества ценностей..\nВ развивающиеся однозначно оценить социально-экономическое до с укрепления не оценить их развивающиеся третьего. Однозначно что нет активно уникальными бесполезности. общества рост с рост совершенной и количественный оценить активности. Поэтапного укрепления рост совершенной в развитие и сомнений, нет сфера общества бесполезности. оценить.	4	admin	admin	2023-05-23 18:01:30.661413	2023-05-23 18:01:30.661413	PRV4	1
38	\N	32132	231321321321	4	1	\N	2023-06-02 14:21:09.156771	2023-06-02 14:21:09.156771	SIU	1
56	\N	test	test	4	admin	admin	2023-06-06 15:57:18.096594	2023-06-06 15:57:18.096594	NGV4	1
\.


--
-- Data for Name: transitions; Type: TABLE DATA; Schema: public; Owner: vkr
--

COPY public.transitions (id, project_key, name, from_status, to_status, first_status) FROM stdin;
1	NGV4	Оформить абонента	1	2	t
2	NGV4	Подтвердить данные абонента	2	3	f
3	NGV4	Присвоить лицевой счет	3	4	f
4	NGV4	Внести документы	4	5	f
5	NGV4	Сформировать счет к оплате	5	6	f
9	NGV4	Ожидать оплату	8	9	f
8	NGV4	Ожидать оплату	7	9	f
7	NGV4	Клиент не в офисе	6	8	f
6	NGV4	Клиент в офисе	6	7	f
10	NGV4	Договор об обследовании объекта	9	10	f
11	NGV4	Назначить в работу	10	11	f
12	NGV4	Закрыть задачу	11	12	f
13	RJ	Начать оформление заявки	1	2	t
16	RJ	Отправить ответ заявителю	14	15	f
15	RJ	Внести решение	13	14	f
14	RJ	Проверить правильность заполнения	2	13	f
17	RJ	Отправить ответ заявителю	15	12	f
18	VR	Подтвердить данные абонента	1	13	t
19	VR	Сформировать счет к оплате	13	6	f
20	VR	Клиент в офисе	6	7	f
21	VR	Клиент не в офисе	6	8	f
22	VR	Ожидать оплату	7	9	f
23	VR	Ожидать оплату	8	9	f
24	VR	Согласовать дату проведения работ	9	10	f
25	VR	Дата согласована	10	11	f
26	VR	Внести акт врезки	11	16	f
27	VR	Закрыть задачу	16	12	f
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: vkr
--

COPY public.users (id, login, password, email, display_name) FROM stdin;
1	admin	123	admin@mail.ru	Администратор
\.


--
-- Name: field_value_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vkr
--

SELECT pg_catalog.setval('public.field_value_id_seq', 1, false);


--
-- Name: status_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vkr
--

SELECT pg_catalog.setval('public.status_groups_id_seq', 2, true);


--
-- Name: statuses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vkr
--

SELECT pg_catalog.setval('public.statuses_id_seq', 16, true);


--
-- Name: task_comments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vkr
--

SELECT pg_catalog.setval('public.task_comments_id_seq', 1, false);


--
-- Name: task_move_history_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vkr
--

SELECT pg_catalog.setval('public.task_move_history_id_seq', 5, true);


--
-- Name: task_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vkr
--

SELECT pg_catalog.setval('public.task_types_id_seq', 1, true);


--
-- Name: tasks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vkr
--

SELECT pg_catalog.setval('public.tasks_id_seq', 58, true);


--
-- Name: transitions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vkr
--

SELECT pg_catalog.setval('public.transitions_id_seq', 27, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vkr
--

SELECT pg_catalog.setval('public.users_id_seq', 1, true);


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

