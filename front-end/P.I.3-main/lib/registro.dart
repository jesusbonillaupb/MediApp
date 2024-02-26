import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(RegistroScreen());
}

class RegistroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Formulario de Registro',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Raleway',
      ),
      home: RegistrationForm(),
    );
  }
}

class RegistrationForm extends StatefulWidget {
  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  bool _termsAccepted = false;
  String? _selectedRole;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Formulario de Registro',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        color: Color(0xFFB2E7FA), // Color hexadecimal #B2E7FA
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Texto "Create account" al principio del formulario
                Text(
                  'Create account',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                // Aquí comienza el formulario
                buildTextFieldWithLabel('Nombre:', ''),
                SizedBox(height: 10),
                // Agregar más campos de TextFormField con el mismo estilo
                buildPasswordFieldWithLabel('Contraseña:'),
                SizedBox(height: 10),
                // Agregar más campos de TextFormField con el mismo estilo
                buildTextFieldWithLabel('Edad:', ''),
                SizedBox(height: 10),
                buildTextFieldWithLabel('Email:', ''),
                SizedBox(height: 10),
                buildPhoneNumberFieldWithLabel('Celular:', '+57'),
                SizedBox(height: 10),
                buildRoleFieldWithLabel('Rol:', ['Cuidador', 'Paciente']),
                SizedBox(height: 10),
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
                    Text(
                      'Aceptar términos y condiciones',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Acción al presionar el botón de "Sign Up"
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF04364A), // Color hexadecimal #04364A
                    onPrimary: Colors.white, // Texto blanco
                  ),
                  child: Text(
                    'Sign Up',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextFieldWithLabel(String labelText, String hintText) {
    return Stack(
      children: [
        Container(
          height: 40,
          decoration: BoxDecoration(
            color: Color(0xFFB2E7FA),
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                labelText,
                style: TextStyle(
                  color: Color(0xFF04364A), // Color hexadecimal #04364A
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Expanded(
                child: TextFormField(
                  style: TextStyle(
                    color: Color(0xFF04364A), // Color hexadecimal #04364A
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: hintText,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildPasswordFieldWithLabel(String labelText) {
    return Stack(
      children: [
        Container(
          height: 40,
          decoration: BoxDecoration(
            color: Color(0xFFB2E7FA),
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                labelText,
                style: TextStyle(
                  color: Color(0xFF04364A), // Color hexadecimal #04364A
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Expanded(
                child: TextFormField(
                  style: TextStyle(
                    color: Color(0xFF04364A), // Color hexadecimal #04364A
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  obscureText: true, // Oculta los caracteres de la contraseña
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildPhoneNumberFieldWithLabel(String labelText, String prefix) {
    return Stack(
      children: [
        Container(
          height: 40,
          decoration: BoxDecoration(
            color: Color(0xFFB2E7FA),
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                labelText,
                style: TextStyle(
                  color: Color(0xFF04364A), // Color hexadecimal #04364A
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Expanded(
                child: TextFormField(
                  style: TextStyle(
                    color: Color(0xFF04364A), // Color hexadecimal #04364A
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  keyboardType: TextInputType.phone, // Permite solo números
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly], // Acepta solo dígitos
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixText: prefix,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildRoleFieldWithLabel(String labelText, List<String> roles) {
    return Stack(
      children: [
        Container(
          height: 40,
          decoration: BoxDecoration(
            color: Color(0xFFB2E7FA),
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                labelText,
                style: TextStyle(
                  color: Color(0xFF04364A), // Color hexadecimal #04364A
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              DropdownButton<String>(
                value: _selectedRole,
                items: roles.map((String role) {
                  return DropdownMenuItem<String>(
                    value: role,
                    child: Text(
                      role,
                      style: TextStyle(
                        color: Color(0xFF04364A), // Color hexadecimal #04364A
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    _selectedRole = value;
                  });
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
