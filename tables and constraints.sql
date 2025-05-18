drop table if exists company_part
drop table if exists parts_fitment
drop table if exists parts_detail
drop table if exists vehicle
drop table if exists company
drop table if exists categories
drop table if exists parts_location

create table parts_location(
	location_id		numeric(10)	not null,
	aisle_no		numeric(10),
	shelf_no		numeric(10),

	constraint location_idPK
		primary key(location_id)
);

create table categories(
	category_id		numeric(10) not null,
	category_name   varchar(30) not null,

	constraint category_idPK
		primary key(category_id)
);

create table company(
	company_id		numeric(10) not null,
	company_name	varchar(50) not null,
	
	constraint company_idPK
		primary key(company_id)
);

create table vehicle (
	vehicle_id		numeric(10) not null,
	make			varchar(30) not null,
	model			varchar(30) not null,
	year			varchar(30) not null,
	type			varchar(30) not null,
	engine			varchar(30) not null,

	constraint vehicle_idPK
		primary key(vehicle_id),

	constraint makeCompaniesCheck
		check (make in ('honda', 'toyota'))
		
);

create table parts_detail(
	part_id			numeric(10) not null,
	part_name		varchar(255) not null,
	part_number		varchar(80) not null,
	unit_price		numeric(10,2) not null,
	quantity		numeric(10) not null,
	date_added		datetime not null,
	category_id		numeric(10) not null,
	location_id		numeric(10) not null,

	constraint part_idPK
		primary key(part_id),

	constraint category_idFK
		foreign key(category_id)
		references categories(category_id),

	constraint location_idFK
		foreign key(location_id)
		references parts_location(location_id),

	constraint positiveUnitPrice
		check(unit_price >0)
);

create table parts_fitment(
	fitment_id		numeric(10) not null,
	part_id			numeric(10) not null,
	vehicle_id		numeric(10) not null,

	constraint fitment_idPK
		primary key(fitment_id),

	constraint part_idFK
		foreign key(part_id)
		references parts_detail(part_id),

	constraint vehicle_idFK
		foreign key(vehicle_id)
		references vehicle(vehicle_id)
);

create table company_part(
	companyPart_id		numeric(10) not null,
	company_id			numeric(10) not null,
	part_id				numeric(10) not null,

	constraint companyPart_idPK
		primary key(companyPart_id),

	constraint company_idFK
		foreign key(company_id)
		references company(company_id),

	constraint part_idsecondFK
		foreign key(part_id)
		references parts_detail(part_id)
);


ALTER TABLE parts_detail
ALTER COLUMN part_name VARCHAR(500);

ALTER TABLE parts_fitment
ALTER COLUMN vehicle_id NUMERIC(10) NULL;
