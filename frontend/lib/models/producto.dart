// Modelo que representa un producto del inventario
class Producto {
final int id;
final String nombre;
final String descripcion;
final double precio;
final int stock;
final int usuarioId;

Producto({
required this.id,
required this.nombre,
required this.descripcion,
required this.precio,
required this.stock,
required this.usuarioId,
  });

// Convierte el JSON recibido del backend en un objeto Producto
factory Producto.fromJson(Map<String,dynamic>json) {
return Producto(
			id:int.parse(json['id'].toString()),
			nombre:json['nombre'],
			descripcion:json['descripcion']??'',
			precio:double.parse(json['precio'].toString()),
			stock:int.parse(json['stock'].toString()),
			usuarioId:int.parse(json['usuario_id'].toString()),
    );
  }
}