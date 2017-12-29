�������ݿ� ָ���ַ�����CREATE DATABASE IF NOT EXISTS like_qq DEFAULT CHARSET utf8 COLLATE utf8_general_ci;
	������  menu��CREATE TABLE IF NOT EXISTS menu( ID INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT '����',name VARCHAR(20) NOT NULL COMMENT'����',dir VARCHAR(255) NOT NULL COMMENT 'url��ַ',pid INT NOT NULL DEFAULT 0 COMMENT '��id',icon VARCHAR(20) COMMENT 'ͼ��', status tinyint(1) NOT NULL DEFAULT 0 COMMENT '�Ƿ�����')ENGINE=INNODB DEFAULT CHARSET=utf8;
������ݣ�
INSERT INTO menu(name,dir,pid,icon,status) values('����','News/Index/index',0,'#3423',1);
INSERT INTO menu(name,dir,pid,icon,status) values('��Ƶ','Views/Index/index',0,'#34ad',1);
INSERT INTO menu(name,dir,pid,icon,status) values('�ƾ�','Finance/Index/index',0,'#34D5',1);		
INSERT INTO menu(name,dir,pid,icon,status) values('����','Sport/Index/index',0,'#dasd',1);
INSERT INTO menu(name,dir,pid,icon,status) values('����','Ent/Index/index',0,'#daaa',1);
INSERT INTO menu(name,dir,pid,icon,status) values('ʱ��','Fashion/Index/index',0,'#sasd',1);


INSERT INTO menu(name,dir,pid,icon,status) values('����','News/Word/index',1,'#3425',1);
INSERT INTO menu(name,dir,pid,icon,status) values('���','News/Society/index',1,'#3425',1);
INSERT INTO menu(name,dir,pid,icon,status) values('����','News/Mil/index',1,'#3d25',1);	

INSERT INTO menu(name,dir,pid,icon,status) values('����','Finance/Jr/index',3,'#a425',1);
INSERT INTO menu(name,dir,pid,icon,status) values('֤ȯ','Finance/Stock/index',3,'#3425',1);
INSERT INTO menu(name,dir,pid,icon,status) values('���','Finance/Hg/index',3,'#3d25',1);

INSERT INTO menu(name,dir,pid,icon,status) values('��Ӱ','Views/Movie/index',2,'#a425',1);
INSERT INTO menu(name,dir,pid,icon,status) values('���Ӿ�','Views/Tv/index',2,'#3425',1);
INSERT INTO menu(name,dir,pid,icon,status) values('����','Views/Variety/index',2,'#3d25',1);


INSERT INTO menu(name,dir,pid,icon,status) values('CBA','Sport/Cba/index',4,'#a425',1);
INSERT INTO menu(name,dir,pid,icon,status) values('NBA','Sport/Nba/index',4,'#3425',1);
INSERT INTO menu(name,dir,pid,icon,status) values('�г�','Sport/Cfoot/index',4,'#3d25',1);
ALTER TABLE menu CHANGE name Name VARCHAR(20) ;
ALTER TABLE menu CHANGE dir Dir VARCHAR(255) COMMENT"url��ַ";
ALTER TABLE menu CHANGE pid Pid INT(11) NOT NULL DEFAULT 0 COMMENT"��id";
ALTER TABLE menu CHANGE icon Icon VARCHAR(20) COMMENT"ͼ��";
ALTER TABLE menu CHANGE status Status TINYINT(1) NOT NULL DEFAULT 0 COMMENT"�Ƿ�����0�����ã�1����";
ALTER TABLE menu ADD COLUMN ModifieDate TIMESTAMP(2);
ALTER TABLE MENU ADD COLUMN ModifieID INT(11);
ALTER TABLE menu MODIFY COLUMN ModifieID INT(11) NOT NULL DEFAULT 0;
	������ auth��CREATE TABLE IF NOT EXISTS auth(ID INT(11) PRIMARY KEY COMMENT"����",role VARCHAR(30) NOT NULL COMMENT"��ɫ",status TINYINT(1) NOT NULL DEFAULT 0 COMMENT"�Ƿ����� 0�����ã�1����")ENGINE=INNODB DEFAULT CHARSET=utf8;
