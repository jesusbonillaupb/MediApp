import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  late SharedPreferences _prefs;
  String _userName = ''; // Variable para almacenar el nombre de usuario

  @override
  void initState() {
    super.initState();
    _initSharedPreferences();
  }

  // Método para inicializar SharedPreferences y recuperar el nombre de usuario
  void _initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _userName = _prefs.getString('username') ?? ''; // Recupera el nombre de usuario, si existe
    });
  }

  // Método para eliminar los datos de sesión y redirigir a la pantalla de inicio
  void _logout() {
    _prefs.clear(); // Borra todos los datos guardados en SharedPreferences
    Navigator.popUntil(context, ModalRoute.withName('/')); // Redirige a la pantalla de bienvenida
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
          child: Center(
            child: Text(
              'Bienvenido $_userName', // Mostrar el nombre de usuario en el texto
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
