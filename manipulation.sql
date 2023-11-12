USE controledetrafego;

INSERT INTO controledetrafego.nationality (country_name, continent) 
VALUES ('Brasil', 'South America'),  ('Espanha', 'Europa'), ('Alemanha', 'Europa'), ('Italia', 'Europa'), ('Argentina', 'South America'),
('Japão', 'Ásia');

INSERT INTO controledetrafego.people (person_name, cpf, rg, birth_date) 
VALUES ('Gabriel', '37834154036', '343266532', '2004-07-06'), ('Vinicius', '72760264009', '475135520', '2005-09-13'),
('Mohamad', '88467652063', '321263005', '2004-09-14'), ('Isabella', '46651713000', '428699510', '2004-09-17'),
('Vitor', '24125800065', '369738597', '2004-02-15'), ('Luca', '21779161000', '236346933', '2004-05-26')  ;

INSERT INTO controledetrafego.route (country_departure, country_arrival, expected_time, city_departure, city_arrival) 
VALUES ('Brasil', 'Estados Unidos', '12 Horas', 'Manaus', 'Nova York'), 
('Estados Unidos', 'Brasil', '12 Horas', 'Nova York', 'Manaus'), 
('Argentina', 'França', '13 Horas', 'Buenos Aires', 'Paris'), 
('França', 'Argentina', '13 Horas', 'Paris', 'Buenos Aires'), 
('Brasil', 'Venezuela', '5 Horas', 'Manaus', 'Caracas'),
('Emirados Árabes Unidos','Israel','4 Horas','Dubai','Jerusalem');

INSERT INTO controledetrafego.company (cnpj, company_name)
VALUES ('77.889.865/0001-85', 'Latam'), ('59.189.224/0001-36', 'Gol'), 
('15.671.867/0001-46', 'Emirates'), ('21.497.585/0001-77', 'Azul'), 
('19.030.199/0001-29', 'Air France'), ('12.277.205/0001-06', 'Canada Express');

INSERT INTO controledetrafego.plane (model, coord_X, coord_Y, coord_Z, company_id) 
VALUES ('Airbus A220', '40.71145', '-74.01256', '1368', '1'), ('Airbus A380', '31.4421', '34.365053', '40000', '2'), 
('Boeing 707', '39.44420', '125.733590', '27000', '3'), ('Boeing 737', '7.406752', '7.826526', '30000', '4'), 
('Antonov An225 Mriya', '-25.431538', '-49.294847', '1000', '5'), ('Douglas DC-2', '24.759363', '-77.958384', '20000', '6');

INSERT INTO controledetrafego.employee(cnh,thefunction,people_id)
VALUES (3485078804,'LIMPEZA',1), (0745256722,'PILOTO',2),(5322842320,'AEROBORDO',3),
(2962373199,'PILOTO',4),(5552143234,'COPILOTO',5),(1650216761,'MANUTENCAO',6);

INSERT INTO controledetrafego.trip (scheduled, delay, trip_status, trip_date, gate, route_id, plane_id, company_id) VALUES 
('2023-05-25', 0, 'OK', '2023-05-25', '1', '1', '1', '1'),
('2023-12-12', 0, 'OK', '2023-12-12', '2', '2', '2', '2'),
('2023-11-13', 0, 'OK', '2023-11-13', '3', '3', '3', '3'),
('2023-03-04', 0, 'OK', '2023-03-04', '4', '4', '4', '4'),
('2023-01-25', 1, 'DELAY', '2023-01-26', '5', '5', '5', '5'),
('2023-11-09', 1, 'DELAY', '2023-11-10', '6', '6', '5', '6');

INSERT INTO Passenger (passport_num, visa, exp_date, people_id)
VALUES ('VQ718229', 1, '2028-02-17', 1),
('IR369175', 1, '2028-04-19', 2),
('LI371207', 1, '2028-01-31', 3),
('TK658144', 1, '2028-05-21', 4),
('QU340528', 0, '2020-10-31', 5),
('X1TA0179', 0, '2021-09-13', 6);

INSERT INTO maintenance (plane_id, employee_id, maintenance_date)
VALUES (1, 1, '2023-04-12'),
(2, 2, '2023-05-11'),
(3, 3, '2023-03-15'),
(5, 4, '2023-06-10'),
(5, 5, '2023-02-22'),
(6, 6, '2023-07-02');

INSERT INTO Contact (people_id, company_id, phone, email)
VALUES (1, NULL, '4187781848', 'Gabriel.Schneider@pucpr.edu.br'),
(2, NULL, '41995565859', 'vini.yama13@gmail.com'),
(NULL, 1, '1149331205', 'latam@latam.com'),
(NULL, 2, '1149553144', 'gol@gol.com'),
(4, NULL, '6999460287', 'isabellaberkembrock@pucpr.edu.br'),
(NULL, 3, '1154229908', 'flyemirates@emirates.com');

INSERT INTO passenger_has_trip (trip_id, people_id)
VALUES (1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6);

INSERT INTO employee_has_trip (trip_id, people_id)
VALUES (1, 1),
(2, 4),
(3, 3),
(4, 4),
(5, 5),
(6, 6);

INSERT INTO people_has_nationality (people_id, nationality_id)
VALUES (1, 1),
(2, 4),
(3, 3),
(4, 4),
(5, 5),
(6, 6);

UPDATE controledetrafego.nationality
SET country_name = 'China', continent = 'Ásia'
WHERE (nationality.id = 2);

update controledetrafego.employee 
set thefunction = "Manutenção" 
where (employee.people_id = 1);

update controledetrafego.trip 
set delay = true, gate = 8
where (trip.id = 1);

UPDATE controledetrafego.passenger
SET exp_date = "2028-02-18"
WHERE (passenger.people_id = 1);

UPDATE controledetrafego.people
SET person_name = "Victor Nicolittti"
WHERE (people.id = 5);


/*delete*/
DELETE FROM controledetrafego.people_has_nationality WHERE people_id = 1;
DELETE FROM controledetrafego.passenger_has_trip WHERE people_id = 1;
DELETE FROM controledetrafego.employee_has_trip WHERE trip_id = 5;
DELETE FROM controledetrafego.contact WHERE id = 1;
DELETE FROM controledetrafego.nationality WHERE id = 1;

