/***
	this script is used for creating initial tables
    this script recreate all tables
***/

use voca_rdb;
#drop table if exists tb_user;
create table if not exists tb_user
(
	user_id int not null auto_increment,
    user_ac char(20) not null,
    user_name char(10) not null,
    user_gender boolean not null check(value in (0,1)),
    create_time timestamp not null default current_timestamp(),
    primary key(user_id),
	unique index uniq_ind_tb_user_user_ac(user_ac)
)engine=InnoDB;

#drop table if exists tb_pasw;
create table if not exists tb_pasw
(
    user_ac char(20) not null,
    user_pasw char(30) not null,
    primary key(user_ac),
    foreign key fk_tb_pasw_user_col_user_ac (user_ac)
    references tb_user(user_ac)
    on update cascade
    on delete cascade
)engine=InnoDB;

#drop table if exists tb_univs;
create table if not exists tb_univs
(
	univs_id char(8) not null,
    univs_name char(15) not null,
    primary key(univs_id)
)engine=InnoDB;

#drop table if exists tb_orgniza;
create table if not exists tb_orgniza
(
	orgniza_id int not null auto_increment,
    orgniza_name char(15) not null,
    orgniza_local char(30) null,
    primary key(orgniza_id)
)engine=InnoDB;

#drop table if exists tb_depart;
create table if not exists tb_depart
(
	depart_id int not null auto_increment,
    depart_name char(15) not null,
    primary key(depart_id)
)engine=InnoDB;

create table if not exists tb_position
(
	position_id int not null auto_increment,
    position_name char(15) not null,
    primary key(position_id)
)engine=InnoDB;

#drop table if exists tb_pspage;
create table if not exists tb_pspage
(
	pspage_id int not null auto_increment,
    pspage_info varchar(10000) null,
    pspage_email varchar(20) null,
    pspage_joborein varchar(200) null,
    orgniza_id int null,
    univs_id char(8) null,
    position_id int null,
    depart_id int null,
    univs_enro_time date null,
    user_id int not null,
    primary key(pspage_id),
    foreign key fk_tb_pspage_univs_col_univs_id (univs_id)
    references tb_univs(univs_id)
    on update cascade
    on delete set null,
    foreign key fk_tb_pspage_position_col_position_id (position_id)
    references tb_position(position_id)
    on update cascade
    on delete set null,
    foreign key fk_tb_pspage_depart_col_depart_id (depart_id)
    references tb_depart(depart_id)
    on update cascade
    on delete set null,
    foreign key fk_tb_pspage_orgniza_col_orgniza_id (orgniza_id)
    references tb_orgniza(orgniza_id)
    on update cascade
    on delete set null,
    foreign key fk_tb_pspage_user_col_user_id (user_id)
    references tb_user(user_id)
    on update cascade
    on delete cascade
)engine=InnoDB;

#drop table if exists tb_pu_visit;
create table if not exists tb_pu_visit
(
    pspage_id int not null,
    user_id int not null,
    visit_time timestamp not null default current_timestamp(),
    primary key(pspage_id, user_id, visit_time),
    foreign key fk_tb_pu_visit_user_col_user_id (user_id)
    references tb_user(user_id)
    on update cascade
    on delete cascade,
    foreign key fk_tb_pu_visit_pspage_col_pspage_id (pspage_id)
    references tb_pspage(pspage_id)
    on update cascade
    on delete cascade
)engine=InnoDB;

#drop table if exists tb_u_contact;
create table if not exists tb_u_contact
(
	user_id1 int not null,
    user_id2 int not null,
    primary key(user_id1, user_id2),
    foreign key fk_tb_u_contact_user_col_user_id1 (user_id1)
    references tb_user(user_id)
    on delete cascade
    on update cascade,
    foreign key fk_tb_u_contact_user_col_user_id2 (user_id2)
    references tb_user(user_id)
    on delete cascade
    on update cascade,
    check(user_id1 <> user_id2)
)engine=InnoDB;

#drop table if exists tb_upo_incumben;
create table if not exists tb_upo_incumben
(
	user_id int not null,
    position_id int not null,
    orgniza_id int not null,
    primary key(user_id, position_id, orgniza_id),
    foreign key fk_tb_upo_incumben_user_col_user_id (user_id)
    references tb_user(user_id)
    on delete cascade
    on update cascade,
    foreign key fk_tb_upo_incumben_position_col_position_id (position_id)
    references tb_position(position_id)
    on delete cascade
    on update cascade,
    foreign key fk_tb_upo_incumben_orgniza_col_orgniza_id (orgniza_id)
    references tb_orgniza(orgniza_id)
    on delete cascade
    on update cascade
)engine=InnoDB;

#drop table if exists tb_uu_attend;
create table if not exists tb_uu_attend
(
	user_id int not null,
    univs_id char(8) not null,
    primary key(user_id, univs_id),
    foreign key fk_tb_uu_attend_user_col_user_id(user_id)
    references tb_user(user_id)
    on delete cascade
    on update cascade,
    foreign key fk_tb_uu_attend_univs_col_univs_id(univs_id)
    references tb_univs(univs_id)
    on delete cascade
    on update cascade
)engine=InnoDB;

#drop table if exists tb_uu_gra;
create table if not exists tb_uu_gra
(
	user_id int not null,
    univs_id char(8) not null,
    primary key(user_id, univs_id),
    foreign key fk_tb_uu_gra_user_col_user_id(user_id)
    references tb_user(user_id)
    on delete cascade
    on update cascade,
    foreign key fk_tb_uu_gra_univs_col_univs_id(univs_id)
    references tb_univs(univs_id)
    on delete cascade
    on update cascade
)engine=InnoDB;

#drop table if exists tb_ud_incumben;
create table if not exists tb_ud_incumben
(
	user_id int not null,
    depart_id int not null,
    primary key(user_id, depart_id),
    foreign key fk_tb_ud_incumben_user_col_user_id (user_id)
    references tb_user(user_id)
    on delete cascade
    on update cascade,
    foreign key fk_tb_ud_incumben_depart_col_depart_id (depart_id)
    references tb_depart(depart_id)
    on delete cascade
    on update cascade
)engine=InnoDB;

