<?php
//Consulta a detalles de una venta (TICKET)
//Muestra codigos no datos reales
	require 'SQLGlobal.php';
    
    // datos de venta 
    /* 
	if($_SERVER['REQUEST_METHOD']=='GET'){
		try{
			$NOVENTA = $_GET["NOVENTA"]; // obtener parametros GET

			$respuesta = SQLGlobal::selectArrayFiltro(
				"SELECT NOVENTA, RFC, FECHAV FROM VENTA WHERE NOVENTA = ?",
				array($NOVENTA)
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
    */

    // Incluye con JOIN
    if($_SERVER['REQUEST_METHOD']=='GET'){
		try{
			$NOVENTA = $_GET["NOVENTA"]; // obtener parametros GET

			$respuesta = SQLGlobal::selectArrayFiltro(
				"SELECT I.CODIGOBARRAS, P.ARTICULO, P.MARCA, P.PRECIOV, I.CANTIDADPROD, I.TOTALP
				FROM PRODUCTO P INNER JOIN INCLUYE I
				ON P.CODIGOBARRAS = I.CODIGOBARRAS
				WHERE NOVENTA = ?",
				array($NOVENTA)
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

    // Total de venta 
    /*
    if($_SERVER['REQUEST_METHOD']=='GET'){
		try{
			$NOVENTA = $_GET["NOVENTA"]; // obtener parametros GET

			$respuesta = SQLGlobal::selectArrayFiltro(
				"SELECT TOTALV FROM VENTA WHERE NOVENTA = ?",
				array($NOVENTA)
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
    */
?>