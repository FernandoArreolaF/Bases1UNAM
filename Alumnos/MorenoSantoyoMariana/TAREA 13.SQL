CREATE TABLE R1 (
    A INT,
    X INT,
    B INT,
    Y INT
);

CREATE TABLE R2 (
    B INT,
    W INT,
    D INT,
    Y INT,
    A INT,
    Z INT
);

INSERT INTO R1 (A, X, B, Y) VALUES
(7, 2, 6, 11),
(3, 4, 9, 15),
(10, 7, 2, 4),
(1, 12, 2, 11);

INSERT INTO R2 (B, W, D, Y, A, Z) VALUES
(2, 5, 6, 11, 1, 30),
(4, 7, 8, 4, 7, 8),
(9, 10, 11, 28, 5, 12);

SELECT *
FROM R1
CROSS JOIN R2;

SELECT *
FROM R2
NATURAL JOIN R1;

SELECT *
FROM R1
JOIN R2
ON R1.Y = R2.Y
WHERE (R1.A > R2.Z OR R1.A >= R2.W);