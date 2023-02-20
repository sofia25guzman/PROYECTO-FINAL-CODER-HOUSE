USE proyecto;
SET FOREIGN_KEY_CHECKS = 0;

INSERT INTO cliente
VALUES 
	('5524','0002-8803','graduado','soltero',58138),
	('2174', '0006-0773','graduado','soltero',46344),
    ('4141','0006-3551','graduado','union_libre',71613),
    ('6182','0006-3845','graduado','union_libre',26646),
    ('5324','0023-3921','doctorado','casado',58293),
    ('7446','0037-8120','master','union_libre',62513),
	('965','0039-0038','graduado','divorciado',55635),
    ('6177','0039-0222','doctorado','casado',33454),
    ('4855','0053-7201','doctorado','union_libre',30351),
    ('5899','0054-0002','doctorado','union_libre',50648)
    ;
    
INSERT INTO producto
VALUES
	('0002-8803','5524',1396),
    ('0006-0773','2174',5611),
    ('0006-3551','4141',3269),
    ('0006-3845','6182',8907),
    ('0023-3921','5324',4496),
    ('0037-8120','7446',3669),
    ('0039-0038','965',2737),
    ('0039-0222','6177',4322),
    ('0053-7201','4855',9919),
    ('0054-0002','5899',8756)
    ;
    
INSERT INTO compra
VALUES
	(null,'5524','0002-8803'),
    (null,'2174','0006-0773'),
    (null,'4141','0006-3551'),
    (null,'6182','0006-3845'),
    (null,'5324','0023-3921'),
    (null,'7446','0037-8120'),
    (null,'965','0039-0038'),
    (null,'6177','0039-0222'),
    (null,'4855','0053-7201'),
    (null,'5899','0054-0002')
    ;
   

INSERT INTO periodo
VALUES
	(null,'1','2014-09-08','2012-09-04'),
    (null,'2','2014-07-30','2013-03-08'),
    (null,'3','2015-02-02','2013-08-21'),
    (null,'4','2014-06-29','2012-02-10'),
    (null,'5','2014-05-13','2014-01-19'),
    (null,'6','2013-09-12','2013-02-09'),
    (null,'7','2015-05-26','2012-11-13'),
    (null,'8','2014-11-09','2013-05-08'),
    (null,'9','2014-08-27','2013-06-06'),
    (null,'10','2015-03-22','2014-03-13')
    ;
       
    INSERT INTO quejas
    VALUES
		(null,'0','0002-8803','5524'),
        (null,'1','0006-0773','2174'),
        (null,'0','0006-3551','4141'),
        (null,'0','0006-3845','6182'),
        (null,'1','0023-3921','5324'),
        (null,'1','0037-8120','7446'),
        (null,'0','0039-0038','965'),
        (null,'0','0039-0222','6177'),
        (null,'0','0053-7201','4855'),
        (null,'1','0054-0002','5899')
        ;
        
      INSERT INTO supermercado
    VALUES
		('A001','5524','0002-8803','0','1'),
        ('A002','2174','0006-0773','1','1'),
        ('A003','4141','0006-3551','1','1'),
        ('A004','6182','0006-3845','1','1'),
        ('A005','5324','0023-3921','0','0'),
        ('A006','7446','0037-8120','1','1'),
        ('A007','965','0039-0038','1','1'),
        ('A008','6177','0039-0222','1','0'),
        ('A009','4855','0053-7201','1','0'),
        ('A010','5899','0054-0002','1','0')
        ;
        
	INSERT INTO campaña
    VALUES
		(null,'0002-8803'),
        (null,'0006-0773'),
        (null,'0006-3551'),
        (null,'0006-3845'),
        (null,'0023-3921'),
        (null,'0037-8120'),
        (null,'0039-0038'),
        (null,'0053-7201'),
        (null,'0054-0002')
        ;
        

