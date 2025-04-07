-- SQL kommentar
-- SQL Server Managment Stuudio
-- connect to
-- (localdb)\mssqllocaldb
-- Autentification: Windows Auth - admini õigused localhostis
-- Autentification: SQL Server Auth - varem loodud kasutajad
-- New Query

CREATE DATABASE kulberg;
--Object Explorer on vaja pidevalt uuendada käsitsi!

USE kulberg;
--tabeli loomine

CREATE TABLE opilane(
opilaneID int Primary Key identity(1,1),
eesnimi varchar(25),
perenimi varchar(30) Unique,
synniaeg date,
aadress TEXT,
opilaskodu bit
);
SELECT * FROM opilane;

--tabeli kustutamine

DROP table opilane;
--andmete lisamine tabelisse

INSERT INTO opilane(eesnimi, perenimi, synniaeg, aadress, opilaskodu)
VALUES ('Mark', 'Sebeko', '2006-02-27', 'Kehra', 1),
('Mikhail', 'Leoke', '2008-12-7', 'Moscow', 1),
('Dmitri', 'Gordey', '2004-04-17', 'SPB', 1);