ALTER TABLE auth MODIFY ID INT(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE auth ADD COLUMN `describe` VARCHAR(255) COMMENT"��ɫ����";
ALTER TABLE auth ADD COLUMN ModifiedDate TIMESTAMP ;
ALTER TABLE auth ADD COLUMN Modifie_ID INT(11) ;
ALTER TABLE auth CHANGE `describe` `Describe` VARCHAR(255) COMMENT"��ɫ����";
ALTER TABLE auth CHANGE status Status TINYINT(1) NOT NULL DEFAULT 0 COMMENT"�Ƿ����� 0������ 1����"
ALTER TABLE auth CHANGE role Role VARCHAR(30) NOT NULL COMMENT"��ɫ";
ALTER TABLE auth CHANGE ModifiedDate ModifieDate TIMESTAMP;
ALTER TABLE auth ALTER COLUMN ModifieDate INT(14);#����
ALTER TABLE auth MODIFY COLUMN ModifieDate TIMESTAMP(14) DEFAULT current_timestamp;#Ĭ��ֵ�����Ǻ���
ALTER TABLE auth CHANGE COLUMN Modifie_ID ModifieID INT(11);

ALTER TABLE auth ALTER COLUMN ModifieDate TIMESTAMP DEFAULT current_timestamp;
INSERT INTO auth(role,status,`describe`,ModifieDate,ModifieID) VALUES('root',1,'����','USE1',11);
INSERT INTO auth(role,status) VALUES('root',1);
INSERT INTO auth(role,status) VALUES('root',1);


��̨Ȩ���б�������������
	CREATE TABLE role (ID INT(11)NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "����",Name VARCHAR(20) DEFAULT '' COMMENT"����",Url VARCHAR(255) DEFAULT ''COMMENT"·��",Pid INT(11) NOT NULL DEFAULT 0,TYPE TINYINT(1) DEFAULT 0 COMMENT"���� 0�����˵���1 button",Icon VARCHAR(10) DEFAULT '' COMMENT"ͼ��",Status TINYINT(1) COMMENT "0����1����",ModifieDate DATETIME DEFAULT "1900 01 01 01:01:01",ModifieID INT(11) DEFAULT 0)ENGINE INNODB CHARSET utf8;
	ALTER TABLE role MODIFY Status TINYINT(1) DEFAULT 0 COMMENT"0����1����";
	ALTER TABLE role ADD `Sort` INT(11) NOT NULL AUTO_INCREMENT  #һ�ű�ֻ��һ���ֶ�����
	
Ȩ�޽�ɫ������
	CREATE TABLE role_auth(ID INT(11) UNSIGNED AUTO_INCREMENT PRIMARY KEY,AuthID INT(11) UNSIGNED NOT NULL ,RoleID INT(11) UNSIGNED NOT NULL)ENGINE=	INNODB DEFAULT CHARSET=utf8;
	
	INSERT INTO role(Name,Url,Pid,`Type`,Icon,Status,ModifieDate,ModifieID,Sort) VALUES('��Ա����','Admin/User/index',0,0,'sdas',1,NOW(),1,1);
	INSERT INTO role(Name,Url,Pid,`Type`,Icon,Status,ModifieDate,ModifieID,Sort) VALUES('Ȩ�޹���','Admin/auth/index',0,0,'sdas',1,NOW(),1,1);
	INSERT INTO role(Name,Url,Pid,`Type`,Icon,Status,ModifieDate,ModifieID,Sort) VALUES('���ݹ���','Admin/Content/index',0,0,'sdas',1,NOW(),1,1);
	
	INSERT INTO role(Name,Url,Pid,`Type`,Icon,Status,ModifieDate,ModifieID,Sort) VALUES('��ַ����','Admin/Address/index',7,0,'sdas',1,NOW(),1,1);
	INSERT INTO role(Name,Url,Pid,`Type`,Icon,Status,ModifieDate,ModifieID,Sort) VALUES('����','',0,0,'sdas',1,NOW(),1,1);
	INSERT INTO role(Name,Url,Pid,`Type`,Icon,Status,ModifieDate,ModifieID,Sort) VALUES('����Ա�б�','Admin/Adm/index',8,0,'sdas',1,NOW(),1,1);
	
	INSERT INTO role(Name,Url,Pid,`Type`,Icon,Status,ModifieDate,ModifieID,Sort) VALUES('��Ա�б�','Admin/User/list',7,0,'sdas',1,NOW(),1,1);
	INSERT INTO role(Name,Url,Pid,`Type`,Icon,Status,ModifieDate,ModifieID,Sort) VALUES('Ȩ���б�','Admin/Role/index',8,0,'sdas',1,NOW(),1,1);
	
	INSERT INTO role(Name,Url,Pid,`Type`,Icon,Status,ModifieDate,ModifieID,Sort) VALUES('��Ա����','Admin/User/update',13,1,'sdas',1,NOW(),1,1);
	INSERT INTO role(Name,Url,Pid,`Type`,Icon,Status,ModifieDate,ModifieID,Sort) VALUES('��Աɾ��','Admin/User/delete',13,1,'sdas',1,NOW(),1,1);
	
	INSERT INTO role(Name,Url,Pid,`Type`,Icon,Status,ModifieDate,ModifieID,Sort) VALUES('��ַ����','Admin/Address/update',10,1,'sdas',1,NOW(),1,1);
	INSERT INTO role(Name,Url,Pid,`Type`,Icon,Status,ModifieDate,ModifieID,Sort) VALUES('��ַɾ��','Admin/Address/delete',10,1,'sdas',1,NOW(),1,1);
	
	INSERT INTO role(Name,Url,Pid,`Type`,Icon,Status,ModifieDate,ModifieID,Sort) VALUES('����Ա����','Admin/Adm/update',12,1,'sdas',1,NOW(),1,1);
	INSERT INTO role(Name,Url,Pid,`Type`,Icon,Status,ModifieDate,ModifieID,Sort) VALUES('����Աɾ��','Admin/Adm/delete',12,1,'sdas',1,NOW(),1,1);
	
	INSERT INTO role(Name,Url,Pid,`Type`,Icon,Status,ModifieDate,ModifieID,Sort) VALUES('Ȩ�޸���','Admin/Role/update',14,1,'sdas',1,NOW(),1,1);
	INSERT INTO role(Name,Url,Pid,`Type`,Icon,Status,ModifieDate,ModifieID,Sort) VALUES('Ȩ��ɾ��','Admin/Role/delete',14,1,'sdas',1,NOW(),1,1);
	
	INSERT INTO role_auth(AuthID,RoleID) VALUES(1,7);

����Ա��
		CREATE TABLE adm(ID INT(11) UNSIGNED AUTO_INCREMENT PRIMARY KEY,Name VARCHAR(20) DEFAULT"",Pwd VARCHAR(100) DEFAULT"",`Describe` VARCHAR(255) DEFAULT "",AuthID INT(11) DEFAULT 0,Status TINYINT(1) DEFAULT 0 COMMENT"�Ƿ�����0������1����", ModifieDate DATETIME DEFAULT "1900-01-01 01:01:01",ModifieID INT(11) DEFAULT 0 ) ENGINE=INNODB DEFAULT CHARSET=utf8;
		ALTER TABLE adm CHANGE Name VARCHAR(100) NOT NULL; 
		ALTER TABLE adm ADD UNIQUE(Name);
		INSERT INTO adm(Name,Pwd,`Describe`,AuthID,Status,ModifieDate,ModifieID) VALUES('adm',PASSWORD('123456'),'����',1,1,NOW(),1);
	
	
	
	
	
