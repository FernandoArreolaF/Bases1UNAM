<?php
//Consulta dinamica a los telefonos de un proveedor
	require 'SQLGlobal.php';
    
	if($_SERVER['REQUEST_METHOD']=='GET'){
		try{
			$RAZONSOCIAL = $_GET["RAZONSOCIAL"]; // obtener parametros GET

			$respuesta = SQLGlobal::selectArrayFiltro(
				"SELECT TELL FROM TELEFONO WHERE RAZONSOCIAL = ?",
				array($RAZONSOCIAL)
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