/* CONSULTAS */
#PAIS QUE MAIS RECEBEU
SELECT
    r.country_arrival,
    COUNT(*) AS `Quantidade que recebeu`
FROM
    Route AS r
JOIN
    Trip AS t ON t.route_id = r.id
JOIN
    passenger_has_trip AS pht ON pht.trip_id = t.id
JOIN
    Passenger AS p ON pht.people_id = p.people_id
GROUP BY
    r.country_arrival
ORDER BY
    `Quantidade que recebeu` DESC
LIMIT 1;

#PAIS QUE MAIS EXPORTOU
SELECT
    r.country_departure,
    COUNT(*) AS `Quantidade que exportou`
FROM
    Route AS r
JOIN
    Trip AS t ON t.route_id = r.id
JOIN
    passenger_has_trip AS pht ON pht.trip_id = t.id
JOIN
    Passenger AS p ON pht.people_id = p.people_id
GROUP BY
    r.country_departure
ORDER BY
    `Quantidade que exportou` DESC
LIMIT 1;

#CIDADE BRASILEIRA QUE MAIS RECEBEU
SELECT
    r.city_arrival,
    COUNT(*) AS `Quantidade que recebeu`
FROM
    Route AS r
JOIN
    Trip AS t ON t.route_id = r.id
JOIN
    passenger_has_trip AS pht ON pht.trip_id = t.id
JOIN
    Passenger AS p ON pht.people_id = p.people_id
WHERE
    r.country_arrival = 'Brasil'
GROUP BY
    r.city_arrival
ORDER BY
    `Quantidade que recebeu` DESC
LIMIT 1;

#CIDADE BRASILEIRA QUE MAIS EXPORTOU
SELECT
    r.city_departure,
    COUNT(*) AS `Quantidade que exportou`
FROM
    Route AS r
JOIN
    Trip AS t ON t.route_id = r.id
JOIN
    passenger_has_trip AS pht ON pht.trip_id = t.id
JOIN
    Passenger AS p ON pht.people_id = p.people_id
WHERE
    r.country_departure = 'Brasil'
GROUP BY
    r.city_departure
ORDER BY
    `Quantidade que exportou` DESC
LIMIT 1;

#CAPITAL QUE MAIS VISITADA
SELECT
    r.city_arrival,
    COUNT(*) AS `Quantidade que recebeu`
FROM
    Route AS r
JOIN
    Trip AS t ON t.route_id = r.id
JOIN
    passenger_has_trip AS pht ON pht.trip_id = t.id
JOIN
    Passenger AS p ON pht.people_id = p.people_id
WHERE
    r.city_arrival IN ('Curitiba', 'Paris', 'Buenos Aires', 'Caracas')
GROUP BY
    r.city_arrival
ORDER BY
    `Quantidade que recebeu` DESC
LIMIT 1;

#CIDADE EXTRANGEIRA QUE MAIS EXPORTOU
SELECT
    r.city_departure,
    COUNT(*) AS `Quantidade que exportou`
FROM
    Route AS r
JOIN
    Trip AS t ON t.route_id = r.id
JOIN
    passenger_has_trip AS pht ON pht.trip_id = t.id
JOIN
    Passenger AS p ON pht.people_id = p.people_id
WHERE
    r.country_departure != 'Brasil' 
GROUP BY
    r.city_departure
ORDER BY
    `Quantidade que exportou` DESC
LIMIT 1;

#CONTINENTE QUE MAIS VIAJOU
SELECT
    n.continent,
    COUNT(*) AS `Quantidade de viagens`
FROM
    nationality AS n
JOIN
    people_has_nationality AS phn ON n.id = phn.nationality_id
JOIN
    passenger_has_trip AS pht ON phn.people_id = pht.people_id
JOIN
    Trip AS t ON pht.trip_id = t.id
GROUP BY
    n.continent
ORDER BY
    `Quantidade de viagens` DESC
LIMIT 1;

#PESSOA QUE MAIS VIAJOU
 SELECT
	p.id,
    p.person_name,
    COUNT(*) AS `Quantidade de viajens`
FROM 
	People AS p
JOIN 
	passenger AS pa ON p.id = pa.people_id
JOIN 
	employee as e on p.id = e.people_id
JOIN
	passenger_has_trip as phs on phs.people_id = p.id
JOIN 
	employee_has_trip as eht on eht.people_id = p.id
GROUP  BY 
	p.id, p.person_name
ORDER BY 
	`Quantidade de viajens` DESC;


#NACIONALIDADE QUE MAIS VIAJOU
SELECT 
    n.country_name,
    COUNT(*) AS `Quantidade de viagens`
FROM
    Nationality AS n
JOIN
    people_has_nationality AS phn ON n.id = phn.nationality_id
JOIN
    passenger_has_trip AS pht ON phn.people_id = pht.people_id
JOIN
    Trip AS t ON pht.trip_id = t.id
GROUP BY
    n.country_name
ORDER BY
    `Quantidade de viagens` DESC
LIMIT 1;

#NACIONALIDADE QUE MENOS VIAJOU
SELECT
    n.country_name,
    COUNT(*) AS `Quantidade de viagens`
