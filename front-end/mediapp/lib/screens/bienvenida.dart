import 'package:flutter/material.dart';
import 'login.dart'; // Importa la pantalla de inicio de sesión desde login.dart
import 'registro.dart'; // Importa la pantalla de registro desde registro.dart

void main() {
  runApp(const BienvenidaScreen());
}

class BienvenidaScreen extends StatelessWidget {
  const BienvenidaScreen({super.key});

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
        '/': (context) => const WelcomeScreen(),
        '/login': (context) =>  LoginScreen(),
        '/registro': (context) => RegistroScreen(),
      },
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFB2E7FA), // Fondo color B2E7FA
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
              decoration: const BoxDecoration(
                color: Color(0xFFB2E7FA), // Fondo color B2E7FA
                borderRadius: BorderRadius.vertical(top: Radius.circular(35)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Bienvenido',
                      style: TextStyle(
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Ingresa para llevar control de tus medicamentos y horarios.',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: () {
                        // Redirige a la pantalla de inicio de sesión
                        Navigator.pushNamed(context, '/login');
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white, backgroundColor: const Color(0xFF04364A), // Texto blanco
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child: Text(
                          'Iniciar Sesión',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    OutlinedButton(
                      onPressed: () {
                        // Redirige a la pantalla de registro
                        Navigator.pushNamed(context, '/registro');
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFFB2E7FA), side: const BorderSide(width: 2, color: Colors.black), // Borde del botón
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Padding(
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


