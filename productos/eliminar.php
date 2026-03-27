<?php
// --- 1. CABECERAS PARA PERMITIR LA ELIMINACIÓN DESDE LA WEB (CORS) ---
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS, PUT, DELETE");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

// Responder a la petición de prueba (OPTIONS)
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

// Se recibe el id del producto
$id=trim($_POST['id']??'');

// Se valida que venga el id
if ($id==='') {
    // Corregido: echo json_encode (con espacio)
    echo json_encode([
        "success" =>false,
        "message" =>"El id del producto es obligatorio"
    ]);
    exit;
}

// Se elimina el producto indicado
$sql="DELETE FROM productos WHERE id = ?";
$stmt= $conexion->prepare($sql);
$stmt->bind_param("i",$id);

if ($stmt->execute()) {
    echo json_encode([
        "success" =>true,
        "message" =>"Producto eliminado correctamente"
    ]);
} else {
    // Corregido: echo json_encode (con espacio)
    echo json_encode([
        "success" =>false,
        "message" =>"No se pudo eliminar el producto"
    ]);
}
?>