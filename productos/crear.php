<?php
// --- 1. CABECERAS PARA EVITAR EL BLOQUEO DE CHROME (CORS) ---
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS, PUT, DELETE");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

// Responder a la petición de prueba (OPTIONS) del navegador
if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS') {
    exit(0);
}
// --- FIN DE CABECERAS ---

require_once("../config/conexion.php");

// Se valida que la petición sea POST
if ($_SERVER['REQUEST_METHOD']!=='POST') {
    echo json_encode([
        "success" =>false,
        "message" =>"Método no permitido"
    ]);
    exit;
}

// Se reciben los datos enviados
$nombre=trim($_POST['nombre']??'');
$descripcion=trim($_POST['descripcion']??'');
$precio=trim($_POST['precio']??'');
$stock=trim($_POST['stock']??'');
$usuarioId=trim($_POST['usuario_id']??'');

// Se validan los campos requeridos
if ($nombre===''||$precio===''||$stock===''||$usuarioId==='') {
    echo json_encode([
        "success" =>false,
        "message" =>"Faltan datos obligatorios"
    ]);
    exit;
}

// Se inserta el producto en la base de datos
$sql="INSERT INTO productos (nombre, descripcion, precio, stock, usuario_id) VALUES (?, ?, ?, ?, ?)";
$stmt= $conexion->prepare($sql);
$stmt->bind_param("ssdii",$nombre,$descripcion,$precio,$stock,$usuarioId);

if ($stmt->execute()) {
    echo json_encode([
        "success" =>true,
        "message" =>"Producto creado correctamente"
    ]);
} else {
    // Corregido: 'echo json_encode' (con espacio)
    echo json_encode([
        "success" =>false,
        "message" =>"No se pudo crear el producto"
    ]);
}
?>