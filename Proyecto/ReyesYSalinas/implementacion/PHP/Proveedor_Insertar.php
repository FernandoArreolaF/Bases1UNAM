<?php
//Agrgar un nuevo proveedor
//Solo lo hacemos con POST porque es más seguro
	require 'SQLGlobal.php';

	if($_SERVER['REQUEST_METHOD']=='POST'){
		try{
			$datos = json_decode(file_get_contents("php://input"),true);

			$RAZONSOCIAL = $datos["RAZONSOCIAL"]; //NO SE OCUPA PORQUE LA SECUENCIA LO HACE
            $PNOMBREP = $datos["PNOMBREP"];// obtener parametros POST
            $APELLIDOPP = $datos["APELLIDOPP"];
            $APELLIDOMP = $datos["APELLIDOMP"];
            $CALLEP = $datos["CALLEP"];
            $COLONIAP = $datos["COLONIAP"];
            $CPP = $datos["CPP"];
            $NUMEROCALLEP = $datos["NUMEROCALLEP"];
            $ESTADOP = $datos["ESTADOP"];
			$respuesta = SQLGlobal::cudFiltro(
				"INSERT INTO PROVEEDOR VALUES (?,?,?,?,?,?,?,?,?)",
				array($RAZONSOCIAL,$PNOMBREP,$APELLIDOPP,$APELLIDOMP,$CALLEP,$COLONIAP,$CPP,$NUMEROCALLEP,$ESTADOP)
			);//con filtro ("El tamaño del array debe ser igual a la cantidad de los '?'")
			if($respuesta > 0){
                echo json_encode(array(
                    'respuesta'=>'200',
                    'estado' => 'Se inserto correctamente el proveedor', 
                    'data'=>'El numero de registros afectados es: '.$respuesta,
                    'error'=>''
                ));
            }else{
                echo json_encode(array(
				    'respuesta'=>'100',
				    'estado' => 'No se inserto correctamente le proveedor',
				    'data'=>$respuesta,
				    'error'=>''
			    ));
            }
		}catch(PDOException $e){
			echo json_encode(
				array(
					'respuesta'=>'-1',
					'estado' => 'Ocurrio un error, intentelo mas tarde',
					'data'=>'',
					'error'=>$e->getMessage())
			);
		}
	}

?>