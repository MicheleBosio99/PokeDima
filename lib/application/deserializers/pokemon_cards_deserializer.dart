import 'package:pokedex_dima_new/application/providers/pokemon_cards_provider.dart';
import 'package:pokedex_dima_new/data/firebase_cloud_services/firebase_cloud_services.dart';

class PokemonCardsDeserializer {

  static Future<void> deserializeAndSetProviderData(String email, PokemonCardsProvider pokemonProvider) async {
      final cloudFirestore = FirebaseCloudServices();
      final username = await cloudFirestore.getUsernameUsingEmail(email);
      final pokemonCardsList = await cloudFirestore.getPokemonCardsByUsername(username!);
      pokemonProvider.setPokemonCardsList(pokemonCardsList);
  }
}