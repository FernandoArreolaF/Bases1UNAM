EDIFICIO (
nombreEdif varchar(20) (PK),
numeroPisos smallint ,
ubicacion varchar (20))

MATERIAL (
nombreMat varchar(50) (PK),
fabricante varchar(50),
precio int)

EDIF_MAT(
[nombreEdif varchar(20),
nombreMat varchar(50)](FK)(PK))

CUADRILLA (
numCuad int (PK),
descripcion varchar(30)
claveFun int (FK))

EDIF_CUAD (
[nombreEdif varchar(20),
numCuad int](FK)(PK),
fechaAds date)

FUNCION (
claveFun int (PK),
especialidad varchar(20))


TRABAJADOR (
RFC varchar(10)(PK),
numCuad int (FK),
RFC_capataz varchar(10) (FK),
oficio varchar(20),
nomPila varchar(15),
patTrab varchar (15),
matTrab varchar(15))

