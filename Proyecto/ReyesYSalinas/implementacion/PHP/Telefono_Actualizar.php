<?php
//Actalizacion de Telefonoss, todo funciona bien
	require 'SQLGlobal.php';

	if($_SERVER['REQUEST_METHOD']=='POST'){
		try{
			$datos = json_decode(file_get_contents("php://input"),true);

			$RAZONSOCIAL = $datos["RAZONSOCIAL"]; //obtener parametros POST
            $TELL1 = $datos["TELL1"];//Telefono actual
			$TELL2 = $datos["TELL2"];//telefono nuevo
			$respuesta = SQLGlobal::cudFiltro(
				"UPDATE TELEFONO SET  TELL = ? WHERE RAZONSOCIAL = ? AND TELL = ?",
				array($TELL2, $RAZONSOCIAL, $TELL1)
			);//con filtro ("El tamaño del array debe ser igual a la cantidad de los '?'")
            if($respuesta > 0){
                echo json_encode(array(
                    'respuesta'=>'200',
                    'estado' => 'Se actualizo correctamente',
                    'data'=>'Numero de filas afectadas: '.$respuesta,
                    'error'=>''
                ));
            }else{
                echo json_encode(array(
                    'respuesta'=>'100',
                    'estado' => 'No se actualizo correctamente',
                    'data'=>'Numero de filas afectadas: '.$respuesta,
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