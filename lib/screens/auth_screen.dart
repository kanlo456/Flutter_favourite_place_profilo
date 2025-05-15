import 'package:favorite_places/service/local_auth_service.dart' as auth;
import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Call the biometrics authentication method
            auth.authenticateWithBiometrics(context);
          },
          child: const Text('Please do the authenticaion'),
        ),
      ),
    );
  }
}
