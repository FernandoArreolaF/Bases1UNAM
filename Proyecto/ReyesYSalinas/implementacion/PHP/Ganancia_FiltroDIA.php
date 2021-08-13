<?php
    //Mostrar gananacia en un solo dia
	require 'SQLGlobal.php';

	if($_SERVER['REQUEST_METHOD']=='GET'){
		try{
			$FECHA = $_GET['FECHA']; // obtener parametros GET
			$respuesta = SQLGlobal::selectObjectFiltro(
				"SELECT FECHAV, SUM(TOTALV) 
                FROM VENTA 
                WHERE FECHAV = ?
                GROUP BY FECHAV
                ORDER BY FECHAV",
				array($FECHA)
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