import 'package:favorite_places/screens/places.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

final LocalAuthentication auth = LocalAuthentication();

Future<bool> authenticateWithBiometrics(context) async {
  final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;

  if (canAuthenticateWithBiometrics) {
    try {
      final bool isAuthenticated = await auth.authenticate(
        localizedReason: 'Please authenticate to unlock your places',
        options: const AuthenticationOptions(
          biometricOnly: true,
        ),
      );

      if (isAuthenticated) {
        print('Authenticated successfully!');
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => const PlacesScreen(),
          ),
        );
        return true;
      } else {
        print('Authentication failed!');
      }
    } on PlatformException catch (e) {
      print(e);
      return false;
    }
  } else {
    print('Biometric authentication is not available.');
    return false;
  }

  return false;
}
