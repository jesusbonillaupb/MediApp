import 'package:flutter/material.dart';
import 'login.dart'; // Importa la pantalla de inicio de sesión desde login.dart
import 'registro.dart'; // Importa la pantalla de registro desde registro.dart

void main() {
  runApp(BienvenidaScreen());
}

class BienvenidaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Raleway', // Establece la fuente Raleway para toda la aplicación
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => WelcomeScreen(),
        '/login': (context) => LoginScreen(),
        '/registro': (context) => RegistroScreen(),
      },
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFB2E7FA), // Fondo color B2E7FA
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: Container(
              color: Colors.white, // Fondo color blanco
              alignment: Alignment.center,
              child: Image.asset(
                'assets/pills4u.png', // Ruta de tu imagen de logo
                height: 200,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFB2E7FA), // Fondo color B2E7FA
                borderRadius: BorderRadius.vertical(top: Radius.circular(35)),
              ),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      '¡Bienvenido a nuestra App!',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Una breve descripción de la aplicación y sus funcionalidades.',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: () {
                        // Redirige a la pantalla de inicio de sesión
                        Navigator.pushNamed(context, '/login');
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFF04364A), // Fondo color 04364A
                        onPrimary: Colors.white, // Texto blanco
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child: Text(
                          'Iniciar Sesión',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    OutlinedButton(
                      onPressed: () {
                        // Redirige a la pantalla de registro
                        Navigator.pushNamed(context, '/registro');
                      },
                      style: OutlinedButton.styleFrom(
                        primary: Color(0xFFB2E7FA), // Color del fondo
                        side: BorderSide(width: 2, color: Colors.black), // Borde del botón
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child: Text(
                          'Registrarse',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black, // Texto color negro
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


