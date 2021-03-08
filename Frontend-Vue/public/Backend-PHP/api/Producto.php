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
      if (isset($_GET['idproducto'])) {
        $sql = $conexion->prepare("SELECT * FROM producto where idproducto=:idproducto");
        $sql->bindValue(':idproducto', $_GET['idproducto']);
        $sql->execute();
        header("HTTP/1.1 200 OK");
        echo json_encode($sql->fetch(PDO::FETCH_ASSOC));
        exit();
      }
      else{
        $sql = $conexion->prepare("SELECT * FROM producto");
        $sql->execute();
        $sql->setFetchMode(PDO::FETCH_ASSOC);
        header("HTTP/1.1 200 OK");
        echo json_encode( $sql->fetchAll());
        exit();
      }
  }
  if ($_SERVER['REQUEST_METHOD'] == 'POST'){
      $input = $_POST;
      $sql = "INSERT INTO producto (idcategoria, codigo, nombre, precio_venta, stock, descripcion, condicion) VALUES (:idcategoria, :codigo, :nombre, :precio_venta, :stock, :descripcion, :condicion)";
      $resultado = $conexion->prepare($sql);
      bindAllValues($resultado, $input);
      $resultado->execute();
      $id = $conexion->lastInsertId();
      if($id){
        $input['idproducto'] = $id;
        header("HTTP/1.1 200 OK");
        echo json_encode($input);
        exit();
      }
  }
  if ($_SERVER['REQUEST_METHOD'] == 'PUT'){
      $input = $_GET;
      $id = $input['idproducto'];
      $campos = getParams($input);
      $sql = "UPDATE producto SET $campos WHERE idproducto ='$id'";
      $resultado = $conexion->prepare($sql);
      bindAllValues($resultado, $input);
      $resultado->execute();
      header("HTTP/1.1 200 OK");
      exit();
  }
  if ($_SERVER['REQUEST_METHOD'] == 'DELETE'){
    $id = $_GET['idproducto'];
    $resultado = $conexion->prepare("DELETE FROM producto where idproducto=:idproducto");
    $resultado->bindValue(':idproducto', $id);
    $resultado->execute();
    header("HTTP/1.1 200 OK");
    exit();
  }
  header("HTTP/1.1 400 Peticion HTTP inexistente");

?>
