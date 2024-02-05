import 'package:flutter/material.dart';
import 'package:pokedex_dima_new/application/deserializers/pokemon_cards_deserializer.dart';
import 'package:pokedex_dima_new/application/deserializers/pokemon_deserializer.dart';
import 'package:pokedex_dima_new/application/providers/pokemon_cards_provider.dart';
import 'package:pokedex_dima_new/application/providers/pokemon_provider.dart';
import 'package:pokedex_dima_new/application/providers/username_provider.dart';
import 'package:pokedex_dima_new/data/firebase_cloud_services/firebase_cloud_services.dart';
import 'package:pokedex_dima_new/domain/user.dart';
import 'package:pokedex_dima_new/presentation/pages/authentication/authenticate.dart';
import 'package:pokedex_dima_new/presentation/pages/home_page.dart';
import 'package:provider/provider.dart';


class HomePageWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserAuthInfo?>(context);

    if (user == null) {
      return Authenticate();
    } else {
      _loadPokemonData(context, user.email);
      return HomePage();
    }
  }

  Future<void> _loadPokemonData(BuildContext context, String email) async {
    final pokemonProvider = Provider.of<PokemonProvider>(context, listen: false);
    await PokemonDeserializer.deserializeAndSetProviderData(pokemonProvider);

    final pokemonCardsProvider = Provider.of<PokemonCardsProvider>(context, listen: false);
    await PokemonCardsDeserializer.deserializeAndSetProviderData(email, pokemonCardsProvider);

    final username = await FirebaseCloudServices().getUsernameUsingEmail(email);
    Provider.of<UsernameProvider>(context, listen: false).setUsername(username!);
  }
}