import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pokedex_dima_new/application/services/auth_service.dart';
import 'package:pokedex_dima_new/domain/user.dart';
import 'package:pokedex_dima_new/presentation/pages/home_page_wrapper.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid ? await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyBaSUNDee-bqIyhDJyLerA22KCu6t1pXYU",
        appId: "1:28587029205:android:bc4b0f68d5c84d276d685c",
        messagingSenderId: "28587029205",
        projectId: "pokedexdima-new",
    )
  ) : await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserAuthInfo?>.value(
      value: AuthService().user,
      initialData: null,
      catchError: (_, __) => null,
      child: MaterialApp(
        home: HomePageWrapper(),
      ),
    );
  }
}