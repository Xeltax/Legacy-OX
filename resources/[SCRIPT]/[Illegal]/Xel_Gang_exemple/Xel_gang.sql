

INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_ballas', 'Ballas', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES
	('society_ballas', 'Ballas', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_ballas', 'Ballas', 1)
;

INSERT INTO `jobs` (name, label) VALUES
	('ballas', 'Ballas')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('ballas',0,'petit','Petit Gangster',20,'{}','{}'),
	('ballas',1,'gangster','Gangster',40,'{}','{}'),
	('ballas',2,'gerant','Gérant',60,'{}','{}'),
	('ballas',3,'brasdroit','Bras Droit',85,'{}','{}'),
	('ballas',4,'boss','OG',100,'{}','{}')
;
