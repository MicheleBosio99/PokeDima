import 'package:flutter/material.dart';
import 'package:pokedex_dima_new/presentation/tablet/pages/authentication/register_tablet.dart';
import 'package:pokedex_dima_new/presentation/tablet/pages/authentication/sign_in_tablet.dart';

class AuthenticateTablet extends StatefulWidget {

  const AuthenticateTablet({ super.key });

  @override
  _AuthenticateTabletState createState() => _AuthenticateTabletState();
}

class _AuthenticateTabletState extends State<AuthenticateTablet> {

  bool showSignIn = true;
  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignInTablet(toggleView: toggleView);
    } else {
      return RegisterTablet(toggleView: toggleView);
    }
  }
}