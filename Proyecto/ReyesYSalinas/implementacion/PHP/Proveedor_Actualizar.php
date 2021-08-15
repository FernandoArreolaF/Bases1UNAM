<?php
//Actalizacion de Proveedores, todo funciona bien
	require 'SQLGlobal.php';

	if($_SERVER['REQUEST_METHOD']=='POST'){
		try{
			$datos = json_decode(file_get_contents("php://input"),true);

			$RAZONSOCIAL = $datos["RAZONSOCIAL"]; //obtener parametros POST
            $PNOMBREP = $datos["PNOMBREP"];
            $APELLIDOPP = $datos["APELLIDOPP"];
            $APELLIDOMP = $datos["APELLIDOMP"];
            $CALLEP = $datos["CALLEP"];
            $COLONIAP = $datos["COLONIAP"];
            $CPP = $datos["CPP"];
            $NUMEROCALLEP = $datos["NUMEROCALLEP"];
            $ESTADOP = $datos["ESTADOP"];
			$respuesta = SQLGlobal::cudFiltro(
				"UPDATE PROVEEDOR SET  PNOMBREP= ?, APELLIDOPP = ?, APELLIDOMP = ?, CALLEP = ?, COLONIAP = ?, CPP = ?, NUMEROCALLEP = ?, ESTADOP =? WHERE RAZONSOCIAL = ?",
				array($PNOMBREP, $APELLIDOPP, $APELLIDOMP, $CALLEP, $COLONIAP, $CPP, $NUMEROCALLEP, $ESTADOP, $RAZONSOCIAL)
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