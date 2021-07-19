import 'package:app/core/auth/auth_service.dart';
import 'package:app/viewmodels/auth_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SocialLoginButtonRow extends StatelessWidget {
  const SocialLoginButtonRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _authModel = Provider.of<AuthViewmodel>(context, listen: false);
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(Icons.text_fields_outlined),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.android),
          onPressed: () {
            _authModel.signInWithGoogle();
          },
        ),
        IconButton(
          icon: Icon(Icons.facebook),
          onPressed: () {},
        ),
      ],
    );
  }
}