FROM
    Nationality AS n
JOIN
    people_has_nationality AS phn ON n.id = phn.nationality_id
JOIN
    passenger_has_trip AS pht ON phn.people_id = pht.people_id
JOIN
    Trip AS t ON pht.trip_id = t.id
GROUP BY
    n.country_name
ORDER BY
    `Quantidade de viagens` ASC
LIMIT 1;

#AVIÃO QUE MAIS VIAJOU
SELECT
    p.model AS model,
    COUNT(t.id) AS `Quantidade de viagens`
FROM
    Plane AS p
JOIN
    Trip AS t ON p.id = t.plane_id
GROUP BY
    model
ORDER BY
    `Quantidade de viagens` DESC
LIMIT 1;

#QUANTIDADE DE AVIÕES
SELECT COUNT(id) AS `Total de aviões` FROM Plane;

#AVIÕES QUE MENOS VIAJARAM
SELECT
    p.model AS model,
    COUNT(t.id) AS `Quantidade de viagens`
FROM
    Plane AS p
JOIN
    Trip AS t ON p.id = t.plane_id
GROUP BY
    model
ORDER BY
    `Quantidade de viagens` ASC
LIMIT 1;

#TEMPO DE CADA VIAJEM
SELECT
    t.id AS Trip_id,
    r.expected_time AS Tempo_de_viagem
FROM
    Trip AS t
JOIN
    Route AS r ON t.route_id = r.id;

#EMPREGADOS QUE MAIS VIAJARAM
SELECT
    p.id AS People_id,
    p.person_name AS Nome_da_Pessoa,
    COUNT(*) AS `Quantidade de viagens`
FROM
    People AS p
JOIN
    Employee AS e ON p.id = e.people_id
JOIN
    employee_has_trip AS eht ON e.people_id = eht.people_id
GROUP BY
    e.people_id
ORDER BY
    `Quantidade de viagens` DESC;


#TOTAL DE VIAJENS
SELECT COUNT(id) AS `Total de viagens` FROM Trip;

#COMPANHIA QUE MAIS FEZ VIAJENS
SELECT
    c.company_name AS Nome_da_Companhia,
    COUNT(t.id) AS `Quantidade de viagens`
FROM
    Company AS c
JOIN
    Trip AS t ON c.id = t.company_id
GROUP BY
    c.company_name
ORDER BY
    `Quantidade de viagens` DESC
LIMIT 1;

#AVIÃO QUE ESTIVERAM EM MANUTENÇÃO
SELECT 
    Plane.id,
    Plane.model,
    COUNT(Maintenance.plane_id) AS 'Quantidade de manutenções'
FROM 
    Plane
LEFT JOIN 
    Maintenance ON Plane.id = Maintenance.plane_id
GROUP BY 
    Plane.id
ORDER BY 
    COUNT(Maintenance.plane_id) ASC;

#PILOTOS QUE MAIS TIVERAM HORAS DE VOO
SELECT 
    Employee.people_id,
    People.person_name,
    SUM(Route.expected_time) AS 'Quantidade de Horas Viajadas'
FROM 
    Employee
JOIN 
    People ON People.id = Employee.people_id
JOIN 
    employee_has_trip ON Employee.people_id = employee_has_trip.people_id
JOIN 
    Trip ON Trip.id = employee_has_trip.trip_id
JOIN 
    Route ON Trip.route_id = Route.id
WHERE 
    Employee.thefunction = 'PILOTO'
GROUP BY 
    Employee.people_id
ORDER BY 
    SUM(Route.expected_time) DESC;
    
#TOTAL DE PESSOAS QUE VIAJARAM 
SELECT COUNT(*) AS 'Total de pessoas'
FROM People
JOIN passenger_has_trip ON People.id = passenger_has_trip.people_id;


/* Views */

create view viagens (trip_id, trip_scheduled, country_departure,city_daparture, country_arrival, city_arrival, plane_id, plane_model, company_id, company_name )
as select t.id, t.scheduled, r.country_departure, r.city_departure, r.country_arrival, r.city_arrival, p.id, p.model, co.id, co.company_name
from trip t
inner join route as r on r.id = t.id
inner join plane as p on p.id = t.plane_id
inner join company as co on co.id = p.company_id;
select * from viagens;

#Contatos das pessoas
create view contatos_pessoas 
as select p.id, p.person_name, ct.phone, ct.email
from people p
inner join contact as ct on ct.people_id = p.id;
select * from contatos_pessoas;


CREATE VIEW avioes_controle AS
SELECT 
    t.id AS trip_id,
    t.scheduled, 
    t.trip_status,
    r.country_departure AS departure_country, 
    r.city_departure AS departure_city, 
    r.country_arrival AS arrival_country, 
    r.city_arrival AS arrival_city, 
    p.id AS plane_id, 
    p.model, 
    p.coord_X, 
    p.coord_Y, 
    p.coord_Z, 
    co.id AS company_id, 
    co.company_name
FROM trip AS t
INNER JOIN route AS r ON r.id = t.route_id
INNER JOIN plane AS p ON p.id = t.plane_id
INNER JOIN company AS co ON co.id = p.company_id;
Select* from avioes_controle;