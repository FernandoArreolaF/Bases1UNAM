<?php
//Eliminar Correos
	require 'SQLGlobal.php';

	if($_SERVER['REQUEST_METHOD']=='POST'){
		try{
			$datos = json_decode(file_get_contents("php://input"),true);

			$CORREO = $datos["CORREO"]; // obtener parametros POST, Solo se necesita el id
			$respuesta = SQLGlobal::cudFiltro(
				"DELETE FROM EMAIL WHERE CORREO = ?",
				array($CORREO)
			);//con filtro ("El tamaño del array debe ser igual a la cantidad de los '?'")
            if($respuesta > 0){
                echo json_encode(array(
                    'respuesta'=>'200',
                    'estado' => 'Se elimino correctamente el Correo', 
                    'data'=>'El numero de filas afectadas es: '.$respuesta,
                    'error'=>''
                ));
            }else{
                echo json_encode(array(
                    'respuesta'=>'100',
                    'estado' => 'Ese correo no existe',
                    'data'=>'El numero de filas afectadas es: '.$respuesta,
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