<?php
//Agregar una nueva venta-Incluye y TotalV (parcial)
//Solo lo hacemos con POST porque es más seguro
	require 'SQLGlobal.php';

	if($_SERVER['REQUEST_METHOD']=='POST'){
		try{
			$datos = json_decode(file_get_contents("php://input"),true);
            //no se necesita NOVENTA
			$FECHAV = $datos["FECHAV"]; // obtener parametros POST
            //$TOTALV = $datos["TOTALV"]; //EN ESTE PUNTO ESTA VACIA
            $RFC = $datos["RFC"];
			$respuesta = SQLGlobal::cudFiltro(
				"INSERT INTO VENTA VALUES (CONCAT('VENT-',nextval('SQ_VENTA')),?,NULL,?)",
				array($FECHAV,$RFC)
			);//con filtro ("El tamaño del array debe ser igual a la cantidad de los '?'")
			if($respuesta > 0){
                echo json_encode(array(
                    'respuesta'=>'200',
                    'estado' => 'Se inserto correctamente la venta', 
                    'data'=>'El numero de registros afectados es: '.$respuesta,
                    'error'=>''
                ));
            }else{
                echo json_encode(array(
				    'respuesta'=>'100',
				    'estado' => 'No se inserto correctamente la venta',
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
    //INCLUIR UN PRODUCTO A LA VENTA DE ARRIBA
	if($_SERVER['REQUEST_METHOD']=='POST'){
		try{
			$datos = json_decode(file_get_contents("php://input"),true);

            $CODIGOBARRAS = $datos["CODIGOBARRAS"];//Primer Producto a comprar
            //$NOVENTA = $datos["NOVENTA"]; // se calcula con el trucazo de la concatenacion
            $CANTIDADPROD = $datos["CANTIDADPROD"];
            //$TOTALP = $datos["TOTALP"]; //no se necesita, porque se hace la operacion
			$respuesta = SQLGlobal::cudFiltro(
				"INSERT INTO INCLUYE VALUES (?,CONCAT('VENT-',(SELECT last_value from SQ_VENTA)),?,((SELECT PRECIOV FROM PRODUCTO WHERE CODIGOBARRAS = ?)* ?))",
				array($CODIGOBARRAS, $CANTIDADPROD, $CODIGOBARRAS, $CANTIDADPROD)
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

			//$id = $datos["id"]; // obtener parametros POST
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
 
	//indicar el total de venta
	if($_SERVER['REQUEST_METHOD']=='POST'){
		try{
			$datos = json_decode(file_get_contents("php://input"),true);
			$respuesta = SQLGlobal::cud("UPDATE VENTA SET TOTALV = (SELECT SUM(TOTALP) FROM INCLUYE WHERE NOVENTA = CONCAT('VENT-',(SELECT last_value from SQ_VENTA))) WHERE NOVENTA = CONCAT('VENT-',(SELECT last_value from SQ_VENTA))"); //no se neceitan los parametros
			//$NOVENTA = $datos["NOVENTA"]; // Se hace de nuevo el trucazo de la concatenacion
            //$FECHAV = $datos["FECHAV"]; //no cambia
            //$TOTALV = $datos["TOTALV"]; //no damos el poder al usuario de cambiarlo
            //$RFC = $datos["RFC"]; //no cambia
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