import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavouriteIcon extends StatefulWidget {

  final String pokemonName;
  final String favouriteType;

  const FavouriteIcon({ super.key, required this.pokemonName, required this.favouriteType });

  @override
  _FavouriteIconState createState() => _FavouriteIconState();
}

class _FavouriteIconState extends State<FavouriteIcon> {

  late bool isFavourite;
  late Future<List<String>> favouritePokemons;
  late final Favourites favPokemons = Favourites(favouriteType: widget.favouriteType);

  @override
  void initState() {
    super.initState();
    favouritePokemons = favPokemons.loadFavourites();
  }

  void toggleFavourite(List<String> currentFavourites) {
    setState(() {
      isFavourite = currentFavourites.contains(widget.pokemonName);
      if (isFavourite) {
        currentFavourites.remove(widget.pokemonName);
      } else {
        currentFavourites.add(widget.pokemonName);
      }
      favPokemons.saveFavourites(currentFavourites);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: favouritePokemons,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return const Text('Error loading data');
        } else {
          List<String> currentFavourites = snapshot.data ?? [];
          isFavourite = currentFavourites.contains(widget.pokemonName);
          return IconButton(
            icon: Icon(
              isFavourite ? Icons.star : Icons.star_border,
              size: 32,
              color: isFavourite ? Colors.yellow : null,
            ),
            onPressed: () => toggleFavourite(currentFavourites),
          );
        }
      },
    );
  }
}



class Favourites {

  final favouriteType;
  Favourites({ required this.favouriteType});

  Future<void> saveFavourites(List<String> favourites) async {
    final prefs = await SharedPreferences.getInstance();
    final serializedList = favourites.join(';');
    await prefs.setString('favourite$favouriteType', serializedList);
  }

  Future<List<String>> loadFavourites() async {
    final prefs = await SharedPreferences.getInstance();
    final serializedList = prefs.getString('favourite$favouriteType') ?? '';
    return serializedList.split(';');
  }


  // void setUserFavouriteColor(String username, List<String> favourites, BuildContext context) {
  //   var pokemonList = Provider.of<PokemonProvider>(context, listen: false).pokemonList;
  //   favourites.removeAt(0);
  //
  //   var favouritePokemons = favourites.map((pokemonName) {
  //     return pokemonList.firstWhere((pokemon) => pokemon.name == pokemonName);
  //   }).toList();
  //
  //   FirebaseCloudServices().updateUserFavouriteColor(username, _findMostFrequentType(favouritePokemons));
  // }
  //
  // Color _findMostFrequentType(List<Pokemon> pokemonList) {
  //   Map<String, int> typeFrequency = {};
  //
  //   for (var pokemon in pokemonList) {
  //     for (var type in pokemon.pokemonTypes) {
  //       if (typeFrequency.containsKey(type.name)) {
  //         typeFrequency[type.name] = typeFrequency[type.name]! + 1;
  //       } else {
  //         typeFrequency[type.name] = 1;
  //       }
  //     }
  //   }
  //
  //   var max = 0;
  //   var mostFrequentType = "";
  //   for (var type in typeFrequency.keys) {
  //     if (typeFrequency[type]! > max) {
  //       max = typeFrequency[type]!;
  //       mostFrequentType = type;
  //     }
  //   }
  //
  //   return PokemonType.fromJson(mostFrequentType).backgroundColor;
  // }
}