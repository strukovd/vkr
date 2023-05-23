create table tasks
(
	id serial not null
		constraint tasks_pk
			primary key,
	key varchar(50),
	title varchar(500) not null,
	"desc" text,
	priority smallint,
	assignee varchar(100),
	creator varchar(100),
	updated timestamp,
	created timestamp
);

alter table tasks owner to postgres;

create unique index tasks_key_uindex
	on tasks (key);

create table users
(
	id serial not null
		constraint users_pk
			primary key,
	login varchar(100) not null,
	password varchar(255) not null,
	email varchar(500),
	display_name varchar(500)
);

alter table users owner to postgres;

create unique index users_login_uindex
	on users (login);

create table projects
(
	key varchar(50) not null
		constraint projects_pk
			primary key,
	name varchar(255) not null,
	"desc" varchar(500)
);

alter table projects owner to postgres;

create table task_types
(
	id serial not null
		constraint task_types_pk
			primary key,
	name varchar(255) not null,
	"desc" varchar(500)
);

alter table task_types owner to postgres;

create table workflows
(
	id serial not null
		constraint workflows_pk
			primary key,
	name varchar(255) not null
);

alter table workflows owner to postgres;

create table transitions
(
	id serial not null
		constraint transitions_pk
			primary key,
	project_id integer,
	task_type_id integer,
	name varchar(255),
	from_status integer,
	to_status integer
);

alter table transitions owner to postgres;

create index transitions_from_status_index
	on transitions (from_status);

create table field_value
(
	id serial not null
		constraint field_value_pk
			primary key,
	field_id integer,
	project_id integer,
	task_type_id integer,
	value_num numeric,
	value_string varchar(500),
	value_text text,
	value_bool boolean
);

alter table field_value owner to postgres;

create table fields
(
	id integer not null
		constraint fields_pk
			primary key,
	name varchar(255) not null,
	type varchar(25)
);

alter table fields owner to postgres;

-- TODO:
-- task_move_history
-- task_comments
-- statuses -- +status_type (Зеленый, желтый, и т.д)
-- status_types - кастомные типы статусов, повзолят определять этап
