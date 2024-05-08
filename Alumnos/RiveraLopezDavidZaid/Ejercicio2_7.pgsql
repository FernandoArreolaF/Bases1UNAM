
CREATE TABLE ASESOR(

    ID_ASESOR VARCHAR(4) PRIMARY KEY,
    NOMBRE_ASESOR VARCHAR(50)

);

INSERT INTO ASESOR (ID_ASESOR, NOMBRE_ASESOR)
VALUES
    ('as-1','Jorge Campos'),
    ('as-2','Laura Sandoval'),
    ('as-3','Adolfo Millan'),
    ('as-4','Fernando Arreola');

CREATE TABLE ALUMNO(

    ID_ALUMNO SERIAL PRIMARY KEY,
    NOMBRE_ALUMNO VARCHAR(50),
    ID_ASESOR VARCHAR(4),
    FOREIGN KEY (ID_ASESOR) REFERENCES ASESOR(ID_ASESOR)

);

INSERT INTO ALUMNO(NOMBRE_ALUMNO, ID_ASESOR)
VALUES
    ('Mauricio Barrietos','as-1'),
    ('Mario Tabura','as-2'),
    ('Luz Rueda','as-1'),
    ('Jorge Santillan', NULL),
    ('Gabriela Gaytan', 'as-3');

select * from alumno;
select * from asesor;

/* Se desea conocer aquellos alumnos que 
ya cuentan con asesor, así como los alumnos sin
asesor y los asesores sin alumnos. Interesa el
nombre del asesor y del alumno*/

SELECT AL.NOMBRE_ALUMNO, ASE.NOMBRE_ASESOR
FROM ALUMNO AS AL
LEFT JOIN ASESOR AS ASE
ON AL.ID_ASESOR = ASE.ID_ASESOR;

/*
Se desea conocer aqullos alumnos sin asesor y
los asesores sin alumnos. Interesa el nombre
asesor y del alumno
*/

(SELECT NOMBRE_ALUMNO
FROM ALUMNO
WHERE ID_ASESOR IS NULL)
union
(SELECT NOMBRE_ASESOR
FROM ASESOR
WHERE ID_ASESOR NOT IN (SELECT ID_ASESOR FROM ALUMNO));

/*
Se desea conocer aquellos alumnos sin asesor
interesa el nombre del alumno. Emplear Joins
*/

SELECT AL.NOMBRE_ALUMNO
FROM ALUMNO AS AL
LEFT JOIN ASESOR AS ASE ON AL.ID_ASESOR = ASE.ID_ASESOR
WHERE ASE.ID_ASESOR IS NULL;


/*
Se desea conocer aquellos asesores sin alumnos.
Interesa el nombre del asesor. Emplear joins.
*/

SELECT ASE.NOMBRE_ASESOR
FROM ASESOR AS ASE
LEFT JOIN ALUMNO AS AL ON ASE.ID_ASESOR = AL.ID_ASESOR
WHERE AL.ID_ASESOR IS NULL;

/*
Se desea conocer aquellos alumnos que ya
cuentan con asesor. Interesa el nombre 
del asesor y del alumno
*/

SELECT AL.NOMBRE_ALUMNO, ASE.NOMBRE_ASESOR
FROM ALUMNO AS AL
INNER JOIN ASESOR AS ASE ON AL.ID_ASESOR = ASE.ID_ASESOR;

/*
Se desea conocer aquellos alumnos que ya cuentan con aseso
y aquellos que no. Interesa el nombre de asesor y alumno
*/

SELECT AL.NOMBRE_ALUMNO, ASE.NOMBRE_ASESOR
FROM ALUMNO AS AL
LEFT JOIN ASESOR AS ASE ON AL.ID_ASESOR = ASE.ID_ASESOR;

/*
Se desea conocer aquellos asesores que ya cuentan con
tesista y quellos que no. Interesa el nombre de asesor y alumno
*/

SELECT AL.NOMBRE_ALUMNO, ASE.NOMBRE_ASESOR
FROM ALUMNO AS AL
RIGHT JOIN ASESOR AS ASE ON AL.ID_ASESOR = ASE.ID_ASESOR;
