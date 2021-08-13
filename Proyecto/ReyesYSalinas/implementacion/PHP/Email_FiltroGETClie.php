<?php
//Consulta dinamica a los correos de un cliente
	require 'SQLGlobal.php';
    
	if($_SERVER['REQUEST_METHOD']=='GET'){
		try{
			$RFC = $_GET["RFC"]; // obtener parametros GET

			$respuesta = SQLGlobal::selectArrayFiltro(
				"SELECT CORREO FROM EMAIL WHERE RFC = ?",
				array($RFC)
			);//con filtro ("El tamaño del array debe ser igual a la cantidad de los '?'")
			echo json_encode(array(
				'respuesta'=>'200',
				'estado' => 'Se obtuvieron los datos correctamente',
				'data'=>$respuesta,
				'error'=>''
			));
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