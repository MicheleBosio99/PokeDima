import 'package:flutter/material.dart';
import 'package:pokedex_dima_new/application/services/auth_service.dart';
import 'package:pokedex_dima_new/presentation/pages/shared/common_functions.dart';
import 'package:pokedex_dima_new/presentation/pages/shared/graphics_constants.dart';
import 'package:pokedex_dima_new/presentation/pages/shared/loading.dart';

class Register extends StatefulWidget {

  final Function toggleView;
  Register({ required this.toggleView });

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  // text field state
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return loading ? const Loading() : Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
    backgroundColor: Colors.grey[500],
        elevation: 0.0,
        title: const Center( child: Text('PokeDima - Register') ),
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
                decoration: textInputDecoration.copyWith(
                  hintText: 'Email',
                  prefixIcon: const Icon(Icons.email),
                  prefixIconColor: Colors.black,
                ),
                validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                onChanged: (val) {
                  setState(() => email = val);
                },
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(
                  hintText: 'Password',
                  prefixIcon: const Icon(Icons.password_sharp),
                  prefixIconColor: Colors.black,
                ),
                obscureText: true,
                validator: (val) => val!.length < 6 ? 'Enter a password 6+ chars long' : null,
                onChanged: (val) {
                  setState(() => password = val);
                },
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
                      child: const Text('Register'),
                      onPressed: () async {
                        if(_formKey.currentState!.validate()){
                          setState(() => loading = true);
                          try {
                            await _auth.registerWithEmailAndPassword(email, password);
                          } catch (e) {
                            setState(() {
                              loading = false;
                              error = "${extractFirebaseErrorMessage(e.toString())} Try signing in.";
                            });
                          }
                        }
                      }
                  ),
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
                      child: const Text('Go to sign in')
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