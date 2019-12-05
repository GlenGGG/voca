#下述触发器实现了，用户创建时同时建立个人页的功能
drop trigger if exists IN_User_TRG;
create trigger IN_User_TRG after insert on voca_site_user
for each row insert into voca_site_pspage(email, update_time, user_id, visitor_cnt) values(NEW.email, now(), NEW.id, 0);
#下述触发器实现了，防止记录用户对自己的朋友关系
drop trigger if exists IN_User_Friend_TRG;
delimiter //
create trigger IN_User_Friend_TRG before insert on voca_site_user_friend
for each row
BEGIN
	IF NEW.from_user_id = NEW.to_user_id THEN
		SIGNAL SQLSTATE 'TX000' SET MESSAGE_TEXT = 'user cannot be a friend with himself/hersefl';
	END IF;
END;//
delimiter ;
#下述触发器实现了，防止记录用户对自己的朋友关系
drop trigger if exists UP_User_Friend_TRG;
delimiter //
create trigger UP_User_Friend_TRG before update on voca_site_user_friend
for each row
BEGIN
	IF NEW.from_user_id = NEW.to_user_id THEN
		SIGNAL SQLSTATE 'TX000' SET MESSAGE_TEXT = 'user cannot be a friend with himself/hersefl';
	END IF;
END;//
delimiter ;
#下述触发器实现了，防止记录用户对自己发信息
drop trigger if exists IN_User_User_Message_TRG;
delimiter //
create trigger IN_User_User_Message_TRG before insert on voca_site_user_user_message
for each row
BEGIN
	IF NEW.message_receiver_id = NEW.message_sender_id THEN
		SIGNAL SQLSTATE 'TX000' SET MESSAGE_TEXT = 'Exception occurred when user send message to himself/herself';
	END IF;
END;//
delimiter ;
#不能给自己发信息
drop trigger if exists UP_User_User_Message_TRG;
delimiter //
create trigger UP_User_User_Message_TRG before update on voca_site_user_user_message
for each row
BEGIN
	IF NEW.message_receiver_id = NEW.message_sender_id THEN
		SIGNAL SQLSTATE 'TX000' SET MESSAGE_TEXT = 'Exception occurred when user send message to himself/herself';
	END IF;
END;//
delimiter ;

drop trigger if exists IN_Pspage_User_TRG;
delimiter //

create trigger IN_Pspage_User_TRG before insert on voca_site_pspage_user_visit
for each row
BEGIN
	declare userid int;
    set userid = (select voca_site_pspage.user_id from voca_site_pspage where voca_site_pspage.pspage_id=NEW.pspage_id);
	IF NEW.user_id = userid THEN
		SIGNAL SQLSTATE 'TX000' SET MESSAGE_TEXT = 'No self visit should be record';
	END IF;
END;//
delimiter ;

drop trigger if exists UP_Pspage_User_TRG;
delimiter //

create trigger UP_Pspage_User_TRG before update on voca_site_pspage_user_visit
for each row
BEGIN
	declare userid int;
    set userid = (select voca_site_pspage.user_id from voca_site_pspage where voca_site_pspage.pspage_id=NEW.pspage_id);
	IF NEW.user_id = userid THEN
		SIGNAL SQLSTATE 'TX000' SET MESSAGE_TEXT = 'No self visit should be record';
	END IF;
END;//
delimiter ;

#密码不能为空
drop trigger if exists IN_User_Password_TRG;
delimiter //
create trigger IN_User_Password_TRG before insert on voca_site_user
for each row
begin
    if new.password = '' then
		SIGNAL SQLSTATE 'TX000' SET MESSAGE_TEXT = 'Password cant be null';
        end if;
end;//
delimiter ;
drop trigger if exists UP_User_Password_TRG;
delimiter //
create trigger UP_User_Password_TRG before update on voca_site_user
for each row
begin
    if new.password = '' then
		SIGNAL SQLSTATE 'TX000' SET MESSAGE_TEXT = 'Password cant be null';
        end if;
end;//
delimiter ;

#邮箱正误
drop trigger if exists IN_User_Email_TRG;
delimiter //
create trigger IN_User_Email_TRG before insert on voca_site_user
for each row
begin
    if (new.email not regexp  '[@]' or new.email not regexp  '[.]') then
		SIGNAL SQLSTATE 'TX000' SET MESSAGE_TEXT = 'Email is not right';
        end if;
end;//
delimiter ;
#邮箱正误
drop trigger if exists UP_User_Email_TRG;
delimiter //
create trigger UP_User_Email_TRG before update on voca_site_user
for each row
begin
    if (new.email not regexp  '[@]' or new.email not regexp  '[.]') then
		SIGNAL SQLSTATE 'TX000' SET MESSAGE_TEXT = 'Email is not right';
        end if;
end;//
delimiter ;