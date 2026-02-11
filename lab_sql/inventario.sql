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
CREATE TABLE equipos (
    id_equipo SERIAL PRIMARY KEY,
    nombre_equipo VARCHAR(50) NOT NULL,
    tipo VARCHAR(20), 
    estado VARCHAR(20) DEFAULT 'OPERATIVO', 
    fecha_alta TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO equipos (nombre_equipo, tipo) VALUES ('SRV-BRUC-01', 'Servidor');
INSERT INTO equipos (nombre_equipo, tipo) VALUES ('PC-YERAI-PRO', 'Workstation');

CREATE OR REPLACE FUNCTION enviar_a_mantenimiento(p_id INTEGER) 
RETURNS TEXT AS $$
BEGIN
    UPDATE equipos 
    SET estado = 'MANTENIMIENTO' 
    WHERE id_equipo = p_id;

    RETURN 'El equipo ' || p_id || ' ahora está en el taller.';
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION check_borrado_equipo()
RETURNS TRIGGER AS $$
BEGIN
    IF OLD.estado = 'OPERATIVO' THEN
        RAISE EXCEPTION 'No puedes borrar un equipo que está funcionando, cámbiale el estado primero.';
    END IF;
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tr_evitar_borrado
BEFORE DELETE ON equipos
FOR EACH ROW
EXECUTE FUNCTION check_borrado_equipo();