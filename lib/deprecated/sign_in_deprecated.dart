import 'package:flutter/material.dart';
import 'package:pokedex_dima_new/application/auth_services/auth_service.dart';
import 'package:pokedex_dima_new/deprecated/graphics_constants_deprecated.dart';
import 'package:pokedex_dima_new/presentation/phone/widgets/auth_loading_bar.dart';

class SignInDeprecated extends StatefulWidget {
  final Function toggleView;
  SignInDeprecated({required this.toggleView});

  @override
  _SignInDeprecatedState createState() => _SignInDeprecatedState();
}

class _SignInDeprecatedState extends State<SignInDeprecated> {

  final AuthServices _auth = AuthServices();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  // text field state
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return loading ? const AuthLoadingBar() : Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
          backgroundColor: Colors.grey[500],
          elevation: 0.0,
          title: const Center( child: Text('PokeDima - Sign In') ),
          actions: []
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 150.0),
              TextFormField(
                validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                decoration: textInputDecoration.copyWith(
                  hintText: 'Email',
                  prefixIcon: const Icon(Icons.email),
                  prefixIconColor: Colors.black,
                ),
                onChanged: (val) => {setState(() => email = val)},
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                obscureText: true,
                validator: (val) => val!.length < 8 ? 'Enter a password of at least 8 characters.' : null,
                decoration: textInputDecoration.copyWith(
                  hintText: 'Password',
                  prefixIcon: const Icon(Icons.password_sharp),
                  prefixIconColor: Colors.black,
                ),
                onChanged: (val) => {setState(() => password = val)},
              ),
              const SizedBox(height: 40.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.red,
                        side: const BorderSide(
                          color: Colors.red,
                        ),
                      ),
                      child: const Text('Sign In'),
                      onPressed: () async {
                        if(_formKey.currentState!.validate()){
                          setState(() => loading = true);
                          try {
                            await _auth.signInWithEmailAndPassword(email, password);
                          } catch (e) {
                            setState(() {
                              loading = false;
                              error = "${_auth.extractFirebaseErrorMessage(e.toString())} Try signing in.";
                            });
                          }
                        }
                      }),
                  const SizedBox(width: 50.0),
                  OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.red,
                        side: const BorderSide(
                          color: Colors.red,
                        ),
                      ),
                      onPressed: () {
                        widget.toggleView();
                      },
                      child: const Text('Go to register')
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              Text(
                error,
                style: const TextStyle(color: Colors.red, fontSize: 14.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
