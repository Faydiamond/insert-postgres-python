-- Creation table sores
CREATE SEQUENCE stor_id;

create table stores
(
	stor_id integer NOT NULL DEFAULT nextval('stor_id') primary key,
	stor_name character varying(80) not null,
	stor_adress character varying(120) not null,
	city character varying(80) not null,
	state character varying(80) not null,
	zip character varying(80) 
)
-----------------------------------------------------------------------------------

-- Creation table discounts

CREATE SEQUENCE discounts_id;

create table discounts
(
	dicount_id integer NOT NULL DEFAULT nextval('discounts_id') primary key,
	stor_id integer,
	lowqty integer,
	highqty integer,
	discount integer,
	foreign key (stor_id) references stores(stor_id)
	
)
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- creation table jobs
CREATE SEQUENCE jobs_id;

create table jobs 
(
	job_id integer NOT NULL DEFAULT nextval('jobs_id') primary key,
	job_desc varchar(100) not null,
	min_lvl  integer,
	max_lvl  integer	
)
--------------------------------------------------------------------------------
-- creation table  publishers

CREATE SEQUENCE publishers_id;

create table publishers
(
	pub_id integer NOT NULL DEFAULT nextval('publishers_id') primary key,
	pub_name  varchar(70) not null,
	city varchar(70) not null,
	estate varchar(70) not null,
	country varchar(70) not null
)
--------------------------------------------------------------------------------
-- creation table employee
 
CREATE SEQUENCE employees_id;

create table  employee 
(
	emp_id integer NOT NULL DEFAULT nextval('employees_id') primary key,
	fname varchar(100) not null,
	minit varchar(100) ,
	lname varchar(100) not null,
	job_id integer, -- foranea
	job_lvl varchar(80) not null,
	pub_id integer , -- foranea
	hire_date   date not null default CURRENT_DATE ,--fecha_contratacion
	foreign key (job_id) references jobs(job_id),
	foreign key (pub_id) references publishers(pub_id)
)

-------------------------------------------------------------------------------
-- creation table pub_info

CREATE SEQUENCE pub_infoo;

create table pub_info 
(
	pub_inf_id integer NOT NULL DEFAULT nextval('pub_infoo') primary key,
	logo varchar (150),
	pr_info varchar (150),
	pub_id integer,
	foreign key (pub_id) references publishers(pub_id)
)
-------------------------------------------------------------------------------

-- creation table titles

CREATE SEQUENCE titless_id;

create table titles
(
	title_id integer NOT NULL DEFAULT nextval('titless_id') primary key,
	title varchar (160) not null,
	typee varchar(120) ,
	typelist varchar(100),
	pub_id integer, --foranea
	price numeric(5,2),
	advance varchar(50),
	royalty varchar (70),
	ytd_sales numeric(5,2) not null,
	notes varchar( 180) ,
	pubdate   date not null default CURRENT_DATE ,--fecha_contratacion
	foreign key (pub_id) references publishers(pub_id)
)
-------------------------------------------------------------------------------

-- creation table royshed

CREATE SEQUENCE rosheds;

create table roysched
(
	roshecd_id integer NOT NULL DEFAULT nextval('titless_id') primary key,
	lorange integer,
	hirange int,
	royalty varchar (70),
	title_id integer,
	foreign key (title_id) references titles(title_id)
)

-------------------------------------------------------------------------------
-- creation table authors

CREATE SEQUENCE authorss;

create table authors
(
	au_id integer NOT NULL DEFAULT nextval('authorss') primary key,
	au_lname varchar (115) not null,
	au_fname varchar (115) not null,
	phone varchar(25),
	adress varchar (115) not null,
	city varchar (65) not null,
	state char(2) not null,
	zip varchar (15) not null,
	contarct varchar (20),
	aut_created   date not null default CURRENT_DATE --fecha_creacion_autor
)

-------------------------------------------------------------------------------
-- creation table title author

CREATE SEQUENCE title_autorss;

create table titleauthor
(
	titleau_id integer NOT NULL DEFAULT nextval('title_autorss') primary key,
	aur_ord integer,
	royal_typer varchar(40),
	au_id integer,
	title_id integer,
	foreign key (title_id) references titles(title_id),
	foreign key (au_id) references authors(au_id)
)
-------------------------------------------------------------------------------
-- creation  table sales 

CREATE SEQUENCE saless;

create table sales
(
	sales_id integer NOT NULL DEFAULT nextval('saless') primary key,
	ord_num integer,
	ord_date  date not null default CURRENT_DATE ,
	qty varchar(20),
	payterns varchar (40),
	stor_id integer,
	title_id integer,
	foreign key (title_id) references titles(title_id),
	foreign key (stor_id) references stores(stor_id)
)


-------------------------------------------------------------------------

--insert store
INSERT INTO public.stores(
            stor_name, stor_adress, city, state, zip)
    VALUES 
		(  'Eric the Read Books','788 Catamaugus Ave.','Seattle','WA','98056'),
		(  'Barnum"s','567 Pasadena Ave.','Tustin','CA','92789'),
		(  'News & Brews','577 First St.','Los Gatos','CA','96745'),
		(  'Doc-U-Mat: Quality Laundry and Books','24-A Avogadro Way','Remulade','WA','98014'),
		(  'Fricative Bookshop','89 Madison St.','Fremont','CA','90019'),
		(  'Bookbeat','679 Carson St.','Portland','OR','89076');

---------------------------------------------------------------------------------------
--Consultas:

-- 4.1

select SUM(t.ytd_sales) as sales, EXTRACT(year from  s.ord_date) as date from sales s
	inner join titles t on s.title_id = t.title_id
group by date
order by date DESC;


----------------------------------------------------------------------------------------
--4.2
select t.title,count(s.sales_id) as unidades_vendidas   from sales s
	inner join titles t on s.title_id = t.title_id
	inner join stores st on s.stor_id = st.stor_id
	where st.state = 'WA'
group by t.title
order by unidades_vendidas DESC;





