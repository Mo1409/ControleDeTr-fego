/* Procedure */

#Atualizar o Status de um Passageiro:
DELIMITER //
CREATE PROCEDURE UpdatePassengerStatus(IN new_passport_num VARCHAR(30), IN new_status TINYINT)
BEGIN
    UPDATE controledetrafego.passenger
    SET visa = new_status
    WHERE passport_num = new_passport_num;
    SELECT p.id, p.person_name, pa.visa, pa.passport_num FROM controledetrafego.passenger AS pa
    JOIN controledetrafego.people AS p ON p.id = pa.people_id;
END //
DELIMITER ;


#Registrar uma Nova Viagem:
DELIMITER //
CREATE PROCEDURE InsertNewTrip(IN scheduled DATETIME, IN delay TINYINT, IN trip_status VARCHAR(30), IN trip_date DATE, IN gate CHAR(3), IN route_id INT, IN plane_id INT, IN company_id INT)
BEGIN
    INSERT INTO controledetrafego.trip (scheduled, delay, trip_status, trip_date, gate, route_id, plane_id, company_id)
    VALUES (scheduled, delay, trip_status, trip_date, gate, route_id, plane_id, company_id);
    
    SELECT * FROM controledetrafego.trip AS t
    WHERE t.id = last_insert_id();
END //
DELIMITER ;


#Calcula a Idade de uma Pessoa:
DELIMITER //
CREATE PROCEDURE CalculateAge(IN birthdate DATE, OUT age INT)
BEGIN
    SET age = YEAR(CURDATE()) - YEAR(birthdate) - (DATE_FORMAT(CURDATE(), '%m%d') < DATE_FORMAT(birthdate, '%m%d'));
END //
DELIMITER ;

SET @age = NULL;
CALL CalculateAge('2002-10-11', @age);
SELECT @age;


/* Funções */

#Obter o Nome da Companhia de um Avião:
DELIMITER //
CREATE FUNCTION GetCompanyName(plane_id INT)
RETURNS VARCHAR(300)
DETERMINISTIC
BEGIN
    DECLARE company_name VARCHAR(300);
    SELECT c.company_name INTO company_name
    FROM controledetrafego.company AS c
    JOIN controledetrafego.plane AS p ON p.company_id = c.id
    WHERE p.id = plane_id;
    RETURN company_name;
END //
DELIMITER ;


#Calcular a Diferença de Dias entre Duas Datas:
DELIMITER //
CREATE FUNCTION CalculateDateDifference(date1 DATE, date2 DATE)
RETURNS INT
DETERMINISTIC
RETURN abs(DATEDIFF(date2, date1));
//
DELIMITER ;


#Obter o Nome do Continente de uma Nacionalidade:
DELIMITER //
CREATE FUNCTION GetContinentName(nationality_id INT)
RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN
    DECLARE continent_name VARCHAR(50);
    SELECT continent INTO continent_name
    FROM controledetrafego.nationality
    WHERE id = nationality_id;
    RETURN continent_name;
END //
DELIMITER ;


/*Triggers*/

# INSERT na tabela people_has_nacionality quanto for inserido uma pessoa na tabela people:
DELIMITER //
CREATE TRIGGER PeopleNacionality
AFTER INSERT ON people
FOR EACH ROW
BEGIN
    INSERT INTO people_has_nationality (people_id, nationality_id)
    VALUES (NEW.id, FLOOR(1 + RAND() * 6));
END //
DELIMITER ;


# UPDATE na coluna city_arrival da tabela route quanto for feito o update de um country_arrival:
DELIMITER //
CREATE TRIGGER update_trip_on_route_update
BEFORE UPDATE ON route
FOR EACH ROW
BEGIN
    IF NEW.country_arrival != OLD.country_arrival THEN
        SET NEW.city_arrival = 'AWAITING CONFIRMATION';
    END IF;
END //
DELIMITER ;


# DELETE na tabela trip quanto for feito o update de uma rota:
DELIMITER //
CREATE TRIGGER deletar_pessoa_employee
BEFORE DELETE ON controledetrafego.employee
FOR EACH ROW
BEGIN
    DELETE FROM employee_has_trip 
    WHERE people_id = OLD.people_id;
END //
DELIMITER ;
DELETE FROM controledetrafego.employee WHERE people_id = 3;