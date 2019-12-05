CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `combine` AS
    SELECT 
        `view_information`.`id` AS `id`,
        `view_information`.`name` AS `name`,
        `view_information`.`email` AS `email`,
        `view_information`.`info` AS `info`,
        `view_information`.`joborein` AS `joborein`,
        `view_information`.`firm` AS `firm`,
        `view_information`.`location` AS `location`,
        `view_information`.`pspage_id` AS `pspage_id`,
        `view_information`.`department` AS `department`,
        `view_information`.`position_name` AS `position_name`,
        `view_trans`.`univs_name` AS `univs_name`
    FROM
        (`view_information`
        JOIN `view_trans` ON ((`view_information`.`id` = `view_trans`.`id`)))