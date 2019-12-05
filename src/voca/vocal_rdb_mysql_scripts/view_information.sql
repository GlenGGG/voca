CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `voca_site_search_view_information` AS
    SELECT 
        `voca_site_user`.`id` AS `id`,
        `voca_site_user`.`name` AS `name`,
        `voca_site_pspage`.`email` AS `email`,
        `voca_site_pspage`.`info` AS `info`,
        `voca_site_pspage`.`joborein` AS `joborein`,
        `voca_site_orgniza`.`name` AS `firm`,
        `voca_site_pspage`.`pspage_id` AS `pspage_id`,
        `voca_site_depart`.`name` AS `department`,
        `voca_site_position`.`name` AS `position_name`
    FROM
        ((((`voca_site_user`
        LEFT JOIN `voca_site_pspage` ON ((`voca_site_user`.`id` = `voca_site_pspage`.`user_id`)))
        LEFT JOIN `voca_site_position` ON ((`voca_site_user`.`position_id` = `voca_site_position`.`id`)))
        LEFT JOIN `voca_site_depart` ON ((`voca_site_user`.`depart_id` = `voca_site_depart`.`id`)))
        LEFT JOIN `voca_site_orgniza` ON ((`voca_site_user`.`orgniza_id` = `voca_site_orgniza`.`id`)))