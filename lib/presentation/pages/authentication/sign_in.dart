import 'package:flutter/material.dart';
import 'package:pokedex_dima_new/application/auth_services/auth_service.dart';
import 'package:pokedex_dima_new/presentation/widgets/auth_loading_bar.dart';
import 'package:pokedex_dima_new/presentation/widgets/auth_button.dart';
import 'package:pokedex_dima_new/presentation/widgets/auth_text_field.dart';
import 'package:pokedex_dima_new/presentation/widgets/logo_square_tile.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({required this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthServices _auth = AuthServices();
  final _formKey = GlobalKey<FormState>();

  String error = '';
  bool loading = false;
  String email = '';
  String password = '';

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
            
                const SizedBox(height: 20,),
            
                Text(
                  "Welcome back to PokeDima app.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),
            
                const SizedBox(height: 25,),
            
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      AuthTextFormField(
                        controller: usernameController,
                        hintText: "Username",
                        obscureText: false,
                        validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                      ),
                      const SizedBox(height: 10.0),
                      AuthTextFormField(
                        controller: passwordController,
                        hintText: "Password",
                        obscureText: true,
                        validator: (val) => val!.length < 8 ? 'Enter a password of at least 8 characters.' : null,
                      ),
                    ],
                  ),
                ),
            
                const SizedBox(height: 5.0),
            
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {/* TODO */},
                        child: const Text(
                          "Forgot Password?",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                error.isEmpty ? const SizedBox(height: 25,) : Column(
                  children: [
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

                    const SizedBox(height: 5,),
                  ],
                ),
            
                loading ? const AuthLoadingBar() : AuthButton(
                  text: "Sign In",
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() => loading = true);
                      try {
                        await _auth.signInWithUsernameAndPassword(usernameController.text, passwordController.text);
                        error = '';
                      } catch (e) {
                        setState(() {
                          loading = false;
                          error = _auth.extractFirebaseErrorMessage(e.toString());
                        });
                      }
                    }
                  },
                ),
            
                const SizedBox(height: 25.0),
            
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
            
                const SizedBox(height: 25,),
            
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LogoSquareTile(
                      imagePath: 'lib/images/logos/google_logo.png',
                      onTap: () async { await _auth.signInWithGoogle(); },
                    ),
                    const SizedBox(width: 25),
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
                      'Not a member?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),

                    TextButton(
                      onPressed: () { widget.toggleView(); },
                      child: const Text(
                        'Register now',
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
