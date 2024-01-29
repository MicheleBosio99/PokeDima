import 'package:flutter/material.dart';
import 'package:pokedex_dima_new/application/auth_services/auth_service.dart';
import 'package:pokedex_dima_new/presentation/widgets/auth_loading_bar.dart';
import 'package:pokedex_dima_new/presentation/widgets/auth_button.dart';
import 'package:pokedex_dima_new/presentation/widgets/auth_text_field.dart';
import 'package:pokedex_dima_new/presentation/widgets/logo_square_tile.dart';

class Register extends StatefulWidget {

  final Function toggleView;
  Register({required this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthServices _auth = AuthServices();
  final _formKey = GlobalKey<FormState>();

  String error = '';
  bool loading = false;
  String email = '';
  String password = '';

  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Image.asset('lib/images/logos/poke_dima_logo.png', height: 120),

                const SizedBox(height: 15,),

                Padding(
                  padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                  child: Text(
                    "Register to PokeDima app and start sharing your cards!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 16,
                    ),
                  ),
                ),

                const SizedBox(height: 20,),

                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      AuthTextFormField(
                        controller: emailController,
                        hintText: "Email",
                        obscureText: false,
                        validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                      ),
                      const SizedBox(height: 6.0),
                      AuthTextFormField(
                        controller: usernameController,
                        hintText: "Username",
                        obscureText: false,
                        validator: (val) => val!.isEmpty ? 'Enter an username' : null,
                      ),
                      const SizedBox(height: 6.0),
                      AuthTextFormField(
                        controller: passwordController,
                        hintText: "Password",
                        obscureText: true,
                        validator: (val) => val!.length < 8 ? 'Enter a password of at least 8 characters.' : null,
                      ),
                    ],
                  ),
                ),

                error.isEmpty ? const SizedBox(height: 35,) : Column(
                  children: [
                    const SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0, bottom: 5.0, left: 25.0, right: 25.0),
                      child: Text(
                        error,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 14.0,
                        ),
                      ),
                    ),

                    const SizedBox(height: 10,),
                  ],
                ),

                loading ? const AuthLoadingBar() : AuthButton(
                  text: "Sign In",
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() => loading = true);
                      try {
                        await _auth.registerWithEmailUsernameAndPassword(emailController.text, usernameController.text, passwordController.text);
                      } catch (e) {
                        setState(() {
                          loading = false;
                          error = _auth.extractFirebaseErrorMessage(e.toString());
                        });
                      }
                    }
                  },
                ),

                const SizedBox(height: 15.0),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Or continue with',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20.0,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LogoSquareTile(
                      imagePath: 'lib/images/logos/google_logo.png',
                      onTap: () async { await _auth.signInWithGoogle(); },
                    ),
                    const SizedBox(width: 25.0),
                    LogoSquareTile(
                      imagePath: 'lib/images/logos/apple_logo.png',
                      onTap: () async { await _auth.signInWithApple(); },
                    ),
                  ],
                ),

                const SizedBox(height: 50),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already a member?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),

                    TextButton(
                      onPressed: () { widget.toggleView(); },
                      child: const Text(
                        'Sign in here',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
