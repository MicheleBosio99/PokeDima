import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AuthLoadingBar extends StatelessWidget {
  const AuthLoadingBar({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: const Center(
        child: SpinKitWave(
          color: Colors.black,
          size: 32.0,
        ),
      ),
    );
  }
}