import 'package:flutter/material.dart';
import '../models/producto.dart';
import '../models/usuario.dart';
import '../services/api_service.dart';

// Pantalla usada tanto para crear como para editar productos
class ProductoFormScreen extends StatefulWidget {
  final Usuario usuario;
  final Producto? producto;

  const ProductoFormScreen({
    super.key,
    required this.usuario,
    this.producto,
  });

  @override
  State<ProductoFormScreen> createState() => _ProductoFormScreenState();
}

class _ProductoFormScreenState extends State<ProductoFormScreen> {
  final nombreController = TextEditingController();
  final descripcionController = TextEditingController();
  final precioController = TextEditingController();
  final stockController = TextEditingController();

  bool cargando = false;

  @override
  void initState() {
    super.initState();

    // Si llega un producto, significa que estamos en modo edición
    if (widget.producto != null) {
      nombreController.text = widget.producto!.nombre;
      descripcionController.text = widget.producto!.descripcion;
      precioController.text = widget.producto!.precio.toString();
      stockController.text = widget.producto!.stock.toString();
    }
  }

  Future<void> guardarProducto() async {
    if (nombreController.text.isEmpty ||
        precioController.text.isEmpty ||
        stockController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Complete los campos obligatorios')),
      );
      return;
    }

    setState(() {
      cargando = true;
    });

    Map<String, dynamic> respuesta;

    // Si no hay producto, se crea uno nuevo
    if (widget.producto == null) {
      respuesta = await ApiService.crearProducto(
        nombre: nombreController.text,
        descripcion: descripcionController.text,
        precio: precioController.text,
        stock: stockController.text,
        usuarioId: widget.usuario.id,
      );
    } else {
      // Si sí hay producto, se actualiza
      respuesta = await ApiService.actualizarProducto(
        id: widget.producto!.id,
        nombre: nombreController.text,
        descripcion: descripcionController.text,
        precio: precioController.text,
        stock: stockController.text,
      );
    }

    setState(() {
      cargando = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(respuesta['message'])),
    );

    if (respuesta['success'] == true) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final esEdicion = widget.producto != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(esEdicion ? 'Editar producto' : 'Nuevo producto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nombreController,
              decoration: const InputDecoration(labelText: 'Nombre'),
            ),
            TextField(
              controller: descripcionController,
              decoration: const InputDecoration(labelText: 'Descripción'),
            ),
            TextField(
              controller: precioController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Precio'),
            ),
            TextField(
              controller: stockController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Stock'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: cargando ? null : guardarProducto,
              child: cargando
                  ? const CircularProgressIndicator()
                  : Text(esEdicion ? 'Actualizar' : 'Guardar'),
            ),
          ],
        ),
      ),
    );
  }
}