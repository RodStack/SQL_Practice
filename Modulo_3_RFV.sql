CREATE DATABASE Alke_Wallet

USE Alke_Wallet;

CREATE TABLE Moneda(
	currency_id INT PRIMARY KEY,
    currency_name VARCHAR(30),
    currency_symbol VARCHAR(10)
);

CREATE TABLE Usuario(
	user_id INT PRIMARY KEY,
    nombre VARCHAR(50),
    correo_electronico VARCHAR(50),
    contraseña VARCHAR(20),
    saldo FLOAT
);

CREATE TABLE Transaccion (
	transaction_id INT PRIMARY KEY,
    importe FLOAT,
    transaction_date DATE,
    sender_user_id INT,
    receiver_user_id INT,
    currency_id INT,
    FOREIGN KEY (sender_user_id) REFERENCES Usuario(user_id),
    FOREIGN KEY (receiver_user_id) REFERENCES Usuario(user_id),
    FOREIGN KEY (currency_id) REFERENCES Moneda(currency_id)
);

INSERT INTO Moneda (currency_id, currency_name, currency_symbol) VALUES
(1, 'Dólar Estadounidense', 'USD'),
(2, 'Euro', 'EUR'),
(3, 'Libra Esterlina', 'GBP');

INSERT INTO Usuario (user_id, nombre, correo_electronico, contraseña, saldo) VALUES
(1, 'Juan Pérez', 'juan@example.com', 'contraseña1', 1000.00),
(2, 'María López', 'maria@example.com', 'contraseña2', 500.00),
(3, 'Luis García', 'luis@example.com', 'contraseña3', 750.00),
(4, 'Ana Martínez', 'ana@example.com', 'contraseña4', 1200.00),
(5, 'Elena Rodríguez', 'elena@example.com', 'contraseña5', 900.00);

INSERT INTO Transaccion (transaction_id, importe, transaction_date, sender_user_id, receiver_user_id, currency_id) VALUES
(1, 50.00, '2024-03-27', 1, 2, 1),
(2, 100.00, '2024-03-27', 3, 1, 2),
(3, 25.00, '2024-03-28', 4, 3, 3),
(4, 75.00, '2024-03-28', 5, 2, 1),
(5, 200.00, '2024-03-29', 2, 4, 1),
(6, 150.00, '2024-03-29', 3, 5, 1),
(7, 50.00, '2024-03-30', 1, 4, 1),
(8, 100.00, '2024-03-30', 5, 1, 2),
(9, 75.00, '2024-03-31', 4, 2, 1),
(10, 125.00, '2024-03-31', 2, 3, 1);

-- Consulta para obtener el nombre de la moneda elegida por un
-- usuario específico
SELECT u.nombre, m.currency_name
FROM Usuario u
INNER JOIN Transaccion t ON u.user_id = t.sender_user_id 
INNER JOIN Moneda m ON m.currency_id = t.currency_id
WHERE u.nombre = "Juan Pérez";

-- Consulta para obtener todas las transacciones registradas
SELECT t.transaction_date, u.nombre, t.importe, m.currency_name
FROM Usuario u
INNER JOIN Transaccion t ON u.user_id = t.sender_user_id 
INNER JOIN Moneda m ON m.currency_id = t.currency_id;

-- Consulta para obtener todas las transacciones realizadas por un
-- usuario específico
SELECT t.transaction_date, u.nombre, t.importe, m.currency_name
FROM Usuario u
INNER JOIN Transaccion t ON u.user_id = t.sender_user_id 
INNER JOIN Moneda m ON m.currency_id = t.currency_id
WHERE u.nombre = "María López";

-- Sentencia DML para modificar el campo correo electrónico de un
-- usuario específico
UPDATE Usuario
SET correo_electronico = "m.lopez@mail.com"
WHERE nombre = "María López";

-- Sentencia para eliminar los datos de una transacción (eliminado de
-- la fila completa)
DELETE FROM Transaccion
WHERE transaction_id = 7;
