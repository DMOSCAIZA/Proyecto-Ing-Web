<?php
    include_once './conexion.php';
    $objeto = new Conexion();
    $conexion = $objeto->Conectar();

    $_POST = json_decode(file_get_contents("php://input"), true);

    function permisos() {  
      if (isset($_SERVER['HTTP_ORIGIN'])){
          header("Access-Control-Allow-Origin: *");
          header("Access-Control-Allow-Methods: GET, POST, PATCH, PUT, DELETE, OPTIONS");
          header("Access-Control-Allow-Headers: Origin, Authorization, X-Requested-With, Content-Type, Accept");
          header('Access-Control-Allow-Credentials: true');      
      }  
      if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS'){
        if (isset($_SERVER['HTTP_ACCESS_CONTROL_REQUEST_METHOD']))          
            header("Access-Control-Allow-Methods: GET, POST, PATCH, PUT, DELETE, OPTIONS");
        if (isset($_SERVER['HTTP_ACCESS_CONTROL_REQUEST_HEADERS']))
            header("Access-Control-Allow-Headers: Origin, Authorization, X-Requested-With, Content-Type, Accept");
        exit(0);
      }
    }
    permisos();

    $opcion = (isset($_POST['opcion'])) ? $_POST['opcion'] : '';
    $idcategoria = (isset($_POST['idcategoria'])) ? $_POST['idcategoria'] : '';
    $nombre = (isset($_POST['nombre'])) ? $_POST['nombre'] : '';
    $descripcion = (isset($_POST['descripcion'])) ? $_POST['descripcion'] : '';
    $condicion = (isset($_POST['condicion'])) ? $_POST['condicion'] : '';


    //CRUD
    switch($opcion){
        //CREATE
    	case 1:
            $consulta = "SELECT idcategoria, nombre, descripcion, condicion FROM categoria";
            $resultado = $conexion->prepare($consulta);
            $resultado->execute();
            $data=$resultado->fetchAll(PDO::FETCH_ASSOC);
            break;
        //READ
        case 2:
            $consulta = "INSERT INTO categoria (nombre, descripcion, condicion) VALUES('$nombre', '$descripcion', '$condicion') ";
            $resultado = $conexion->prepare($consulta);
            $resultado->execute();                
            break;
        //UPDATE
        case 3:
            $consulta = "UPDATE categoria SET nombre='$nombre', descripcion='$descripcion', condicion='$condicion' WHERE id='$idcategoria' ";		
            $resultado = $conexion->prepare($consulta);
            $resultado->execute();                        
            $data=$resultado->fetchAll(PDO::FETCH_ASSOC);
            break;
        //DELETE        
        case 4:
            $consulta = "DELETE FROM categoria WHERE id='$idcategoria' ";		
            $resultado = $conexion->prepare($consulta);
            $resultado->execute();                           
            break;         
    }

    print json_encode($data, JSON_UNESCAPED_UNICODE);
    $conexion = NULL;

?>