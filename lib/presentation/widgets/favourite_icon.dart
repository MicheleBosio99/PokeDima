import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavouriteIcon extends StatefulWidget {

  final String pokemonName;
  const FavouriteIcon({required this.pokemonName, super.key});

  @override
  _FavouriteIconState createState() => _FavouriteIconState();
}

class _FavouriteIconState extends State<FavouriteIcon> {

  late bool isFavourite;
  late Future<List<String>> favouritePokemons;
  final Favourites favPokemons = Favourites();

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
  Favourites();

  Future<void> saveFavourites(List<String> favourites) async {
    final prefs = await SharedPreferences.getInstance();
    final serializedList = favourites.join(';');
    await prefs.setString('favouritePokemonsList', serializedList);
  }

  Future<List<String>> loadFavourites() async {
    final prefs = await SharedPreferences.getInstance();
    final serializedList = prefs.getString('favouritePokemonsList') ?? '';
    return serializedList.split(';');
  }
}