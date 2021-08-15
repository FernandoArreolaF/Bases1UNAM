<?php
//Agrgar un nuevo Cliente
//Solo lo hacemos con POST porque es más seguro
	require 'SQLGlobal.php';

	if($_SERVER['REQUEST_METHOD']=='POST'){
		try{
			$datos = json_decode(file_get_contents("php://input"),true);

			$RFC = $datos["RFC"]; //Si se debe insertar
            $PNOMBREC = $datos["PNOMBREC"];// obtener parametros POST
            $APELLIDOPC = $datos["APELLIDOPC"];
            $APELLIDOMC = $datos["APELLIDOMC"];
            $CALLEC = $datos["CALLEC"];
            $COLONIAC = $datos["COLONIAC"];
            $CPC = $datos["CPC"];
            $NUMEROCALLEC = $datos["NUMEROCALLEC"];
            $ESTADOC = $datos["ESTADOC"];
			$respuesta = SQLGlobal::cudFiltro(
				"INSERT INTO CLIENTE VALUES (?,?,?,?,?,?,?,?,?)",
				array($RFC,$PNOMBREC,$APELLIDOPC,$APELLIDOMC,$CALLEC,$COLONIAC,$CPC,$NUMEROCALLEC,$ESTADOC)
			);//con filtro ("El tamaño del array debe ser igual a la cantidad de los '?'")
			if($respuesta > 0){
                echo json_encode(array(
                    'respuesta'=>'200',
                    'estado' => 'Se inserto correctamente el cliente', 
                    'data'=>'El numero de registros afectados es: '.$respuesta,
                    'error'=>''
                ));
            }else{
                echo json_encode(array(
				    'respuesta'=>'100',
				    'estado' => 'No se inserto correctamente le cliente',
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

	//ponerle un correo de a fuerzas
	if($_SERVER['REQUEST_METHOD']=='POST'){
		try{
			$datos = json_decode(file_get_contents("php://input"),true);

			$CORREO = $datos["CORREO"]; //Si se debe insertar
           // $RFC = $datos["RFC"];// obtener parametros POST
			$respuesta = SQLGlobal::cudFiltro(
				"INSERT INTO EMAIL VALUES (?,?)",
				array($CORREO, $RFC)
			);//con filtro ("El tamaño del array debe ser igual a la cantidad de los '?'")
			if($respuesta > 0){
                echo json_encode(array(
                    'respuesta'=>'200',
                    'estado' => 'Se inserto correctamente el Correo', 
                    'data'=>'El numero de registros afectados es: '.$respuesta,
                    'error'=>''
                ));
            }else{
                echo json_encode(array(
				    'respuesta'=>'100',
				    'estado' => 'No se inserto correctamente le Correo',
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