delimiter //
CREATE DEFINER=`root`@`localhost` PROCEDURE `procedure_search`(in input varchar(50))
BEGIN
declare a varchar(50);
set a=replace(input,' ','');
if (input regexp '@') then
select *
from view_combine natural join view_trans
where (view_combine.id  regexp a ) 
	or (view_combine.name regexp a) 
	or (view_combine.email regexp a)
    or(view_combine.info regexp a)
    or(view_combine.firm regexp a)
    or(view_combine.pspage_id regexp a)
    or(view_combine.department regexp a)
    or(view_combine.position_name regexp a)
    or(view_combine.univs_name regexp a);
    else
select *
from view_combine natural join view_trans
where (view_combine.id  regexp (a)) 
	or (view_combine.name regexp (a)) 
    or(view_combine.info regexp (a))
    or(view_combine.firm regexp (a))
    or(view_combine.pspage_id regexp (a))
    or(view_combine.department regexp (a))
    or(view_combine.position_name regexp (a))
    or(view_combine.univs_name regexp (a));
    end if;
END;//
delimiter ;