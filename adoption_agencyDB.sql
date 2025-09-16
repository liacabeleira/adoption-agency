CREATE DATABASE adoption_agencyDB;

USE adoption_agencyDB;

DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (

		id_user			INTEGER PRIMARY KEY AUTO_INCREMENT,
        firstname		VARCHAR(250) NOT NULL,
        surname			VARCHAR(250) NOT NULL,
        email			VARCHAR(50)  NOT NULL UNIQUE,
        `password`		CHAR(64) NOT NULL,
        address			VARCHAR(100) NOT NULL,
        zip_code		VARCHAR(10) NOT NULL,
        city			VARCHAR(30) NOT NULL,
        country			VARCHAR(30) NOT NULL DEFAULT 'Portugal',
        phone_number	VARCHAR(15),
		`role`          VARCHAR(10) NOT NULL DEFAULT 'user' CHECK (role IN ('user', 'admin')),
        status_user     VARCHAR(15) DEFAULT 'Active' CHECK (status_user IN ('Active', 'Inactive')),
        failed_attempts INT DEFAULT 0
);

-- trigger para validar email
DELIMITER //
DROP TRIGGER IF EXISTS val_email_user//
CREATE TRIGGER val_email_user
BEFORE INSERT ON `user`
FOR EACH ROW
BEGIN
DECLARE email_invalid CONDITION FOR SQLSTATE '45002';
    IF NEW.Email NOT RLIKE "[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?" THEN
        SIGNAL email_invalid
        SET MESSAGE_TEXT = 'Invalid email format!';
    END IF;
END //
DELIMITER ;

-- função para validar password
DELIMITER //
DROP FUNCTION IF EXISTS verify_password;
CREATE FUNCTION verify_password (password CHAR(64))
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE password_valid BOOLEAN;

    IF CHAR_LENGTH(`password`) < 8 OR CHAR_LENGTH(`password`) > 50 
    OR NOT `password` REGEXP '[0-9]' 
    OR NOT `password` REGEXP '[a-z]' 
    OR NOT `password` REGEXP '[A-Z]' 
    OR NOT `password` REGEXP '[!$#?%]' 
    THEN
        RETURN FALSE;
    END IF;

    RETURN TRUE;
END//
DELIMITER ;

-- trigger para hashear a password se for válida
DELIMITER //
DROP TRIGGER IF EXISTS val_password_user//
CREATE TRIGGER val_password_user
BEFORE INSERT ON `user`
FOR EACH ROW
BEGIN
    DECLARE password_invalid_user CONDITION FOR SQLSTATE '45003';

    IF NOT verify_password(NEW.`password`) THEN
        SIGNAL password_invalid_user
        SET MESSAGE_TEXT = 'Password must contain one number, one lowercase letter, one uppercase letter, and one special symbol (!, $, #, ?, %)';
    END IF;

    SET NEW.`password` = SHA2(NEW.`password`, 256);
END//
DELIMITER ;

-- trigger para validar o update de password
DELIMITER //
DROP TRIGGER IF EXISTS val_password_user_update//
CREATE TRIGGER val_password_user_update
BEFORE UPDATE ON `user`
FOR EACH ROW
BEGIN
    DECLARE password_invalid_user CONDITION FOR SQLSTATE '45003';

    -- Verifica se a senha está a ser alterada
    IF NEW.`password` != OLD.`password` THEN
        -- Valida a força da nova senha
        IF NOT verify_password(NEW.`password`) THEN
            SIGNAL password_invalid_user
            SET MESSAGE_TEXT = 'Your new password is not strong enough';
        END IF;

        -- Aplica o hash SHA2 somente na nova senha
        SET NEW.`password` = SHA2(NEW.`password`, 256);
    END IF;
END//
DELIMITER ;

-- trigger para validar nº de telefone
DELIMITER //
DROP TRIGGER IF EXISTS val_phone_number_user//
CREATE TRIGGER val_phone_number_user
BEFORE INSERT ON `user`
FOR EACH ROW
BEGIN
	DECLARE phone_number_invalid_user CONDITION FOR SQLSTATE '45004';
    DECLARE phone_number_valid_user BOOLEAN;
    
    IF CHAR_LENGTH(NEW.phone_number) < 6 OR CHAR_LENGTH(NEW.phone_number) > 15 THEN
        SIGNAL phone_number_invalid_user
        SET MESSAGE_TEXT = 'Phone number must have 6 to 15 numbers';
    END IF;
    
    SET phone_number_valid_user = NEW.phone_number REGEXP '[0-9]';
    
    IF NOT phone_number_valid_user THEN
        SIGNAL phone_number_invalid_user
        SET MESSAGE_TEXT = 'Phone number must have 6 to 15 numbers';
	END IF;
END//
DELIMITER ;

DROP TABLE IF EXISTS species;
CREATE TABLE species (
    id_species    INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
    name_species  VARCHAR(50) NOT NULL UNIQUE
);

INSERT INTO species (id_species, name_species) VALUES 
(1, 'Donkey'),
(2, 'Guinea Pig'),
(3, 'Cat'),
(4, 'Parrot'),
(5, 'Rat'),
(6, 'Goose'),
(7, 'Fish'),
(8, 'Dog'),
(9, 'Hamster'),
(10, 'Pig'),
(11, 'Horse'),
(12, 'Ferret'),
(13, 'Iguana'),
(14, 'Chicken'),
(15, 'Rabbit');

