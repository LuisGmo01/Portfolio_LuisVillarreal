--- Vemos toda la informaciÛn de la tabla
SELECT *
FROM OXXO_portfolio..oxxos_mexico

--- Buscamos que datos son NULL


SELECT * 
FROM OXXO_portfolio..oxxos_mexico
WHERE Ubicacion IS NULL

--- hay valores nulos de
--- Razon_social
--- Tipo_vialidad
--- Num_Exterior
--- Num_Interior
--- CP
--- Correo_e
--- Sitio_internet
--- Tipo_corredor_industrial
--- nom_corredor_indsutrial
--- numero_local
--- AGEB
--- EDIFICIO_PISO
--- EDIFICIO


----------------------------------------------------------
SELECT Ubicacion
FROM OXXO_portfolio..oxxos_mexico

--- Quiero separar la columna Ubicacion en tres columnas
--- Ciudad
--- Municipio
--- Estado

SELECT
SUBSTRING(Ubicacion, 1, CHARINDEX(',', Ubicacion) -1) as Ciudad,
SUBSTRING(Ubicacion,CHARINDEX(',', Ubicacion) +1, LEN(Ubicacion)) as Municipio_Estado
FROM OXXO_portfolio..oxxos_mexico


ALTER TABLE oxxos_mexico
add Ciudad NVARCHAR(255);

update oxxos_mexico
SET Ciudad = SUBSTRING(Ubicacion, 1, CHARINDEX(',', Ubicacion) -1)

ALTER TABLE oxxos_mexico
add Municipio_Estado NVARCHAR(255);

update oxxos_mexico
SET Municipio_Estado = SUBSTRING(Ubicacion,CHARINDEX(',', Ubicacion) +1, LEN(Ubicacion))

SELECT Ubicacion, Ciudad, Municipio_Estado
FROM OXXO_portfolio..oxxos_mexico

--- Ahora separamos Municipio_Estado en dos columnas (Municipio y Estado)

SELECT
SUBSTRING(Municipio_Estado, 1, CHARINDEX(',', Municipio_Estado) -1) as Municipio,
SUBSTRING(Municipio_Estado, CHARINDEX(',', Municipio_Estado) +1, LEN(Municipio_Estado)) as Estado
FROM OXXO_portfolio..oxxos_mexico

ALTER TABLE oxxos_mexico
add Municipio NVARCHAR(255);

update oxxos_mexico
SET Municipio = SUBSTRING(Municipio_Estado, 1, CHARINDEX(',', Municipio_Estado) -1)

ALTER TABLE oxxos_mexico
add Estado NVARCHAR(255);

update oxxos_mexico
SET Estado = SUBSTRING(Municipio_Estado, CHARINDEX(',', Municipio_Estado) +1, LEN(Municipio_Estado))

SELECT Ubicacion, Ciudad, Municipio, Estado
FROM OXXO_portfolio..oxxos_mexico
-----------------------------------
--- Notemos que los Estados con acentos estan mal escritos

SELECT distinct(Estado) FROM OXXO_portfolio..oxxos_mexico

update oxxos_mexico
SET Estado = 'NUEVO LE”N'
WHERE Estado = ' NUEVO LE√ìN   '

update oxxos_mexico
SET Estado = 'M…XICO'
WHERE Estado = ' M√âXICO          '

update oxxos_mexico
SET Estado = 'CIUDAD DE M…XICO'
WHERE Estado = ' CIUDAD DE M√âXICO'

update oxxos_mexico
SET Estado = 'MICHOAC¡N DE OCAMPO'
WHERE Estado = ' MICHOAC√ÅN DE OCAMPO       '

update oxxos_mexico
SET Estado = 'QUER…TARO'
WHERE Estado = ' QUER√âTARO                '

update oxxos_mexico
SET Estado = 'QUER…TARO'
WHERE Estado = ' Pedro Escobedo, QUER√âTARO            '

update oxxos_mexico
SET Estado = 'SAN LUIS POTOSÕ'
WHERE Estado = ' SAN LUIS POTOS√ç        '


update oxxos_mexico
SET Estado = 'YUCAT¡N'
WHERE Estado = ' YUCAT√ÅN       '


SELECT * FROM OXXO_portfolio..oxxos_mexico

---- Comparamos si hay Id duplicados
SELECT count(Id), count(distinct(Id)) FROM OXXO_portfolio..oxxos_mexico

SELECT Id, Estrato, Tipo_vialidad, Tipo_Asentamiento, Fecha_Alta, Ciudad, Municipio, Estado, Longitud, Latitud
FROM OXXO_portfolio..oxxos_mexico

--- Ahora podemos pasar la tabla a excel y continuar en Tableau