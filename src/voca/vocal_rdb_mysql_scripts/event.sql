DROP event IF EXISTS event_delete_message_after_read_every_day;
delimiter //
CREATE EVENT event_delete_message_after_read_every_day
ON SCHEDULE
EVERY 1 DAY STARTS '2000-01-01 00:00:00'
DO
begin
DELETE FROM voca_site_user_user_message WHERE message_sent_time < DATE_SUB(CURRENT_TIMESTAMP, interval 10 day)
						AND message_read=True;
DELETE FROM voca_site_user_user_message WHERE message_sent_time < DATE_SUB(CURRENT_TIMESTAMP, interval 300 day);
end;//
delimiter ;