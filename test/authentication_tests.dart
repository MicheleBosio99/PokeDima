import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex_dima_new/application/auth_services/auth_service.dart';
import 'package:pokedex_dima_new/data/firebase_cloud_services/firebase_cloud_services.dart';

Future<void> main() async {

  setUpAll(() async {
    WidgetsFlutterBinding.ensureInitialized();
    Firebase.initializeApp();
  });

  test('', () async {

  });
}

void getUsernameByMailFromFirebase() async {
  String email = "bosio106@gmail.com";
  FirebaseCloudServices firebaseCloudServices = FirebaseCloudServices();
  final username = firebaseCloudServices.getUsernameUsingEmail(email);

  expect(username, "berol99");
}

void testSignInEmailAuthentication() {
  String email = "bosio106@gmail.com";
  String password = "12345678";

  AuthServices authService = AuthServices();
  var result = authService.signInWithEmailAndPassword(email, password);
  expect(result, isNotNull);
}

void testRegisterEmailAuthentication() {
  String email = "bosio106@gmail.com";
  String password = "12345678";
  String username = "berol99";

  AuthServices authService = AuthServices();
  var result = authService.registerWithEmailAndPassword(email, password);
  expect(result, isNotNull);
}

void testSignInWithUsernameEmailAuthentication() {
  String username = "berol99";
  String password = "12345678";

  AuthServices authService = AuthServices();
  var result = authService.signInWithUsernameAndPassword(username, password);
  expect(result, isNotNull);
}

void testRegisterWithUsernameEmailAuthentication() {
  String email = "bosio106@gmail.com";
  String username = "berol99";
  String password = "12345678";

  AuthServices authService = AuthServices();
  var result = authService.registerWithEmailUsernameAndPassword(email, username, password);
  expect(result, isNotNull);
}
