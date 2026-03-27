// Modelo que representa un usuario dentro de la aplicación
class Usuario {
final int id;
final String nombre;
final String correo;

Usuario({
	required this.id,
	required this.nombre,
	required this.correo,
});

// Convierte un JSON recibido desde la API a un objeto Usuario
factory Usuario.fromJson(Map<String,dynamic>json) {
return Usuario(
        id:int.parse(json['id'].toString()),
        nombre:json['nombre'],
        correo:json['correo'],
    );
  }
}