create table if not exists Departments (
	depart_id serial primary key,
	depart_name varchar(40) not null unique
);

create table if not exists Bosses (
	boss_id serial primary key,
	depart_id int references Departments(depart_id),
	boss_name varchar(100) not null
);

create table if not exists Employees (
	empl_id serial primary key,
	boss_id int references Bosses(boss_id),
	depart_id int references Departments(depart_id),
	empl_name varchar(100) not null
);