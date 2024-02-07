import 'package:flutter/material.dart';
import 'package:pokedex_dima_new/application/providers/pokemon_provider.dart';
import 'package:pokedex_dima_new/application/providers/username_provider.dart';
import 'package:pokedex_dima_new/data/firebase_cloud_services/firebase_cloud_services.dart';
import 'package:pokedex_dima_new/domain/pokemon.dart';
import 'package:pokedex_dima_new/domain/pokemon_type.dart';
import 'package:provider/provider.dart';

class FavouriteIcon extends StatefulWidget {

  final String pokemonName;
  final String favouriteType;

  const FavouriteIcon({ super.key, required this.pokemonName, required this.favouriteType });

  @override
  _FavouriteIconState createState() => _FavouriteIconState();
}

class _FavouriteIconState extends State<FavouriteIcon> {

  late bool isFavourite;
  late Favourites favPokemons = Favourites(favouriteType: widget.favouriteType);

  Future<void> toggleFavourite(String username) async {
    await favPokemons.saveFavourites(widget.pokemonName, !isFavourite, username);
    setState(() {
      isFavourite = !isFavourite;
    });
  }

  @override
  Widget build(BuildContext context) {
    var username = Provider.of<UsernameProvider?>(context)!.username;

    return FutureBuilder<List<String>>(
      future: favPokemons.loadFavourites(username),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) { return Container(); }
        else if (snapshot.hasError) { return const Text('Error loading data'); }
        else {
          isFavourite = snapshot.data!.contains(widget.pokemonName);

          return IconButton(
            icon: Icon(
              isFavourite ? Icons.star : Icons.star_border,
              size: 32,
              color: isFavourite ? Colors.yellow : null,
            ),
            onPressed: () async {
              await toggleFavourite(username);
              favPokemons.setUserFavouriteColor(username, context);
            },
          );
        }
      },
    );
  }
}



class Favourites {

  final String favouriteType;
  Favourites({ required this.favouriteType });

  Future<void> saveFavourites(String pokemonName, bool toAdd, String username) async {
    await FirebaseCloudServices().updateUserFavourites(username, pokemonName, toAdd, favouriteType);
  }

  Future<List<String>> loadFavourites(String username) async {
    return await FirebaseCloudServices().loadUserFavourites(username, favouriteType);

  }

  void setUserFavouriteColor(String username, BuildContext context) async {
    var favourites = await loadFavourites(username);
    var pokemonList = Provider.of<PokemonProvider>(context, listen: false).pokemonList;

    var favouritePokemons = favourites.map((pokemonName) {
      return pokemonList.firstWhere((pokemon) => pokemon.name == pokemonName);
    }).toList();

    FirebaseCloudServices().updateUserFavouriteColor(username, _findMostFrequentType(favouritePokemons));
  }

  Color _findMostFrequentType(List<Pokemon> pokemonList) {
    Map<String, int> typeFrequency = {};

    for (var pokemon in pokemonList) {
      for (var type in pokemon.pokemonTypes) {
        if (typeFrequency.containsKey(type.name)) {
          typeFrequency[type.name] = typeFrequency[type.name]! + 1;
        } else {
          typeFrequency[type.name] = 1;
        }
      }
    }

    var max = -1;
    var mostFrequentType = "";
    for (var type in typeFrequency.keys) {
      if (typeFrequency[type]! > max) {
        max = typeFrequency[type]!;
        mostFrequentType = type;
      }
    }

    if (max == -1) { return const Color(0xEEEEEEFF); }
    return PokemonType.fromJson(mostFrequentType).backgroundColor;
  }
}