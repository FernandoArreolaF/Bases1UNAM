<?php
//Agrgar un nuevo Telefono
//Solo lo hacemos con POST porque es más seguro
	require 'SQLGlobal.php';

	if($_SERVER['REQUEST_METHOD']=='POST'){
		try{
			$datos = json_decode(file_get_contents("php://input"),true);

			$TELL = $datos["TELL"]; //Si se debe insertar
            $RAZONSOCIAL = $datos["RAZONSOCIAL"];// obtener parametros POST
			$respuesta = SQLGlobal::cudFiltro(
				"INSERT INTO TELEFONO VALUES (?,?)",
				array($TELL, $RAZONSOCIAL)
			);//con filtro ("El tamaño del array debe ser igual a la cantidad de los '?'")
			if($respuesta > 0){
                echo json_encode(array(
                    'respuesta'=>'200',
                    'estado' => 'Se inserto correctamente el Telefono', 
                    'data'=>'El numero de registros afectados es: '.$respuesta,
                    'error'=>''
                ));
            }else{
                echo json_encode(array(
				    'respuesta'=>'100',
				    'estado' => 'No se inserto correctamente le Telefono',
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