use row_trigger; 
drop table stu_det;
-- only if both age is negative 0 and community is NULL otherwise, no update 

delimiter // 
drop trigger if exists age_community_update;
create trigger age_community_update 
before insert on stu_det for each row 
begin

if new.age < 0 and new.community is null then
set new.age = " no update " ;
set new.community = "no update"; 
end if ;

end // 

delimiter ;  


INSERT INTO stu_Det  VALUES
(1, 'Vasanth', 'Erode', 21, null, 32),
(2, 'Guru', 'Tiruppur', -24, 'MBC', 78),
(3, 'Gokul', 'Tiruchirapalli', 18, 'bc', 89),
(4, 'Mani', 'Kumarapalayam', 24, 'BC', 56),
(5, 'Moorthy', 'Salem', -18, NULL, 90);


select * from stu_Det;


show triggers; 


drop trigger if exists age_community_marks_update;

-- Accept both if age is negative ,community is NULL. only age is negative, update only the age. only community is NULL, update only the community.

DELIMITER //

CREATE TRIGGER age_community_marks_update
BEFORE INSERT ON stu_Det
FOR EACH ROW
BEGIN

    -- Fix negative age (cast to number first)
    IF CAST(NEW.age AS SIGNED) < 0 THEN
        SET NEW.age = '0';
    END IF;

    -- Fix NULL or blank community
    IF NEW.community IS NULL OR NEW.community = '' THEN
        SET NEW.community = 'kindly update';
    END IF;

    -- Marks < 35 (cast to number first)
    IF CAST(NEW.marks AS SIGNED) < 35 THEN
        SET NEW.marks = 'reappear';
    END IF;

END;
//

DELIMITER ; 



drop trigger if exists age_community;

select * from stu_det;



