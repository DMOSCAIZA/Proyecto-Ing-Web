<?php
    class Conexion{
        public static function Conectar(){
            define('servidor', 'localhost');
            define('nombre_bd', 'heladeria');
            define('usuario', 'root');
            define('password', '');
            define('puerto','33065');
            $opciones = array(PDO::MYSQL_ATTR_INIT_COMMAND => 'SET NAMES \'utf8\'');			
            try{
                $conexion = new PDO(
                    "mysql:host=".servidor.
                    "; port=".puerto.
                    "; dbname=".nombre_bd, usuario, password, $opciones);
                return $conexion;                    
            }catch (Exception $e){
                die("El error de Conexión es: ". $e->getMessage());
            }
        }
    }
?>