<?php
  include ('../db/parametros.php');

  function permisos() {
    if (isset($_SERVER['HTTP_ORIGIN'],)){
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

  $conexion =  Conectar($db);
  if ($_SERVER['REQUEST_METHOD'] == 'GET'){
      if (isset($_GET['id'])) {
        $sql = $conexion->prepare("SELECT * FROM heladeria.trabajador idtrabajador=:idtrabajador");
        $sql->bindValue(':idtrabajador', $_GET['id']);
        $sql->execute();
        header("HTTP/1.1 200 OK");
        echo json_encode($sql->fetch(PDO::FETCH_ASSOC));
        exit();
      }
      else{
        $sql = $conexion->prepare("SELECT * FROM heladeria.trabajador");
        $sql->execute();
        $sql->setFetchMode(PDO::FETCH_ASSOC);
        header("HTTP/1.1 200 OK");
        echo json_encode( $sql->fetchAll());
        exit();
      }
  }


  if ($_SERVER['REQUEST_METHOD'] == 'POST'){
      $input = $_POST;
      $sql = "INSERT INTO heladeria.trabajador (nombre, tipo_documento, num_documento, direccion, telefono, email, password_hash, condicion)
              VALUES (:nombre, :tipo_documento, :num_documento, :direccion, :telefono, :email, password_hash, :condicion)";
      $resultado = $conexion->prepare($sql);
      bindAllValues($resultado, $input);
      $resultado->execute();
      $id = $conexion->lastInsertId();
      if($id){
        $input['idtrabajador'] = $id;
        header("HTTP/1.1 200 OK");
        echo json_encode($input);
        exit();
      }
  }
  if ($_SERVER['REQUEST_METHOD'] == 'PUT'){
      $input = $_GET;
      $id = $input['idtrabajador'];
      $campos = getParams($input);
      $sql = "UPDATE heladeria.trabajador SET $campos WHERE idtrabajador ='$id'";
      $resultado = $conexion->prepare($sql);
      bindAllValues($resultado, $input);
      $resultado->execute();
      header("HTTP/1.1 200 OK");
      exit();
  }
  if ($_SERVER['REQUEST_METHOD'] == 'DELETE'){
    $id = $_GET['idtrabajador'];
    $resultado = $conexion->prepare("DELETE FROM heladeria.trabajador WHERE idtrabajador=:idtrabajador");
    $resultado->bindValue(':idtrabajador', $id);
    $resultado->execute();
    header("HTTP/1.1 200 OK");
    exit();
  }
  header("HTTP/1.1 400 Peticion HTTP inexistente");

?>
