import 'package:flutter/material.dart';
import 'package:proyect_views_front/AppStyles/my_text_styles.dart';
import 'package:proyect_views_front/widgets/mi_boton.dart';
import 'package:proyect_views_front/widgets/mi_campo_texto.dart';



class LoginScreen extends StatelessWidget {
  final correo = TextEditingController();
  final password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Inicio de Sesión',
          style: TextStyles.appBarTitle,
        ),
      ),
      body: Container(
        color: Color(0xFFB2E7FA),
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Ingresa a tu cuenta:',
              style: TextStyles.loginHeader,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            MiCampoTexto(
                  controller: correo,
                  hintText: '', 
                  labelText: 'Correo:', 
                  tipo: 'Texto',
            ),
            SizedBox(height: 10),
            MiCampoTexto(
              controller: password,
              hintText: '', 
              labelText: 'Contraseña:', 
              tipo: 'Contrasena',
            ),
            SizedBox(height: 20),
            MiBoton(
              onPressed: (){
                

              },
              texto: 'Ingresar',
              colorTexto: Colors.white, 
              colorFondo: Color(0xFF04364A),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Spacer(),
                Text(
                  '¿Olvidaste tu contraseña?',
                  style: TextStyles.forgotPassword,
                ),
              ],
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Otras maneras de login:',
                style: TextStyles.otherLoginMethods,
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildLoginMethodBox('assets/google.png'),
                buildLoginMethodBox('assets/facebook.png'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextFieldWithLabel(String labelText, String hintText) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Color(0xFFB2E7FA),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            labelText,
            style: TextStyles.labelText,
          ),
          Expanded(
            child: TextFormField(
              style: TextStyles.labelText,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildLoginMethodBox(String assetImagePath) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: Color(0xFFB2E7FA),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Color(0xFF04364A),
          width: 2,
        ),
      ),
      child: Image.asset(assetImagePath),
    );
  }
}
