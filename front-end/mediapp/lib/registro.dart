import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:proyect_views_front/AppStyles/my_text_styles.dart';

import 'package:proyect_views_front/rest/rest_api.dart';
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  //bool _termsAccepted = false;

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
              Form(
                key: _formKey,
                child: Column(
                  children:[
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
                  ]) ,
              ),
              /* Row(
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
              ),*/
              const SizedBox(height: 10),
              const SizedBox(height: 20),
              MiBoton(
                onPressed: () {
                  
                  nombre.text.isNotEmpty &&
                  password.text.isNotEmpty &&
                  edad.text.isNotEmpty &&
                  correo.text.isNotEmpty &&
                  celular.text.isNotEmpty &&
                  rol.text.isNotEmpty
                  ? doRegister(
                    nombre.text,password.text,correo.text,celular.text,edad.text,rol.text)
                  : Fluttertoast.showToast(
                      msg: 'Llena todos los campos',
                      textColor: Colors.red);
                },
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
  
  doRegister(String nombre , String password, String correo, String celular, String edad, String rol) async {
    int edadCorregida = int.parse(edad);
    int rolCorregido= 0;
    if (rol == 'Paciente'){
      rolCorregido= 1;
    }else{
      rolCorregido=2;
    }
    
    var res=await userRegister(nombre, password, correo, celular, edadCorregida, rolCorregido);
    if(res['success']){
      Fluttertoast.showToast(msg: 'Registro exitoso, vuelva al inicio',textColor: Colors.green);
    }
    else{
      Fluttertoast.showToast(msg: 'fallo al registrarse, intentalo denuevo',textColor: Colors.red);
    } 
    

  }
}
