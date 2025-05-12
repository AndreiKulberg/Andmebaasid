create database TiTtriger;
use TiTtriger;
--tabel, mida automaatselt täidab triger
CREATE TABLE logi(
id int primary key identity (1,1),
tegevus varchar(25),
kasutaja varchar(25),
aeg datetime,
andmed TEXT)

--tabel, millega töötab kasutaja
Create table puud(
puuId int primary key identity (1,1),
puuNimi varchar(25),
pikkus int,
aasta int)
insert into puud (puuNimi, pikkus, aasta)
values ('kuusk', '7', '11');
select * from puud;

CREATE TRIGGER puuLisamine
ON puud
FOR INSERT
AS
INSERT INTO logi(kasutaja, tegevus, aeg, andmed)
SELECT
SYSTEM_USER,
'puu on lisatud',
GETDATE(),
CONCAT (inserted.puuNimi, ', ' ,inserted.pikkus, ', ' ,inserted.aasta)
FROM inserted;
--kontroll
INSERT INTO puud(puuNimi, pikkus, aasta)
VALUES ('vaher', 22, 2000);
SELECT * FROM puud;
SELECT * FROM logi;
drop trigger puuLisamine;
--triger, mis jälgib tabelis kustutamine
CREATE TRIGGER puuKustutamine
ON puud
FOR DELETE
AS
INSERT INTO logi(kasutaja, tegevus, aeg, andmed)
SELECT
SYSTEM_USER,
'puu on kustutatud',
GETDATE(),
CONCAT (deleted.puuNimi, ', ' ,deleted.pikkus, ', ' ,deleted.aasta)
FROM deleted;
--kontroll
DELETE FROM puud WHERE puuId=2;
SELECT * FROM puud;
SELECT * FROM logi;

--triger, mis jälgib tabelis uuendamine
CREATE TRIGGER puuUuendamine
ON puud
FOR UPDATE
AS
INSERT INTO logi(kasutaja, tegevus, aeg, andmed)
SELECT
SYSTEM_USER,
'puu on uuendatud',
GETDATE(),
CONCAT(
'vana puu info - ', deleted.puuNimi, ', ' ,deleted.pikkus, ', ' ,deleted.aasta,
'uus puu info - ', inserted.puuNimi, ', ' ,inserted.pikkus , ', ' ,inserted.aasta
)
FROM deleted INNER JOIN inserted
ON deleted.puuId=inserted.puuId;

--kontroll
UPDATE puud SET pikkus=25555, aasta=1900
WHERE puuId=3;
SELECT * FROM puud;
SELECT * FROM logi;



CREATE TABLE products(
product_id int primary key identity(1,1),
product_name varchar(50),
brand_id int,
category_id int,
model_year int,
list_price int
)

CREATE TABLE product_audits(
    change_id INT IDENTITY PRIMARY KEY,
    product_id INT NOT NULL,
    product_name VARCHAR(255) NOT NULL,
    brand_id INT NOT NULL,
    category_id INT NOT NULL,
    model_year SMALLINT NOT NULL,
    list_price DEC(10,2) NOT NULL,
    updated_at DATETIME NOT NULL,
    operation CHAR(3) NOT NULL,
    CHECK(operation = 'INS' or operation='DEL')
);

CREATE TRIGGER trg_product_audit
ON products
AFTER INSERT, DELETE
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO product_audits(
        product_id, 
        product_name,
        brand_id,
        category_id,
        model_year,
        list_price, 
        updated_at, 
        operation
    )
    SELECT
        i.product_id,
        product_name,
        brand_id,
        category_id,
        model_year,
        i.list_price,
        GETDATE(),
        'INS'
    FROM
        inserted i
    UNION ALL
    SELECT
        d.product_id,
        product_name,
        brand_id,
        category_id,
        model_year,
        d.list_price,
        GETDATE(),
        'DEL'
    FROM
        deleted d;
END

INSERT INTO products(
    product_name, 
    brand_id, 
    category_id, 
    model_year, 
    list_price
)
VALUES (
    'Test product',
    1,
    1,
    2018,
    599
);
SELECT 
    * 
FROM 
    product_audits;

DELETE FROM 
    products
WHERE 
    product_id = 1;



XAMPP

CREATE TABLE products(
product_id int primary AUTO_INCREMENT,
product_name varchar(50),
brand_id int,
category_id int,
model_year int,
list_price int
);

