-- SQL kommentar
-- XAMPP Control Panel (Start Apache, Start MySQL)
-- connect to
-- localhost
-- Autentification:
-- Autentification:
--kasutajanimi - root
--parool ei ole
--SQL:

CREATE DATABASE kulberg;
--Object Explorer on vaja pidevalt uuendada käsitsi!

--tabeli loomine
CREATE TABLE opilane(
opilaneID int Primary Key AUTO_INCREMENT,
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
--tabel Rühm

--identity(1,1) - automaatselt täidab 1,2,3....
CREATE TABLE ryhm(
ryhmID int not null primary key AUTO_INCREMENT,
ryhm varchar(10) unique,
osakond varchar(20)
);
INSERT INTO ryhm(ryhm, osakond)
Values('TITpv24', 'IT'),('KRRpv23', 'Rätsepp');

Select * from ryhm;
--lisame uus veerg RyhmID tabelisse opilane
ALTER TABLE opilane ADD ryhmID int;

Select * from opilane;

--lisame foreign key veergule ryhmID mis on seotud
--tabeliga ryhm ja veerguga ryhmID
ALTER TABLE opilane
Add foreign key (ryhmID) references ryhm(ryhmID);

--foreign key kontroll
INSERT INTO opilane(eesnimi, perenimi, synniaeg, aadress, opilaskodu, ryhmID)
VALUES ('Mark', 'nazaruk', '2006-02-27', 'Kehra', 1, 2 );

 SELECT * FROM opilane;
 --kasutame seos tabelite vahel - JOIN
 SELECT * FROM opilane JOIN ryhm
 ON opilane.ryhmID=ryhm.ryhmID;

 SELECT opilane.perenimi, ryhm.ryhm FROM opilane JOIN ryhm
 ON opilane.ryhmID=ryhm.ryhmID;

 --lihtsaim vaade
 SELECT o.perenimi, r.ryhm, o.aadress
 FROM opilane o JOIN ryhm r
 ON o.ryhmID=r.ryhmID;

CREATE TABLE hinne(
hinneID int primary key AUTO_INCREMENT,
hinne int,
opilaneID int,
oppeaine varchar(50)
);

SELECT * FROM hinne;
DROP TABLE hinne;

ALTER TABLE hinne
ADD foreign key (opilaneID) references opilane;

INSERT INTO hinne(opilaneID, oppeaine, hinne)
Values(2, 'Roobotika', 5);
SELECT * from hinne;
--sellect ...hinne join opilane!

CREATE TABLE opetaja( opetajaID int Primary Key AUTO_INCREMENT, nimi varchar(25), perenimi varchar(30) Unique, telefon int);
SELECT * FROM `opetaja`
SELECT * FROM opetaja;
INSERT INTO opetaja(nimi, perenimi, telefon) VALUES ('Mikhail', 'Agapov', '58000510'), ('Nikita', 'Podkopaev', '56998078'), ('Lury', 'Avik', '55544122');
SELECT * FROM `opetaja`
ALTER TABLE opetaja ADD ryhmID int;
ALTER TABLE opetaja Add foreign key (ryhmID) references ryhm(ryhmID);
SELECT * FROM opetaja JOIN ryhm ON opetaja.ryhmID=ryhm.ryhmID;







BEGIN
SELECT filmNimetus, pikkus
FROM film
WHERE filmNimetus LIKE CONCAT(taht, '%');
END
