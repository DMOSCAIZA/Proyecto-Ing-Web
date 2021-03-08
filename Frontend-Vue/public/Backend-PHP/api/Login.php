<?php

$email = $_POST['email'];
$contraseña = $_POST['password_hash'];

session_start();
$_SESSION['email'] = $email;

include ('../db/conexion.php');
include ('../db/datosConexion.php');

$consulta = "SELECT * FROM trabajadores WHERE email = '$email' AND password_hash='$contraseña'";
$resultado = mysqli_query($db,$consulta);

$filas = mysqli_num_rows($resultado);

if($filas){
  header('location:home');
}


?>