CREATE TABLE product_audits(
    change_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    product_name VARCHAR(255) NOT NULL,
    brand_id INT NOT NULL,
    category_id INT NOT NULL,
    model_year SMALLINT NOT NULL,
    list_price DECIMAL(10,2) NOT NULL,
    updated_at DATETIME NOT NULL,
    operation CHAR(3) NOT NULL
    CHECK(operation = 'INS' or operation='DEL')
);

create database kulberg
use kulberg;

CREATE TABLE firma (
	firmaID INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	firmanimi VARCHAR(20) unique,
	aadress VARCHAR(20),
	telefon VARCHAR(20)
);

CREATE TABLE Praktikajuhendaja (
    praktikajuhendajaID INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    eesnimi VARCHAR(50),
    perekonnanimi VARCHAR(50),
    synniaeg DATE,
    telefon VARCHAR(20)
);

CREATE TABLE praktikabaas (
		praktikabaasID int NOT NULL PRIMARY KEY IDENTITY(1,1),
		firmaID int,
		praktikatingimused varchar(20),
		arvutiprogramm varchar(20),
		juhendajaID int,
		FOREIGN KEY (firmaID) REFERENCES firma(firmaID),
		FOREIGN KEY (juhendajaID) REFERENCES praktikajuhendaja(praktikajuhendajaID)
);

insert into firma (firmanimi, aadress, telefon) values ( 'gdeto', '2nd floor', '58000510');
insert into firma (firmanimi, aadress, telefon) values ( 'kose mnt', '3th floor', '55544122');
insert into firma (firmanimi, aadress, telefon) values ( 'anija', '4th floor', '58996767');
insert into firma (firmanimi, aadress, telefon) values ( 'viineri', '5th floor', '58008078');
insert into firma (firmanimi, aadress, telefon) values ( 'liivalaia', '6th floor', '56053619');
select * from firma

insert into Praktikajuhendaja(eesnimi, perekonnanimi, synniaeg, telefon) values ( 'andrei', 'kulberg', '27/02/2006', '58000510');
insert into Praktikajuhendaja(eesnimi, perekonnanimi, synniaeg, telefon) values ( 'artur', 'kulberg', '13/04/2004', '55544122');
insert into Praktikajuhendaja(eesnimi, perekonnanimi, synniaeg, telefon) values ( 'marek', 'kulberg', '15/10/2003', '56998078');

CREATE TABLE Praktikabaas_logi (
    id INT IDENTITY(1,1) PRIMARY KEY,
    kasutaja VARCHAR(255) NOT NULL,
    aeg DATETIME DEFAULT CURRENT_TIMESTAMP,
    tegevus VARCHAR(255) NOT NULL,
    andmed TEXT
);

select * from Praktikabaas_logi

CREATE TRIGGER praktikabaas_insert
ON praktikabaas
FOR INSERT
AS
BEGIN
    INSERT INTO Praktikabaas_logi(kasutaja, tegevus, aeg, andmed)
    SELECT
        SYSTEM_USER,
        'INSERT',
        GETDATE(),
        CONCAT('Добавлена запись ID: ', inserted.praktikabaasID)
    FROM inserted;
END;

CREATE TRIGGER praktikabaas_update
ON praktikabaas
FOR UPDATE
AS
BEGIN
    INSERT INTO Praktikabaas_logi(kasutaja, tegevus, aeg, andmed)
    SELECT
        SYSTEM_USER,
        'UPDATE',
        GETDATE(),
        CONCAT(
            'Старая запись ID: ', deleted.praktikabaasID, 
            ' | Новая запись ID: ', inserted.praktikabaasID
        )
    FROM deleted INNER JOIN inserted
    ON deleted.praktikabaasID = inserted.praktikabaasID;
END;

CREATE TRIGGER trg_Check_Juhendaja_Synniaeg
ON praktikajuhendaja
INSTEAD OF INSERT
AS
BEGIN
IF EXISTS (SELECT 1 FROM inserted WHERE synniaeg > GETDATE())
BEGIN
RAISERROR('Sünniaeg ei tohi olla tulevikus.', 16, 1);
END
ELSE
BEGIN
INSERT INTO praktikajuhendaja (eesnimi, perekonnanimi, synniaeg, telefon)
SELECT eesnimi, perekonnanimi, synniaeg, telefon
FROM inserted;
END
END;

INSERT INTO praktikajuhendaja (eesnimi, perekonnanimi, synniaeg, telefon)
VALUES ('Mari', 'Tamm', '2006-01-01', '555-1234');
