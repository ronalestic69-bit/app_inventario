<?php
// --- 1. CABECERAS PARA PERMITIR ACCESO DESDE FLUTTER WEB ---
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS, PUT, DELETE");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS') {
    exit(0);
}
// --- FIN DE CABECERAS ---

require_once("../config/conexion.php");

// Consulta todos los productos con sus datos principales
$sql="SELECT id, nombre, descripcion, precio, stock, usuario_id FROM productos ORDER BY id DESC";
$resultado= $conexion->query($sql);

$productos= [];

// Se recorren los resultados y se agregan a un arreglo
while ($fila= $resultado->fetch_assoc()) {
    $productos[]=$fila;
}

// Se devuelve la lista en formato JSON
echo json_encode([
    "success" =>true,
    "productos" =>$productos
]);
?>