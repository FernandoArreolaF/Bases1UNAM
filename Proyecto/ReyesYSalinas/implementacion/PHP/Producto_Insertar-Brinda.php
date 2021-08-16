<?php
//Agrgar un nuevo Producto-Brinda 
//No poner misma combinacion de Proveedor-Producto o se muere el id de Brinda
//Solo lo hacemos con POST porque es más seguro
	require 'SQLGlobal.php';
    //insertar en Producto
	if($_SERVER['REQUEST_METHOD']=='POST'){
		try{
			$datos = json_decode(file_get_contents("php://input"),true);

			$CODIGOBARRAS = $datos["CODIGOBARRAS"]; //NO SE OCUPA PORQUE LA SECUENCIA LO HACE
            $ARTICULO = $datos["ARTICULO"];// obtener parametros POST
            $FECHAC = $datos["FECHAC"];
            $PRECIOC = $datos["PRECIOC"];
            $MARCA = $datos["MARCA"];
            $DESCRIPCION = $datos["DESCRIPCION"];
            $PRECIOV = $datos["PRECIOV"];
            $STOCK = $datos["STOCK"];
			$respuesta = SQLGlobal::cudFiltro(
				"INSERT INTO PRODUCTO VALUES (?,?,?,?,?,?,?,?)",
				array($CODIGOBARRAS,$ARTICULO,$FECHAC,$PRECIOC,$MARCA,$DESCRIPCION,$PRECIOV,$STOCK)
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
    //insertar en Brinda
    if($_SERVER['REQUEST_METHOD']=='POST'){
		try{
			$datos = json_decode(file_get_contents("php://input"),true);

			$RAZONSOCIAL = $datos["RAZONSOCIAL"]; // obtener parametros POST
            $CANTIDADDADA = $STOCK;
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

	
?>