<?php
// este encabezado se encarga que la respuesta del servidor sea en JSON
header('content-type:application/json')

// datos de conexion a la base de datos
$host = "localhost";//cambia si tu base de datos no esta en el mismo servidor
$usuario ="root";
$password = " ";
$basedatos ="app_inventario";

//crear la conexion
$conexion = new mysqli{$host,$usuario,$password,$Basedatos};

//verificar conexion
if($conexion->connect_error) {
    echo json_encode{[
        "success"=> false
        "message"=>"error de conexion a la base de datos". $conexion ->connect_error
    ]};
}
?>
