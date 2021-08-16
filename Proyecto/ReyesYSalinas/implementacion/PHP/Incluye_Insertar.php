<?php
//Agrgar una nuevo registro a Incluye
//Solo lo hacemos con POST porque es más seguro
//NO INCLUIR EL MISMO PRODUCTO A UNA VENTA
	require 'SQLGlobal.php';

	if($_SERVER['REQUEST_METHOD']=='POST'){
		try{
			$datos = json_decode(file_get_contents("php://input"),true);

            $CODIGOBARRAS = $datos["CODIGOBARRAS"];// obtener parametros POST
            $NOVENTA = $datos["NOVENTA"]; 
            $CANTIDADPROD = $datos["CANTIDADPROD"];
            //$TOTALP = $datos["TOTALP"]; //si se hace la operacion no se necesita
			$respuesta = SQLGlobal::cudFiltro(
				"INSERT INTO INCLUYE VALUES (?,?,?,((SELECT PRECIOV FROM PRODUCTO WHERE CODIGOBARRAS = ?)* ?))",
				array($CODIGOBARRAS, $NOVENTA, $CANTIDADPROD, $CODIGOBARRAS, $CANTIDADPROD)
			);//con filtro ("El tamaño del array debe ser igual a la cantidad de los '?'")
			if($respuesta > 0){
                echo json_encode(array(
                    'respuesta'=>'200',
                    'estado' => 'Se inserto correctamente', 
                    'data'=>'El numero de registros afectados es: '.$respuesta,
                    'error'=>''
                ));
            }else{
                echo json_encode(array(
				    'respuesta'=>'100',
				    'estado' => 'No se inserto correctamente',
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

	//ACTUALIZAR EL STOCK DEL PRODUCTO
	if($_SERVER['REQUEST_METHOD']=='POST'){
		try{
			$datos = json_decode(file_get_contents("php://input"),true);

			$respuesta = SQLGlobal::cudFiltro(
				"UPDATE PRODUCTO SET STOCK = ((SELECT STOCK FROM PRODUCTO WHERE  CODIGOBARRAS = ?) - ?) WHERE CODIGOBARRAS = ?",
				array($CODIGOBARRAS,$CANTIDADPROD,$CODIGOBARRAS)
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

	//calcular el nuevo totalv
	if($_SERVER['REQUEST_METHOD']=='POST'){
		try{
			$datos = json_decode(file_get_contents("php://input"),true);

			//$NOVENTA = $datos["NOVENTA"]; // Ya lo indica en la parte de arriba

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