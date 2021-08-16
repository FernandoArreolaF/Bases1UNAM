<?php
//Aumentar stock de un producto, se necesita un Proveedor distinto
//Solo lo hacemos con POST porque es más seguro
	require 'SQLGlobal.php';
    //Brinda
    if($_SERVER['REQUEST_METHOD']=='POST'){
		try{
			$datos = json_decode(file_get_contents("php://input"),true);

			$RAZONSOCIAL = $datos["RAZONSOCIAL"]; // obtener parametros POST
            $CODIGOBARRAS = $datos["CODIGOBARRAS"]; 
            $CANTIDADDADA = $datos["CANTIDADDADA"];
			$respuesta = SQLGlobal::cudFiltro(
				"INSERT INTO BRINDA VALUES (?,?,?)",
				array($RAZONSOCIAL, $CODIGOBARRAS, $CANTIDADDADA)
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

    
    
    //Producto
	if($_SERVER['REQUEST_METHOD']=='POST'){
		try{
			$datos = json_decode(file_get_contents("php://input"),true);

            $STOCK = $CANTIDADDADA;
			$respuesta = SQLGlobal::cudFiltro(
				"UPDATE PRODUCTO SET STOCK = (SELECT STOCK FROM  PRODUCTO WHERE CODIGOBARRAS = ?) + (SELECT CANTIDADDADA FROM BRINDA WHERE CODIGOBARRAS = ? AND RAZONSOCIAL = ?) WHERE CODIGOBARRAS = ?",
				array($CODIGOBARRAS, $CODIGOBARRAS, $RAZONSOCIAL, $CODIGOBARRAS)
			);//con filtro ("El tamaño del array debe ser igual a la cantidad de los '?'")
			if($respuesta > 0){
                echo json_encode(array(
                    'respuesta'=>'200',
                    'estado' => 'Se inserto correctamente el producto',
                    'data'=>'El numero de registros afectados es: '.$respuesta,
                    'error'=>''
                ));
            }else{
                echo json_encode(array(
				    'respuesta'=>'100',
				    'estado' => 'No se inserto correctamente le producto',
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
    
?>