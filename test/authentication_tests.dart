// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:pokedex_dima_new/application/auth_services/auth_service.dart';
// import 'package:pokedex_dima_new/domain/user.dart';
//
// void main() {
//
//   late final AuthServices authServices;
//
//   setUpAll(() async {
//     WidgetsFlutterBinding.ensureInitialized();
//     Firebase.initializeApp();
//     authServices = AuthServices();
//   });
//
//   group('AuthServices Tests', () {
//     test('Test signInWithEmailAndPassword', () async {
//       const String email = 'test@example.com';
//       const String password = 'password123';
//
//       final UserAuthInfo user = await authServices.signInWithEmailAndPassword(email, password);
//       expect(user, isNotNull);
//       expect(user.email, email);
//     });
//
//
//     test('Test registerWithEmailAndPassword', () async {
//       const String email = 'newuser@example.com';
//       const String password = 'newpassword123';
//
//       final UserAuthInfo user = await authServices.registerWithEmailAndPassword(email, password);
//       expect(user, isNotNull);
//       expect(user.email, email);
//     });
//
//
//     test('Test signOut', () async {
//       await authServices.signOut();
//       expect(authServices.user, emits(null));
//     });
//
//
//     test('Test signInWithUsernameAndPassword', () async {
//       const String username = 'testuser';
//       const String password = 'password123';
//
//       final UserAuthInfo user = await authServices.signInWithUsernameAndPassword(username, password);
//       expect(user, isNotNull);
//     });
//
//
//     test('Test registerWithEmailUsernameAndPassword', () async {
//       const String email = 'newuser@example.com';
//       const String username = 'newuser';
//       const String password = 'newpassword123';
//
//       final UserAuthInfo user = await authServices.registerWithEmailUsernameAndPassword(email, username, password);
//       expect(user, isNotNull);
//     });
//
//
//     test('Test extractFirebaseErrorMessage', () {
//       const String errorMessage = '[firebase_auth/email-already-in-use] The email address is already in use by another account.';
//       final String extractedMessage = authServices.extractFirebaseErrorMessage(errorMessage);
//
//       expect(extractedMessage, 'The email address is already in use by another account.');
//     });
//   });
// }