CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `voca_site_search_view_trans` AS
    SELECT 
        `voca_site_user_univs_gra`.`user_id` AS `id`,
        `voca_site_univs`.`name` AS `univs_name`
    FROM
        ((`voca_site_user_univs_gra`
        LEFT JOIN `voca_site_univs` ON ((`voca_site_user_univs_gra`.`univs_id` = `voca_site_univs`.`univs_id`)))
        LEFT JOIN `voca_site_user` ON ((`voca_site_user_univs_gra`.`user_id` = `voca_site_user`.`id`)))