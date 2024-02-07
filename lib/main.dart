import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pokedex_dima_new/application/providers/pokemon_cards_provider.dart';
import 'package:pokedex_dima_new/application/providers/pokemon_provider.dart';
import 'package:pokedex_dima_new/application/auth_services/auth_service.dart';
import 'package:pokedex_dima_new/application/providers/username_provider.dart';
import 'package:pokedex_dima_new/domain/user.dart';
import 'package:pokedex_dima_new/presentation/phone/pages/home_page_wrapper.dart';
import 'package:pokedex_dima_new/presentation/tablet/pages/home_page_wrapper_tablet.dart';
import 'package:provider/provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
          apiKey: "AIzaSyBaSUNDee-bqIyhDJyLerA22KCu6t1pXYU",
          appId: "1:28587029205:android:bc4b0f68d5c84d276d685c",
          messagingSenderId: "28587029205",
          projectId: "pokedexdima-new",
        ))
      : await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PokemonProvider()),
        ChangeNotifierProvider(create: (context) => PokemonCardsProvider()),
        ChangeNotifierProvider(create: (context) => UsernameProvider()),
        StreamProvider<UserAuthInfo?>.value(
          value: AuthServices().user,
          initialData: null,
          catchError: (_, __) => null,
        ),
      ],
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 600) { return buildPhone(context); }
          else { return buildTablet(context); }
        },
      ),
    );
  }

  Widget buildPhone(BuildContext context) {
    return Builder(
      builder: (context) {
        return const MaterialApp(
          title: 'PokeDima',
          debugShowCheckedModeBanner: false,
          home: HomePageWrapper(),
        );
      },
    );
  }

  Widget buildTablet(BuildContext context) {
    return Builder(
      builder: (context) {
        return const MaterialApp(
          title: 'PokeDima',
          debugShowCheckedModeBanner: false,
          home: HomePageWrapperTablet(),
        );
      },
    );
  }
}
