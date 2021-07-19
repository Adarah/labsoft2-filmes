import 'package:flutter/material.dart';

import 'sign_in_form.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Card(
        child: Column(
          children: [
            Text('Entrar'),
            Text('Informe seu email e sua senha ou entre com sua rede social favorita'),
            SignInForm(),
          ],
        ),

      ),
    );
  }
}
