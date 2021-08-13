<?php
//Obtener el total obtenido entre dos fechas
//SIN TABLA TEMPORAL
//ESTE SI SIRVE
	require 'SQLGlobal.php';

    // Eliminar los registros anteriores
	if($_SERVER['REQUEST_METHOD']=='GET'){
		try{
			$respuesta = SQLGlobal::cud("DELETE FROM TTOTALV");//queremos eliminar todos los registros anteriores
			echo json_encode(array(
				'respuesta'=>'200',
				'estado' => 'borra elementos',
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


    //insercion en tabla de apoyo
	if($_SERVER['REQUEST_METHOD']=='GET'){
		try{
			$FECHA1 = $_GET['FECHA1']; // obtener parametros GET
            $FECHA2 = $_GET['FECHA2'];
			$respuesta = SQLGlobal::cudFiltro(
				"INSERT INTO TTOTALV (DIAV,TOTALS) 
				SELECT FECHAV, SUM(TOTALV) 
					FROM VENTA 
					WHERE FECHAV BETWEEN ? AND ?
					GROUP BY FECHAV
					ORDER BY FECHAV",
				array($FECHA1,$FECHA2)
			);//con filtro ("El tamaño del array debe ser igual a la cantidad de los '?'")
			echo json_encode(array(
				'respuesta'=>'200',
				'estado' => 'inserta elementos',
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

	//muestra de los dias con su total por dia //comentar si android corre el bloque de abajo
	/*if($_SERVER['REQUEST_METHOD']=='GET'){
		try{
			$respuesta = SQLGlobal::selectArray("SELECT TOTALS FROM TTOTALV");//sin filtro ("No incluir filtros ni '?'")
			
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
	}*/

    //Calculo del total entre las dos fechas //no lo corre el android
    if($_SERVER['REQUEST_METHOD']=='GET'){
		try{
			$respuesta = SQLGlobal::selectArray("SELECT SUM(TOTALS) AS TOTAL FROM TTOTALV");//sin filtro ("No incluir filtros ni '?'")
			
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