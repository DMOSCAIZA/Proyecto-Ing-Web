<?php
/*
include ('../db/conexion.php');

$email = $_POST['email'];
$contraseña = $_POST['password_hash'];

session_start();
$_SESSION['email'] = $email;

$consulta = "SELECT * FROM trabajadores WHERE email = '$email' AND password_hash='$contraseña'";
$resultado = mysqli_query($db,$consulta);

$filas = mysqli_num_rows($resultado);

mysqli_free_result($resultado);
mysqli_close($conexion);

*/
//--------------------------------------------------------------------------------------------------

$login;


try{

	$login=htmlentities(addslashes($_POST["login"]));
	$password=htmlentities(addslashes($_POST["password"]));

	$base=new PDO("mysql:host=localhost; dbname=pruebas" , "root", "");

	$base->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

	$sql="SELECT * FROM USUARIOS_PASS WHERE USUARIOS= :login";

	$resultado=$base->prepare($sql);

	$resultado->execute(array(":login"=>$login));

		while($registro=$resultado->fetch(PDO::FETCH_ASSOC)){
			echo "Usuario: " . $registro['USUARIOS'] . " Contraseña: " . $registro['PASSWORD'] . "<br>";
		}
		$resultado->closeCursor();

}catch(Exception $e){
	die("Error: ".$e->getMessage());
}

?>













