import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:proyect_views_front/AppStyles/my_text_styles.dart';
import 'package:proyect_views_front/widgets/mi_boton.dart';
import 'package:proyect_views_front/widgets/mi_campo_texto.dart';

void main() {
  runApp(const RegistroScreen());
}

class RegistroScreen extends StatelessWidget {
  const RegistroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Formulario de Registro',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Raleway',
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Formulario de Registro',
            style: TextStyles.appBarTitle,
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back), // Icono de retroceso
            onPressed: () {
              Navigator.pop(context); // Regresa a la pantalla anterior
            },
          ),
        ),
        body: const RegistrationForm(),
      ),
    );
  }
}

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final nombre = TextEditingController();
  final password = TextEditingController();
  final edad = TextEditingController();
  final correo = TextEditingController();
  final celular = TextEditingController();
  final rol = TextEditingController();
  bool _termsAccepted = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFB2E7FA), // Color hexadecimal #B2E7FA
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Crea una cuenta',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              // Aquí comienza el formulario
              MiCampoTexto(
                controller: nombre,
                hintText: '',
                labelText: 'Nombre:',
                tipo: 'Texto',
              ),
              const SizedBox(height: 10),
              MiCampoTexto(
                controller: password,
                hintText: '',
                labelText: 'Contraseña:',
                tipo: 'Contrasena',
              ),
              const SizedBox(height: 10),
              MiCampoTexto(
                controller: edad,
                hintText: '',
                labelText: 'Edad:',
                tipo: 'Edad',
              ),
              const SizedBox(height: 10),
              MiCampoTexto(
                controller: correo,
                hintText: '',
                labelText: 'Correo:',
                tipo: 'Texto',
              ),
              const SizedBox(height: 10),
              MiCampoTexto(
                controller: celular,
                hintText: '',
                labelText: 'Celular:',
                tipo: 'Celular',
              ),
              const SizedBox(height: 10),
              MiCampoTexto(
                controller: rol,
                hintText: '',
                labelText: 'Rol:',
                opciones: ['Cuidador', 'Paciente'],
                tipo: 'Seleccion',
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Checkbox(
                    value: _termsAccepted,
                    onChanged: (bool? value) {
                      setState(() {
                        _termsAccepted = value!;
                      });
                    },
                  ),
                  const Text(
                    'Aceptar términos y condiciones',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const SizedBox(height: 20),
              MiBoton(
                onPressed: () {},
                texto: 'Registrar',
                colorTexto: Colors.white,
                colorFondo: Color(0xFF04364A),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
