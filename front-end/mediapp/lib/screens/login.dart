import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:proyect_views_front/AppStyles/my_text_styles.dart';
import 'package:proyect_views_front/screens/home_page.dart';
import 'package:proyect_views_front/widgets/mi_boton.dart';
import 'package:proyect_views_front/widgets/mi_campo_texto.dart';
import 'package:proyect_views_front/rest/rest_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _correoController = TextEditingController();
  final _passwordController = TextEditingController();
  
  // llamada a shared prefences
  late SharedPreferences _sharedPreferences;

  LoginScreen({super.key});

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
        color: const Color(0xFFB2E7FA),
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
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    MiCampoTexto(
                      controller: _correoController,
                      hintText: '',
                      labelText: 'Correo:',
                      tipo: 'Texto',
                    ),
                    SizedBox(height: 10),
                    MiCampoTexto(
                      controller: _passwordController,
                      hintText: '',
                      labelText: 'Contraseña:',
                      tipo: 'Contrasena',
                    ),
                  ],
                )),
            SizedBox(height: 20),
            MiBoton(
              onPressed: () {
                _correoController.text.isNotEmpty &&
                        _passwordController.text.isNotEmpty
                    ? doLogin(_correoController.text, _passwordController.text, context)
                    : Fluttertoast.showToast(
                        msg: 'Llena todos los campos', textColor: Colors.red);
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
            
          ],
        ),
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

  doLogin(String correo, String password, BuildContext context) async {
    _sharedPreferences=await SharedPreferences.getInstance();
    
    var res = await userLogin(correo.trim(), password.trim());
    
    if (res['success']) {
      String userEmail = res['user'][0]['us_Correo'];
      String userName = res['user'][0]['us_Nombre'];
      int userId = res['user'][0]['id_Usuario'];
     
      _sharedPreferences.setInt('userid', userId);
      _sharedPreferences.setString('usermail', userEmail);
      _sharedPreferences.setString('username', userName);
      Route route = MaterialPageRoute(builder: (_) => HomePage());
      Navigator.pushReplacement(context, route);
    } else {
      Fluttertoast.showToast(
          msg: 'correo y/o contraseña incorrectos', textColor: Colors.red);
    }
  }
}
