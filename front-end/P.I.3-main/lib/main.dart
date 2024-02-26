import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:proyect_views_front/bienvenida.dart'; // Importa la pantalla de bienvenida desde bienvenida.dart
import 'login.dart'; // Importa la pantalla de inicio de sesión desde login.dart

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // Para hacer la barra de estado transparente
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WelcomeScreen(),
      // Definimos las rutas de navegación
      routes: {
        '/bienvenida': (context) => BienvenidaScreen(), // Utiliza BienvenidaScreen desde bienvenida.dart
      },
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFB2E7FA), // Color hexadecimal #B2E7FA
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
              Container(
                width: MediaQuery.of(context).size.width, // Ancho completo de la pantalla
                child: Image.asset(
                  'assets/pills4u.png', // Ruta de tu imagen de logo
                  fit: BoxFit.fitWidth, // Ajusta la imagen al ancho del contenedor
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
