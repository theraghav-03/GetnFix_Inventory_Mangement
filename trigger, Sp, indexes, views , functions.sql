-- Indexes
create nonclustered index IX_partsDetail_partNumber
	on parts_detail(part_number);

create nonclustered index IX_partsDetail_quantity
	on parts_detail(quantity);

--Triggers
--this trigger will create log and create error when quantity of any part is less than 10

create or alter trigger trg_lowquantityalert
on parts_detail
after update
as
begin
    if exists (select 1 from inserted where quantity < 10)
    begin
        declare @partid int, @partname varchar(50);

        select 
            @partid = cast(part_id as int), 
            @partname = part_name
        from inserted
        where quantity < 10;

        raiserror ('low stock alert: part id %d (%s) has quantity below 10.', 
                   16, 1, @partid, @partname) with log;
    end;
end;


-- Stored procedures
/*
Name : Raghav sharma
date :28/11/2024
description: this stored procedure will help to get all details of compatible part for inputed vehicle detail.
*/

create or alter proc sp_getPartsDetailForVehicle
    @Make varchar(30),
    @Model varchar(30),
    @Year int,
    @Type varchar(30),
    @Engine varchar(30)
as
begin
    select 
        p.part_id,
        p.part_name,
        p.part_number,
        p.unit_price,
        p.quantity,
        p.date_added,
        v.vehicle_id,
        concat(v.year, ' ', v.make, ' ', v.model, ' ', v.type, ' ', v.engine) as vehicle_details
    from 
        parts_detail p
    inner join 
        parts_fitment f on p.part_id = f.part_id
    inner join 
        vehicle v on f.vehicle_id = v.vehicle_id
    where 
        v.make = @Make
        and v.model = @Model
        and v.year = @Year
        and v.type = @Type
        and v.engine = @Engine;
end;


--executing sp
exec sp_getPartsDetailForVehicle 
    @Make = 'honda',
    @Model = 'civic',
    @Year = 2011,
    @Type = 'a',
    @Engine = '2.4l';




 -- Transaction based Sp
/*
Name : Raghav sharma
date :28/11/2024
description: This Transaction based Stored procedure will make sure when changing the location of a part from one location to another(aisle and shelf no.),
			 the quantity of that part updates in both lcoation.
*/

create or alter proc sp_TransferPartToNewLocation
    @PartId numeric(10),
    @FromAisleNo NUMERIC(10),
    @FromShelfNo NUMERIC(10),
    @ToAisleNo NUMERIC(10),
    @ToShelfNo NUMERIC(10),
    @Quantity NUMERIC(10)
as
begin
    begin transaction;
    begin try
        update parts_detail
        set quantity = quantity - @Quantity
        where part_id = @PartId
        and location_id = (select location_id from parts_location 
                           where aisle_no = @FromAisleNo and shelf_no = @FromShelfNo)
        and quantity >= @Quantity;

      
        if @@rowcount = 0
        begin
            throw 50002, 'Insufficient stock at the source location or invalid location.', 1;
        end

        update parts_detail
        set quantity = quantity + @Quantity
        where part_id = @PartId
        and location_id = (select location_id from parts_location 
                           where aisle_no = @ToAisleNo and shelf_no = @ToShelfNo);

        -- Check if the target update was successful
        if @@rowcount = 0
        begin
            throw 50003, 'New location does not exist.', 1;
        end

        commit transaction;
    end try
    begin catch
        rollback transaction;
        throw;
    end catch
end;


--executing sp
exec sp_TransferPartToNewLocation 
    @PartId = 2, 
    @FromAisleNo = 1, 
    @FromShelfNo = 2, 
    @ToAisleNo = 5, 
    @ToShelfNo = 2, 
    @Quantity = 5;


-- views
--1). View to see all vehicle parts with low quantity (>10)

create view vw_low_stock_parts as
select 
    p.part_id,
    p.part_name,
    p.part_number,
    p.quantity,
    pl.aisle_no,
    pl.shelf_no
from 
    parts_detail p
join 
    parts_location pl on p.location_id = pl.location_id
where 
    p.quantity < 10;

select * from vw_low_stock_parts
--2).view to see which parts fits best to which vehicle 

create view vw_part_vehicle_fitment as
select 
    pf.part_id,
    pd.part_name,
    pd.part_number,
    v.make,
    v.model,
    v.year,
    v.engine
from 
    parts_fitment pf
inner join 
    parts_detail pd on pf.part_id = pd.part_id
inner join 
    vehicle v on pf.vehicle_id = v.vehicle_id;

select * from vw_part_vehicle_fitment

-- function
--this function will calculate the averahe price of a category of part 

create function fn_average_price_by_category (@category_id numeric(10))
returns numeric(10,2)
as
begin
    declare @average_price numeric(10,2);
    select @average_price = avg(unit_price)
    from parts_detail
    where category_id = @category_id;

        return @average_price;
end;

select dbo.fn_average_price_by_category(1) as average_price;
