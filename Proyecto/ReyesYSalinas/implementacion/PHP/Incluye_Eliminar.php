<?php
//Eliminar Incluye
	require 'SQLGlobal.php';

	//ACTUALIZAR EL STOCK DEL PRODUCTO
	if($_SERVER['REQUEST_METHOD']=='POST'){
		try{
			$datos = json_decode(file_get_contents("php://input"),true);
			$CODIGOBARRAS = $datos["CODIGOBARRAS"]; // obtener parametros POST, Solo se necesita el id
            $NOVENTA = $datos["NOVENTA"];
			
			$respuesta = SQLGlobal::cudFiltro(
				"UPDATE PRODUCTO SET STOCK = ((SELECT STOCK FROM PRODUCTO WHERE  CODIGOBARRAS = ?) + (SELECT CANTIDADPROD FROM INCLUYE WHERE NOVENTA = ? AND CODIGOBARRAS = ?)) WHERE CODIGOBARRAS = ?;",
				array($CODIGOBARRAS,$NOVENTA,$CODIGOBARRAS,$CODIGOBARRAS)
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
	
	if($_SERVER['REQUEST_METHOD']=='POST'){
		try{
			$datos = json_decode(file_get_contents("php://input"),true);

			$respuesta = SQLGlobal::cudFiltro(
				"DELETE FROM INCLUYE WHERE CODIGOBARRAS = ? AND NOVENTA = ?",
				array($CODIGOBARRAS,$NOVENTA)
			);//con filtro ("El tamaño del array debe ser igual a la cantidad de los '?'")
            if($respuesta > 0){
                echo json_encode(array(
                    'respuesta'=>'200',
                    'estado' => 'Se elimino correctamente el registro', 
                    'data'=>'El numero de filas afectadas es: '.$respuesta,
                    'error'=>''
                ));
            }else{
                echo json_encode(array(
                    'respuesta'=>'100',
                    'estado' => 'Ese registro no existe',
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
 
	
	//calculo del nuevo totalv
	if($_SERVER['REQUEST_METHOD']=='POST'){
		try{
			$datos = json_decode(file_get_contents("php://input"),true);

			//$NOVENTA = $datos["NOVENTA"]; // Ya lo indica en la parte de attiba

			$respuesta = SQLGlobal::cudFiltro(
				"UPDATE VENTA SET TOTALV = (SELECT SUM(TOTALP) FROM INCLUYE WHERE NOVENTA = ?) WHERE NOVENTA = ?",
				array($NOVENTA, $NOVENTA)
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