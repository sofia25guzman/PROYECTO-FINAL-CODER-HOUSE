USE mysql;
SHOW tables;
select * from user;

CREATE USER 'host1' identified by 'host1-123'; -- el usuario host1 tendrá permisos de solo lectura 
CREATE USER 'host2' identified by 'host2-123'; -- el usuario host2 tendrá permisos de lectura, inserción y modificación

-- asignamos permisos de sólo lectura sobre el host1
GRANT SELECT ON *.* to 'host1';

-- asignamos permisos de lectura, inserción y modificación sobre le host2
GRANT SELECT, INSERT, UPDATE ON  *.* to 'host2';

