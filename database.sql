-- CRIANDO BANCOS --
DROP DATABASE IF EXISTS  controledetrafego;

CREATE DATABASE IF NOT EXISTS controledetrafego;

USE controledetrafego;

-- CRIANDO AS TABELAS --
CREATE TABLE IF NOT EXISTS controledetrafego.nationality (
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    country_name VARCHAR(300) NOT NULL,
    continent VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS controledetrafego.people (
	id INT NOT NULL AUTO_INCREMENT,
    person_name VARCHAR(300) NOT NULL,
    cpf CHAR(11) NOT NULL UNIQUE,
    rg VARCHAR(15) NOT NULL,
    birth_date DATE NOT NULL,
   
    PRIMARY KEY(id)
);
    
CREATE TABLE IF NOT EXISTS controledetrafego.passenger (
    passport_num VARCHAR(30) NOT NULL,
    visa TINYINT NOT NULL,
    exp_date DATE NOT NULL,
    people_id INT NOT NULL,
    PRIMARY KEY(people_id),
    FOREIGN KEY (people_id) REFERENCES controledetrafego.people(id)
);

CREATE TABLE IF NOT EXISTS controledetrafego.employee (
    cnh VARCHAR(10) NOT NULL,
    thefunction VARCHAR(20) NOT NULL,
    people_id INT NOT NULL,
    PRIMARY KEY(people_id),
    FOREIGN KEY (people_id) REFERENCES controledetrafego.people(id)
);

CREATE TABLE IF NOT EXISTS controledetrafego.company (
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    cnpj VARCHAR(20) NOT NULL,
    company_name VARCHAR(300) NOT NULL
);

CREATE TABLE IF NOT EXISTS controledetrafego.route (
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    country_departure VARCHAR(45) NOT NULL,
    country_arrival VARCHAR(45) NOT NULL,
    expected_time VARCHAR(45) NOT NULL,
    city_departure VARCHAR(45) NOT NULL,
    city_arrival VARCHAR(45) NOT NULL
);

CREATE TABLE IF NOT EXISTS controledetrafego.plane (
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    model VARCHAR(50) NOT NULL,
    coord_X DOUBLE NOT NULL,
    coord_Y DOUBLE NOT NULL,
    coord_Z INT NOT NULL,
    company_id INT NOT NULL,
    FOREIGN KEY (company_id) REFERENCES controledetrafego.company(id)
);

CREATE TABLE IF NOT EXISTS controledetrafego.trip (
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    scheduled DATETIME NOT NULL,
    delay TINYINT NOT NULL,
    trip_status varchar(30) NOT NULL,
    trip_date DATE NOT NULL,
    gate CHAR(3) NOT NULL,
    route_id INT NOT NULL,
    plane_id INT NOT NULL,
    company_id INT NOT NULL,
    FOREIGN KEY (route_id) REFERENCES controledetrafego.route(id),
    FOREIGN KEY (plane_id) REFERENCES controledetrafego.plane(id),
    FOREIGN KEY (company_id) REFERENCES controledetrafego.company(id)
);
CREATE TABLE IF NOT EXISTS controledetrafego.passenger_has_trip(
	trip_id INT NOT NULL,
    people_id INT NOT NULL,
    PRIMARY KEY(trip_id, people_id),
    FOREIGN KEY(trip_id) REFERENCES controledetrafego.trip(id),
    FOREIGN KEY(people_id) REFERENCES controledetrafego.passenger(people_id)
    );
    
    CREATE TABLE IF NOT EXISTS controledetrafego.employee_has_trip(
	trip_id INT NOT NULL,
    people_id INT NOT NULL,
    PRIMARY KEY(trip_id, people_id),
    FOREIGN KEY(trip_id) REFERENCES controledetrafego.trip(id),
    FOREIGN KEY(people_id) REFERENCES controledetrafego.employee(people_id)
    );
    
    CREATE TABLE IF NOT EXISTS controledetrafego.people_has_nationality (
    people_id INT NOT NULL,
    nationality_id INT NOT NULL,
    FOREIGN KEY (people_id) REFERENCES controledetrafego.people(id),
    FOREIGN KEY (nationality_id) REFERENCES controledetrafego.nationality(id)
);

CREATE TABLE IF NOT EXISTS controledetrafego.contact (
    phone VARCHAR(20) NOT NULL,
    email VARCHAR(50) NOT NULL,
    id INT PRIMARY KEY AUTO_INCREMENT,
    people_id INT,
    company_id INT,
    FOREIGN KEY (company_id) REFERENCES controledetrafego.company(id),
    FOREIGN KEY (people_id) REFERENCES controledetrafego.people(id)
);
CREATE TABLE IF NOT EXISTS controledetrafego.maintenance(
	plane_id INT NOT NULL,
    employee_id INT NOT NULL,
    maintenance_date DATETIME NOT NULL
    );