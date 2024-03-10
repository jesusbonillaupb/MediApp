import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:proyect_views_front/bienvenida.dart'; // Importa la pantalla de bienvenida desde bienvenida.dart


void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // Para hacer la barra de estado transparente
  ));
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
            // Navegamos a la pantalla de bienvenida al hacer clic en la pantalla
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