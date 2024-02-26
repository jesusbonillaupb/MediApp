import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Inicio de Sesión',
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
                // Texto "Log In" al principio del formulario
                Text(
                  'Login to your account:',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                // Aquí comienza el formulario
                buildTextFieldWithLabel('Correo electrónico:', ''),
                SizedBox(height: 10),
                // Agregar más campos de TextFormField con el mismo estilo
                buildTextFieldWithLabel('Contraseña:', ''),
                SizedBox(height: 10),
                // Agregar más campos de TextFormField con el mismo estilo
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Acción al presionar el botón de "Log In"
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF04364A), // Color hexadecimal #04364A
                    onPrimary: Colors.white, // Texto blanco
                  ),
                  child: Text(
                    'Log In',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 20), // Espacio entre el botón y el campo de texto de "Olvidaste tu contraseña"
                Text(
                  '¿Olvidaste tu contraseña?',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF04364A), // Color hexadecimal #04364A
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20), // Espacio entre el texto de "Olvidaste tu contraseña" y "Otras maneras de login"
                Text(
                  'Otras maneras de login:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF04364A), // Color hexadecimal #04364A
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20), // Espacio entre el texto y las cajas de login
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Caja para ingresar mediante Google
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Color(0xFFB2E7FA), // Color hexadecimal #B2E7FA
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: Color(0xFF04364A), // Color hexadecimal #04364A
                          width: 3,
                        ),
                      ),
                      child: Image.asset('assets/google.png'), // Aquí colocas el logo de Google
                    ),
                    // Caja para ingresar mediante Facebook
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Color(0xFFB2E7FA), // Color hexadecimal #B2E7FA
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: Color(0xFF04364A), // Color hexadecimal #04364A
                          width: 3,
                        ),
                      ),
                      child: Image.asset('assets/facebook.png'), // Aquí colocas el logo de Facebook
                    ),
                  ],
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
}
