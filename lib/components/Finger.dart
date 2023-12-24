import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class Authentication {
  bool _authSuccess = false;
  LocalAuthentication localAuthentication = LocalAuthentication();
  Future<bool> auth(BuildContext context) async {
    _authSuccess = false;
    if (await localAuthentication.canCheckBiometrics == false) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Your device is not compatible with biometrics.'),
        ),
      );
      return false;
    }
    try {
      final authSuccess = await localAuthentication.authenticate(
          localizedReason: 'Authenticate to login');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('authSuccess=$authSuccess')),
      );
      return authSuccess;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
      return false;
    }
  }
}
