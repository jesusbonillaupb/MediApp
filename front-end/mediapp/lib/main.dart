import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'bienvenida.dart'; // Importa la pantalla de bienvenida desde bienvenida.dart

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

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    _initSharedPreferences();
  }

  // Método para inicializar SharedPreferences
  void _initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Método para eliminar los datos de sesión y volver a la pantalla principal
  void _logout() {
    _prefs.clear(); // Borra todos los datos guardados en SharedPreferences
    Navigator.popUntil(context, ModalRoute.withName('/')); // Regresa a la pantalla principal del main.dart
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _logout, // Llama al método _logout al hacer clic en el botón de logout
          ),
        ],
      ),
      body: Container(
        color: const Color(0xFFB2E7FA),
        child: const Center(
          child: Text(
            'Welcome to Home',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  
  }
}
