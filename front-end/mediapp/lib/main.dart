import 'package:flutter/material.dart';
import 'package:proyect_views_front/screens/home_page.dart';

import 'screens/bienvenida.dart'; // Importa la pantalla de bienvenida desde bienvenida.dart

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const WelcomeScreen(),
      // Definimos las rutas de navegación
      routes: {
        '/bienvenida': (context) => const BienvenidaScreen(), // Utiliza BienvenidaScreen desde bienvenida.dart
        '/home': (context) => HomePage(), // Añade la ruta para la pantalla de inicio
      },
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFB2E7FA), // Color hexadecimal #B2E7FA
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/bienvenida');
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.2), // Espacio arriba para centrar la imagen
              SizedBox(
                width: MediaQuery.of(context).size.width, // Ancho completo de la pantalla
                child: Image.asset(
                  'assets/pills4u.png', // Ruta de tu imagen de logo
                  fit: BoxFit.fitWidth, // Ajusta la imagen al ancho del contenedor
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}


