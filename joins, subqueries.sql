select 
    pd.part_name,
    pd.part_number,
    pl.aisle_no,
    pl.shelf_no,
    c.category_name
from 
    parts_detail pd
inner join 
    parts_location pl on pd.location_id = pl.location_id
inner join 
    categories c on pd.category_id = c.category_id;


--all company dealers and their part_name and unit_price
select 
    c.company_name,
    pd.part_name,
    pd.unit_price
from 
    company c
left join 
    company_part cp on c.company_id = cp.company_id
left join 
    parts_detail pd on cp.part_id = pd.part_id;





-- non-correlated subquery
--all categories
select 
    part_name,
    unit_price
from 
    parts_detail
where 
    unit_price > (select avg(unit_price) from parts_detail);


--correlated subquery
-- parts detial whose unit price is greater than average in same category
select 
    p.part_id,
    p.part_name,
    p.unit_price
from 
    parts_detail p
where 
    p.unit_price > (
        select avg(pd.unit_price)
        from parts_detail pd
        where pd.category_id = p.category_id
    );


--aggregate data
--total parts in according to categories
select 
    c.category_name,
    sum(pd.quantity) as total_quantity
from 
    parts_detail pd
inner join 
    categories c
on 
    pd.category_id = c.category_id
group by 
    c.category_name
order by 
    total_quantity desc;
