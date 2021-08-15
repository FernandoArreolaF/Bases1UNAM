<?php
//Actalizacion de Productos (todos los atributos), todo funciona bien
	require 'SQLGlobal.php';

	if($_SERVER['REQUEST_METHOD']=='POST'){
		try{
			$datos = json_decode(file_get_contents("php://input"),true);

			$CODIGOBARRAS = $datos["CODIGOBARRAS"]; //Lo necesitamos para saber cual modificar AGIOH HU HU
            $ARTICULO = $datos["ARTICULO"];// obtener parametros POST
            $FECHAC = $datos["FECHAC"];
            $PRECIOC = $datos["PRECIOC"];
            $MARCA = $datos["MARCA"];
            $DESCRIPCION = $datos["DESCRIPCION"];
            $PRECIOV = $datos["PRECIOV"];
            //$STOCK = $datos["STOCK"];//aqui no se cambia esto
			$respuesta = SQLGlobal::cudFiltro(
				"UPDATE PRODUCTO SET ARTICULO = ?, FECHAC = ?, PRECIOC = ?, MARCA = ?, DESCRIPCION = ?, PRECIOV = ? WHERE CODIGOBARRAS = ?",
				array($ARTICULO,$FECHAC, $PRECIOC, $MARCA,$DESCRIPCION,$PRECIOV, $CODIGOBARRAS)
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
                    'estado' => 'El codigo de producto no existe',
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