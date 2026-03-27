import 'package:flutter/material.dart';
import '../models/usuario.dart';
import 'login_screen.dart';
import 'productos_screen.dart';

// Pantalla principal luego del inicio de sesión
class HomeScreen extends StatelessWidget {
  final Usuario usuario;

  const HomeScreen({super.key, required this.usuario});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text('Bienvenido, ${usuario.nombre}'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navega a la pantalla de productos y envía el usuario autenticado
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductosScreen(usuario: usuario),
                  ),
                );
              },
              child: const Text('Gestionar productos'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Cierra sesión regresando al login
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                  (route) => false,
                );
              },
              child: const Text('Cerrar sesión'),
            ),
          ],
        ),
      ),
    );
  }
}