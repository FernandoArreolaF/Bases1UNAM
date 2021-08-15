<?php
//Actalizacion de Clientes, todo funciona bien
	require 'SQLGlobal.php';

	if($_SERVER['REQUEST_METHOD']=='POST'){
		try{
			$datos = json_decode(file_get_contents("php://input"),true);

			$RFC = $datos["RFC"]; //obtener parametros POST
            $PNOMBREC = $datos["PNOMBREC"];
            $APELLIDOPC = $datos["APELLIDOPC"];
            $APELLIDOMC = $datos["APELLIDOMC"];
            $CALLEC = $datos["CALLEC"];
            $COLONIAC = $datos["COLONIAC"];
            $CPC = $datos["CPC"];
            $NUMEROCALLEC = $datos["NUMEROCALLEC"];
            $ESTADOC = $datos["ESTADOC"];
			$respuesta = SQLGlobal::cudFiltro(
				"UPDATE CLIENTE SET  PNOMBREC= ?, APELLIDOPC = ?, APELLIDOMC = ?, CALLEC = ?, COLONIAC = ?, CPC = ?, NUMEROCALLEC = ?, ESTADOC =? WHERE RFC = ?",
				array($PNOMBREC, $APELLIDOPC, $APELLIDOMC, $CALLEC, $COLONIAC, $CPC, $NUMEROCALLEC, $ESTADOC, $RFC)
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