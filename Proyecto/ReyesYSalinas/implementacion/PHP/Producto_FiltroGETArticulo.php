<?php
//Consulta dinamica por articulo de la tabla Producto
//sirve, pero si se deja sin parametro se trai todo
	require 'SQLGlobal.php';
    
	if($_SERVER['REQUEST_METHOD']=='GET'){
		try{
			$ARTICULO = $_GET["ARTICULO"]; // obtener parametros GET

			$respuesta = SQLGlobal::selectArrayFiltro(
				"SELECT * FROM PRODUCTO WHERE LOWER(ARTICULO) LIKE LOWER(?) AND STOCK > 0",
				array($ARTICULO.'%')
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