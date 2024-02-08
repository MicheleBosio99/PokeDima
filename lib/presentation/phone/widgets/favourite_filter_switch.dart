import 'package:flutter/material.dart';
// import 'package:pokedex_dima_new/domain/pokemon_filters.dart';


class FavouriteSwitch extends StatefulWidget {

  // final PokemonFilters pokemonFilters;
  // const FavouriteSwitch({ super.key, required this.pokemonFilters });

  @override
  _FavouriteSwitchState createState() => _FavouriteSwitchState();
}

class _FavouriteSwitchState extends State<FavouriteSwitch> {
  var isFavEnabled = false;

  @override
  Widget build(BuildContext context) {
    // PokemonFiltered().isFavouriteFilter = isFavEnabled;

    return Switch(
      value: isFavEnabled,
      onChanged: (bool value) {
        setState(() {
          // widget.pokemonFilters.favouritesOnly = value;
          isFavEnabled = value;
        });
      },
    );
  }
}