USE controledetrafego;
-- Transações com COMMIT -- 
SET autocommit = FALSE;
START TRANSACTION; 
INSERT INTO controledetrafego.people VALUES    (NULL,"Roberta Maria", "07112717788","112342515356351","1986-09-24");
SET @pessoa_id := (SELECT last_insert_id());
INSERT INTO controledetrafego.passenger VALUES ("124242424242",1,"2023-12-01",@pessoa_id);
COMMIT;

START TRANSACTION;
    INSERT INTO controledetrafego.company (cnpj, company_name)
        VALUES ('88.879.865/0001-72', 'Delta');
COMMIT;

START TRANSACTION; 
INSERT INTO controledetrafego.route VALUES (NULL, "Brasil", "Angola", "12:30", "Curitiba", "Luanda");
SET @route_id := (SELECT last_insert_id());
INSERT INTO controledetrafego.company VALUES (NULL,"20202020200000000000","GOL");
SET @company_id := (SELECT last_insert_id());
INSERT INTO controledetrafego.plane VALUES (NULL, "Boeing 737","53.3476","59.6136","22.000",@company_id);
SET @plane_id := (SELECT last_insert_id());
INSERT INTO controledetrafego.trip VALUES (NULL, "2023-11-23 12:10:00",0,"ON TIME", "2023-11-23","G2",@route_id,@plane_id,@company_id);
COMMIT;

START TRANSACTION;
INSERT INTO controledetrafego.route (country_departure, country_arrival, expected_time, city_departure, city_arrival)
	VALUES ('Brasil', 'Ilha de Pascoa', '17 Horas', 'Manaus', 'Ilha de Pascoa');
SELECT * FROM controledetrafego.route;
COMMIT;


-- Transações com ROLLBACK -- 
START TRANSACTION;
    INSERT INTO controledetrafego.nationality (country_name, continent) 
        VALUES ('Australia', 'Oceania');
    SELECT * FROM controledetrafego.nationality;
ROLLBACK;

START TRANSACTION;
    INSERT INTO controledetrafego.people(person_name, cpf, rg, birth_date)
        VALUES ('Eduardo', '00011100011','2222222222222', '2004-04-13');
    SELECT * FROM controledetrafego.people;
ROLLBACK;

INSERT INTO controledetrafego.contact(phone, email, people_id, company_id) 
        VALUES ('1699753134', 'Eduardo@localhost', @pessoa_id, @compania_id);
    SET @pessoa_id := (SELECT last_insert_id());
    SET @compania_id := (SELECT last_insert_id());
    SELECT * FROM controledetrafego.contact;
ROLLBACK;

START TRANSACTION;
    INSERT INTO controledetrafego.people VALUES (NULL, 'Victoria', '37834154999', '343266999', '2004-07-23');
    SELECT * FROM controledetrafego.people AS p
    JOIN controledetrafego.employee AS e ON p.id = e.people_id;
ROLLBACK;


-- Transações com SAVEPOINT -- 
START TRANSACTION;
SAVEPOINT Save;
INSERT INTO controledetrafego.maintenance (plane_id, employee_id, maintenance_date) VALUES (3, 6, '2023-12-01');
SELECT
    p.model
FROM
    Plane AS p
JOIN
    Maintenance AS m ON m.plane_id = p.id
WHERE
    m.plane_id = 3
GROUP BY
    p.model;
ROLLBACK TO SAVEPOINT Save;
COMMIT;

START TRANSACTION;
SAVEPOINT insert_route;
INSERT INTO controledetrafego.route VALUES (NULL, "Brasil", "Angola", "12:30", "Curitiba", "Luanda");
SET @route_id := (SELECT last_insert_id());
SAVEPOINT insert_company;
INSERT INTO controledetrafego.company VALUES (NULL,"20202020200000000000","GOL");
SET @company_id := (SELECT last_insert_id());
SAVEPOINT insert_plane;
INSERT INTO controledetrafego.plane VALUES (NULL, "Boeing 737","53.3476","59.6136","22.000",@company_id);
SET @plane_id := (SELECT last_insert_id());
SAVEPOINT insert_trip;
INSERT INTO controledetrafego.trip VALUES (NULL, "2023-11-23 12:10:00",0,"ON TIME", "2023-11-23","G2",@route_id,@plane_id,@company_id);
SET @trip_id := (SELECT last_insert_id());
ROLLBACK TO SAVEPOINT insert_trip;
ROLLBACK TO SAVEPOINT insert_plane;
ROLLBACK TO SAVEPOINT insert_company;
ROLLBACK TO SAVEPOINT insert_route;