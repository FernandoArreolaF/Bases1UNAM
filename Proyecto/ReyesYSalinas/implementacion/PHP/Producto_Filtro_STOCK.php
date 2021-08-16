<?php
//Consulta dinamica a Productos de los articulo por STOCK
//https://serene-escarpment-45910.herokuapp.com/Producto_Filtro_STOCK.php/?%20STOCK=3
	require 'SQLGlobal.php';

	if($_SERVER['REQUEST_METHOD']=='GET'){
		try{
			$STOCK = $_GET['STOCK']; // obtener parametros GET
			$respuesta = SQLGlobal::selectArrayFiltro(
				"SELECT CODIGOBARRAS, ARTICULO, PRECIOV, STOCK FROM PRODUCTO WHERE STOCK < ?",
				array($STOCK)
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