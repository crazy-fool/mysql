创建数据库 指定字符集：CREATE DATABASE IF NOT EXISTS like_qq DEFAULT CHARSET utf8 COLLATE utf8_general_ci;
	创建表  menu表：CREATE TABLE IF NOT EXISTS menu( ID INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT '主键',name VARCHAR(20) NOT NULL COMMENT'类名',dir VARCHAR(255) NOT NULL COMMENT 'url地址',pid INT NOT NULL DEFAULT 0 COMMENT '父id',icon VARCHAR(20) COMMENT '图标', status tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否启用')ENGINE=INNODB DEFAULT CHARSET=utf8;
添加数据：
INSERT INTO menu(name,dir,pid,icon,status) values('新闻','News/Index/index',0,'#3423',1);
INSERT INTO menu(name,dir,pid,icon,status) values('视频','Views/Index/index',0,'#34ad',1);
INSERT INTO menu(name,dir,pid,icon,status) values('财经','Finance/Index/index',0,'#34D5',1);		
INSERT INTO menu(name,dir,pid,icon,status) values('体育','Sport/Index/index',0,'#dasd',1);
INSERT INTO menu(name,dir,pid,icon,status) values('娱乐','Ent/Index/index',0,'#daaa',1);
INSERT INTO menu(name,dir,pid,icon,status) values('时尚','Fashion/Index/index',0,'#sasd',1);


INSERT INTO menu(name,dir,pid,icon,status) values('国际','News/Word/index',1,'#3425',1);
INSERT INTO menu(name,dir,pid,icon,status) values('社会','News/Society/index',1,'#3425',1);
INSERT INTO menu(name,dir,pid,icon,status) values('军事','News/Mil/index',1,'#3d25',1);	

INSERT INTO menu(name,dir,pid,icon,status) values('金融','Finance/Jr/index',3,'#a425',1);
INSERT INTO menu(name,dir,pid,icon,status) values('证券','Finance/Stock/index',3,'#3425',1);
INSERT INTO menu(name,dir,pid,icon,status) values('宏观','Finance/Hg/index',3,'#3d25',1);

INSERT INTO menu(name,dir,pid,icon,status) values('电影','Views/Movie/index',2,'#a425',1);
INSERT INTO menu(name,dir,pid,icon,status) values('电视剧','Views/Tv/index',2,'#3425',1);
INSERT INTO menu(name,dir,pid,icon,status) values('综艺','Views/Variety/index',2,'#3d25',1);


INSERT INTO menu(name,dir,pid,icon,status) values('CBA','Sport/Cba/index',4,'#a425',1);
INSERT INTO menu(name,dir,pid,icon,status) values('NBA','Sport/Nba/index',4,'#3425',1);
INSERT INTO menu(name,dir,pid,icon,status) values('中超','Sport/Cfoot/index',4,'#3d25',1);
ALTER TABLE menu CHANGE name Name VARCHAR(20) ;
ALTER TABLE menu CHANGE dir Dir VARCHAR(255) COMMENT"url地址";
ALTER TABLE menu CHANGE pid Pid INT(11) NOT NULL DEFAULT 0 COMMENT"父id";
ALTER TABLE menu CHANGE icon Icon VARCHAR(20) COMMENT"图标";
ALTER TABLE menu CHANGE status Status TINYINT(1) NOT NULL DEFAULT 0 COMMENT"是否启用0不启用，1启用";
ALTER TABLE menu ADD COLUMN ModifieDate TIMESTAMP(2);
ALTER TABLE MENU ADD COLUMN ModifieID INT(11);
ALTER TABLE menu MODIFY COLUMN ModifieID INT(11) NOT NULL DEFAULT 0;
	创建表 auth表：CREATE TABLE IF NOT EXISTS auth(ID INT(11) PRIMARY KEY COMMENT"主键",role VARCHAR(30) NOT NULL COMMENT"角色",status TINYINT(1) NOT NULL DEFAULT 0 COMMENT"是否启用 0不启用，1启用")ENGINE=INNODB DEFAULT CHARSET=utf8;
ALTER TABLE auth MODIFY ID INT(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE auth ADD COLUMN `describe` VARCHAR(255) COMMENT"角色描述";
ALTER TABLE auth ADD COLUMN ModifiedDate TIMESTAMP ;
ALTER TABLE auth ADD COLUMN Modifie_ID INT(11) ;
ALTER TABLE auth CHANGE `describe` `Describe` VARCHAR(255) COMMENT"角色描述";
ALTER TABLE auth CHANGE status Status TINYINT(1) NOT NULL DEFAULT 0 COMMENT"是否启用 0不启用 1启用"
ALTER TABLE auth CHANGE role Role VARCHAR(30) NOT NULL COMMENT"角色";
ALTER TABLE auth CHANGE ModifiedDate ModifieDate TIMESTAMP;
ALTER TABLE auth ALTER COLUMN ModifieDate INT(14);#错误
ALTER TABLE auth MODIFY COLUMN ModifieDate TIMESTAMP(14) DEFAULT current_timestamp;#默认值不能是函数
ALTER TABLE auth CHANGE COLUMN Modifie_ID ModifieID INT(11);

ALTER TABLE auth ALTER COLUMN ModifieDate TIMESTAMP DEFAULT current_timestamp;
INSERT INTO auth(role,status,`describe`,ModifieDate,ModifieID) VALUES('root',1,'超管','USE1',11);
INSERT INTO auth(role,status) VALUES('root',1);
INSERT INTO auth(role,status) VALUES('root',1);


后台权限列表：包含导航功能
	CREATE TABLE role (ID INT(11)NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "主键",Name VARCHAR(20) DEFAULT '' COMMENT"名称",Url VARCHAR(255) DEFAULT ''COMMENT"路径",Pid INT(11) NOT NULL DEFAULT 0,TYPE TINYINT(1) DEFAULT 0 COMMENT"类型 0导航菜单，1 button",Icon VARCHAR(10) DEFAULT '' COMMENT"图标",Status TINYINT(1) COMMENT "0禁用1启用",ModifieDate DATETIME DEFAULT "1900 01 01 01:01:01",ModifieID INT(11) DEFAULT 0)ENGINE INNODB CHARSET utf8;
	ALTER TABLE role MODIFY Status TINYINT(1) DEFAULT 0 COMMENT"0禁用1启用";
	ALTER TABLE role ADD `Sort` INT(11) NOT NULL AUTO_INCREMENT  #一张表只有一个字段自增
	
权限角色关联表：
	CREATE TABLE role_auth(ID INT(11) UNSIGNED AUTO_INCREMENT PRIMARY KEY,AuthID INT(11) UNSIGNED NOT NULL ,RoleID INT(11) UNSIGNED NOT NULL)ENGINE=	INNODB DEFAULT CHARSET=utf8;
	
	INSERT INTO role(Name,Url,Pid,`Type`,Icon,Status,ModifieDate,ModifieID,Sort) VALUES('会员中心','Admin/User/index',0,0,'sdas',1,NOW(),1,1);
	INSERT INTO role(Name,Url,Pid,`Type`,Icon,Status,ModifieDate,ModifieID,Sort) VALUES('权限管理','Admin/auth/index',0,0,'sdas',1,NOW(),1,1);
	INSERT INTO role(Name,Url,Pid,`Type`,Icon,Status,ModifieDate,ModifieID,Sort) VALUES('内容管理','Admin/Content/index',0,0,'sdas',1,NOW(),1,1);
	
	INSERT INTO role(Name,Url,Pid,`Type`,Icon,Status,ModifieDate,ModifieID,Sort) VALUES('地址管理','Admin/Address/index',7,0,'sdas',1,NOW(),1,1);
	INSERT INTO role(Name,Url,Pid,`Type`,Icon,Status,ModifieDate,ModifieID,Sort) VALUES('设置','',0,0,'sdas',1,NOW(),1,1);
	INSERT INTO role(Name,Url,Pid,`Type`,Icon,Status,ModifieDate,ModifieID,Sort) VALUES('管理员列表','Admin/Adm/index',8,0,'sdas',1,NOW(),1,1);
	
	INSERT INTO role(Name,Url,Pid,`Type`,Icon,Status,ModifieDate,ModifieID,Sort) VALUES('会员列表','Admin/User/list',7,0,'sdas',1,NOW(),1,1);
	INSERT INTO role(Name,Url,Pid,`Type`,Icon,Status,ModifieDate,ModifieID,Sort) VALUES('权限列表','Admin/Role/index',8,0,'sdas',1,NOW(),1,1);
	
	INSERT INTO role(Name,Url,Pid,`Type`,Icon,Status,ModifieDate,ModifieID,Sort) VALUES('会员更新','Admin/User/update',13,1,'sdas',1,NOW(),1,1);
	INSERT INTO role(Name,Url,Pid,`Type`,Icon,Status,ModifieDate,ModifieID,Sort) VALUES('会员删除','Admin/User/delete',13,1,'sdas',1,NOW(),1,1);
	
	INSERT INTO role(Name,Url,Pid,`Type`,Icon,Status,ModifieDate,ModifieID,Sort) VALUES('地址更新','Admin/Address/update',10,1,'sdas',1,NOW(),1,1);
	INSERT INTO role(Name,Url,Pid,`Type`,Icon,Status,ModifieDate,ModifieID,Sort) VALUES('地址删除','Admin/Address/delete',10,1,'sdas',1,NOW(),1,1);
	
	INSERT INTO role(Name,Url,Pid,`Type`,Icon,Status,ModifieDate,ModifieID,Sort) VALUES('管理员更新','Admin/Adm/update',12,1,'sdas',1,NOW(),1,1);
	INSERT INTO role(Name,Url,Pid,`Type`,Icon,Status,ModifieDate,ModifieID,Sort) VALUES('管理员删除','Admin/Adm/delete',12,1,'sdas',1,NOW(),1,1);
	
	INSERT INTO role(Name,Url,Pid,`Type`,Icon,Status,ModifieDate,ModifieID,Sort) VALUES('权限更新','Admin/Role/update',14,1,'sdas',1,NOW(),1,1);
	INSERT INTO role(Name,Url,Pid,`Type`,Icon,Status,ModifieDate,ModifieID,Sort) VALUES('权限删除','Admin/Role/delete',14,1,'sdas',1,NOW(),1,1);
	
	INSERT INTO role_auth(AuthID,RoleID) VALUES(1,7);

管理员表：
		CREATE TABLE adm(ID INT(11) UNSIGNED AUTO_INCREMENT PRIMARY KEY,Name VARCHAR(20) DEFAULT"",Pwd VARCHAR(100) DEFAULT"",`Describe` VARCHAR(255) DEFAULT "",AuthID INT(11) DEFAULT 0,Status TINYINT(1) DEFAULT 0 COMMENT"是否启用0不启用1启用", ModifieDate DATETIME DEFAULT "1900-01-01 01:01:01",ModifieID INT(11) DEFAULT 0 ) ENGINE=INNODB DEFAULT CHARSET=utf8;
		ALTER TABLE adm CHANGE Name VARCHAR(100) NOT NULL; 
		ALTER TABLE adm ADD UNIQUE(Name);
		INSERT INTO adm(Name,Pwd,`Describe`,AuthID,Status,ModifieDate,ModifieID) VALUES('adm',PASSWORD('123456'),'超管',1,1,NOW(),1);
	
	
	
	
	
