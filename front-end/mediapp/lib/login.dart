import 'package:flutter/material.dart';

class AppStyles {
  static final TextStyle appBarTitle = TextStyle(
    fontWeight: FontWeight.w900,
    fontFamily: 'Raleway',
  );

  static final TextStyle loginHeader = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w900,
    fontFamily: 'Raleway',
  );

  static final TextStyle labelText = TextStyle(
    color: Color(0xFF04364A),
    fontWeight: FontWeight.w900,
    fontSize: 16,
    fontFamily: 'Raleway',
  );

  static final TextStyle loginButton = TextStyle(
    fontWeight: FontWeight.w900,
    fontFamily: 'Raleway',
  );

  static final TextStyle forgotPassword = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w900,
    color: Color(0xFF04364A),
    fontFamily: 'Raleway',
  );

  static final TextStyle otherLoginMethods = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w900,
    color: Color(0xFF04364A),
    fontFamily: 'Raleway',
  );
}

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Inicio de Sesión',
          style: AppStyles.appBarTitle,
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
              'Login to your account:',
              style: AppStyles.loginHeader,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            buildTextFieldWithLabel('Correo electrónico:', ''),
            SizedBox(height: 10),
            buildTextFieldWithLabel('Contraseña:', ''),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF04364A),
                onPrimary: Colors.white,
              ),
              child: Text(
                'LOGIN',
                style: AppStyles.loginButton,
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Spacer(),
                Text(
                  '¿Olvidaste tu contraseña?',
                  style: AppStyles.forgotPassword,
                ),
              ],
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Otras maneras de login:',
                style: AppStyles.otherLoginMethods,
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
            style: AppStyles.labelText,
          ),
          Expanded(
            child: TextFormField(
              style: AppStyles.labelText,
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
