import 'package:app/components/form_button.dart';
import 'package:app/components/social_login.dart';
import 'package:app/modules/auth/auth_service.dart';
import 'package:app/modules/auth/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class SignInForm extends StatefulWidget with Validator {
  const SignInForm({Key? key}) : super(key: key);

  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _emailControler;
  late TextEditingController _passwordControler;

  @override
  void initState() {
    super.initState();
    _emailControler = TextEditingController();
    _passwordControler = TextEditingController();
  }

  @override
  void dispose() {
    _emailControler.dispose();
    _passwordControler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _authService = Provider.of<AuthService>(context, listen: false);
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: _emailControler,
            // autofocus: true,
            validator: widget.validateEmail,
            decoration: const InputDecoration(
              labelText: 'Email',
              prefixIcon: Icon(Icons.email_outlined),
            ),
          ),
          TextFormField(
            controller: _passwordControler,
            decoration: const InputDecoration(
              labelText: 'Senha',
              prefixIcon: Icon(Icons.password),
            ),
            obscureText: true,
          ),
          TextButton(
            onPressed: () {},
            child: Text(
              'Esqueceu sua senha?',
              style: TextStyle(
                color: Colors.grey,
              )
            ),
          ),
          SocialLoginButtonRow(),
          FormButton(
            text: 'ENTRAR',
            onPressed: () {
              final _email = _emailControler.text;
              final _password = _passwordControler.text;
              _authService.signInWithEmailAndPassword(_email, _password);
            },
          ),
          OutlinedButton(
            onPressed: () {
            },
            child: Text('Ainda não é cadastrado? Clique aqui'),
          ),
        ],
      ),
    );
  }
}
