INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_vagos', 'Vagos', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_vagos', 'Vagos', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES
	('society_vagos', 'Vagos', 1)
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('vagos',0,'petit','Petit',20,'', ''),
	('vagos',1,'gangster','Gangster',40,'', ''),
	('vagos',2,'brasdroit','Bras Droit',60,'', ''),
	('vagos',3,'boss','OG',80,'', '')
;

INSERT INTO `jobs` (name, label) VALUES
	('vagos','Vagos')
;