<?php
// Este encabezado indica que la respuesta del servidor será en formato JSON
header('Content-Type: application/json');

// Datos de conexión a la base de datos
$host = "localhost";
$usuario = "root";
$password = "";
$baseDatos = "app_inventario";

// Se crea la conexión con MySQL
$conexion = new mysqli($host, $usuario, $password, $baseDatos,3307);

// Se valida si hubo error al conectar
if ($conexion->connect_error) {
    echo json_encode([
        "success" => false,
        "message" => "Error de conexión a la base de datos"
    ]);
    exit;
}

// Se define la codificación para evitar problemas con tildes y caracteres especiales
$conexion->set_charset("utf8");

?>