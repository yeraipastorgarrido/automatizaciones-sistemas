CREATE DATABASE IF NOT EXISTS gestion_it;
USE gestion_it;


DROP TABLE IF EXISTS equipos;


CREATE TABLE equipos (
    id_equipo INT AUTO_INCREMENT PRIMARY KEY,
    nombre_equipo VARCHAR(50) NOT NULL,
    tipo VARCHAR(20),
    estado VARCHAR(20) DEFAULT 'OPERATIVO',
    fecha_alta TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO equipos (nombre_equipo, tipo) VALUES ('SRV-BRUC-01', 'Servidor');
INSERT INTO equipos (nombre_equipo, tipo) VALUES ('PC-YERAI-PRO', 'Workstation');
INSERT INTO equipos (nombre_equipo, tipo) VALUES ('LAP-ARIADNA-01', 'Laptop');

DELIMITER //

CREATE TRIGGER tr_evitar_borrado
BEFORE DELETE ON equipos
FOR EACH ROW
BEGIN
    IF OLD.estado = 'OPERATIVO' THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'No puedes borrar un equipo operativo. Cambia su estado primero.';
    END IF;
END//

DELIMITER ;