import 'package:flutter/material.dart';
import '../models/usuario.dart';
import '../services/api_service.dart';
import 'home_screen.dart';
import 'registro_screen.dart';

// Pantalla de inicio de sesión
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final correoController = TextEditingController();
  final passwordController = TextEditingController();

  bool cargando = false;

  Future<void> iniciarSesion() async {
    // Se valida que el usuario haya digitado correo y contraseña
    if (correoController.text.isEmpty || passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ingrese correo y contraseña')),
      );
      return;
    }

    setState(() {
      cargando = true;
    });

    // Se consume el servicio de login
    final respuesta = await ApiService.login(
      correo: correoController.text,
      password: passwordController.text,
    );

    setState(() {
      cargando = false;
    });

    // Si el login fue exitoso, se crea el objeto usuario y se navega al home
    if (respuesta['success'] == true) {
      Usuario usuario = ApiService.convertirUsuario(respuesta['usuario']);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(usuario: usuario),
        ),
      );
      
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(respuesta['message'])),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Iniciar sesión'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: correoController,
              decoration: const InputDecoration(labelText: 'Correo'),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Contraseña'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: cargando ? null : iniciarSesion,
              child: cargando
                  ? const CircularProgressIndicator()
                  : const Text('Ingresar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RegistroScreen(),
                  ),
                );
              },
              child: const Text('Crear cuenta'),
            ),
          ],
        ),
      ),
    );
  }
}