DROP TABLE IF EXISTS animals;
CREATE TABLE animals (
    id_animal          INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
    name_animal        VARCHAR(50) NOT NULL,
    gender			   VARCHAR(10) NOT NULL CHECK(gender IN('Male', 'Female')),
    status_animal      VARCHAR(15) DEFAULT 'Available' CHECK (status_animal IN ('Available', 'Adopted')),
    photo        	   VARCHAR(255),
    id_species     	   INTEGER NOT NULL,
    id_user			   INTEGER,
    
	FOREIGN KEY (id_species) REFERENCES species(id_species) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (id_user) REFERENCES `user`(id_user) ON DELETE SET NULL ON UPDATE CASCADE
);

INSERT INTO animals (id_animal, name_animal, id_species, gender, status_animal, photo)
VALUES (1, 'Jeremias', 1, 'Male', 'Available', 'images/thumbs/donkey.jpg'),
		(2, 'Alfredo', 2, 'Male','Available', 'images/thumbs/guinea.png'),
        (3, 'Mimi', 3, 'Female', 'Available', 'images/thumbs/cat.jpg'),
        (4, 'Bonnie', 4, 'Female','Available', 'images/thumbs/parrot.jpg'),
        (5, 'Mickey', 5, 'Male', 'Available', 'images/thumbs/rat.jpg'),
        (6, 'Galak', 6, 'Male', 'Available', 'images/thumbs/goose.jpg'),
        (7, 'Filete', 7, 'Male', 'Available', 'images/thumbs/fish.jpg'),
        (8, 'Jasper', 8, 'Male', 'Available', 'images/thumbs/dog.jpg');
 
 -- tabelas para as tentativas de login, bem sucedidas e falhadas
CREATE TABLE login_attempts (
    id_attempt		INT AUTO_INCREMENT PRIMARY KEY,
    id_user 		INT NOT NULL,
    attempt_time 	TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    success 		BOOLEAN NOT NULL,
    
    FOREIGN KEY (id_user) REFERENCES user(id_user)
);

-- trigger para incrementar as tentativas de login falhadas e inactivar a conta após 5 vezes
DELIMITER //
CREATE TRIGGER after_failed_login
AFTER INSERT ON login_attempts
FOR EACH ROW
BEGIN
    IF NEW.success = 0 THEN
        -- Incrementa failed_attempts na tabela user
        UPDATE user
        SET failed_attempts = failed_attempts + 1
        WHERE id_user = NEW.id_user;
        
        -- Verifica se failed_attempts atingiu 5
        IF (SELECT failed_attempts FROM user WHERE id_user = NEW.id_user) >= 5 THEN
            UPDATE user
            SET status_user = 'Inactive'
            WHERE id_user = NEW.id_user;
        END IF;
    END IF;
END//
DELIMITER ;

-- trigger para pôr a zeros as tentativas de login falhadas
DELIMITER //
CREATE TRIGGER after_successful_login
AFTER INSERT ON login_attempts
FOR EACH ROW
BEGIN
    IF NEW.success = 1 THEN
        -- Reseta o contador de tentativas falhadas
        UPDATE user
        SET failed_attempts = 0
        WHERE id_user = NEW.id_user;
    END IF;
END//
DELIMITER ;

DROP TABLE IF EXISTS adoption_request;
CREATE TABLE adoption_request (
	id_request		INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
    request_date	TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id_user			INTEGER NOT NULL,
    id_animal		INTEGER NOT NULL,
    status_request  ENUM('Pending', 'Approved', 'Rejected') DEFAULT 'Pending',
    
    FOREIGN KEY (id_user) REFERENCES `user`(id_user) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_animal) REFERENCES animals(id_animal) ON DELETE RESTRICT ON UPDATE CASCADE,
	 UNIQUE (id_user, id_animal)
);

-- tabela de histórico de passwords de cada user
CREATE TABLE password_history (
    id_history     INTEGER PRIMARY KEY AUTO_INCREMENT,
    id_user        INTEGER NOT NULL,
    old_password   CHAR(64) NOT NULL,
    change_date    TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (id_user) REFERENCES user(id_user) ON DELETE CASCADE ON UPDATE CASCADE
);

-- trigger para inserir a password em password_history quando se insere novo utilizador
DELIMITER //
CREATE TRIGGER after_user_insert
AFTER INSERT ON user
FOR EACH ROW
BEGIN
    INSERT INTO password_history (id_user, old_password)
    VALUES (NEW.id_user, NEW.password);
END;
//
DELIMITER ;

-- trigger para inserir a nova password em password_history quando há update da password
DELIMITER //
CREATE TRIGGER after_password_update
AFTER UPDATE ON user
FOR EACH ROW
BEGIN
    -- Verificar se a password foi alterada
    IF NOT (OLD.password <=> NEW.password) THEN
        -- Inserir a nova password na tabela password_history
        INSERT INTO password_history (id_user, old_password)
        VALUES (NEW.id_user, NEW.password);
    END IF;
END;
//
DELIMITER ;

CREATE TABLE admin_logs (
    id_log INT AUTO_INCREMENT PRIMARY KEY,
    id_user INT NOT NULL,
    action VARCHAR(255) NOT NULL,
    action_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (id_user) REFERENCES user(id_user)
);

INSERT INTO `user` (id_user, firstname, surname, email, `password`, address, zip_code, city, country, phone_number, `role`)
VALUES (1, 'Lia', 'Costa', 'lia@gmail.com', '12345Abcde%', 'Rua das Flores', 1500-018, 'Lisboa', 'Portugal', 911234567, 'admin');

INSERT INTO `user` (id_user, firstname, surname, email, `password`, address, zip_code, city, country, phone_number, `role`)
VALUES (2, 'Alberto', 'Almeida', 'albertoalmeida@gmail.com', 'novaSenha123!', 'Rua das Tulipas', 1500-018, 'Lisboa', 'Portugal', 911234567, 'user');




















