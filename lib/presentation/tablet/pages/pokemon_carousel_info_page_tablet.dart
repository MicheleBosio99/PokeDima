import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:infinite_carousel/infinite_carousel.dart';
import 'package:pokedex_dima_new/application/providers/pokemon_provider.dart';
import 'package:pokedex_dima_new/domain/pokemon.dart';
import 'package:pokedex_dima_new/presentation/phone/pages/pokemon_info_page.dart';
import 'package:pokedex_dima_new/presentation/tablet/pages/pokemon_info_page_for_carousel_tablet.dart';
import 'package:provider/provider.dart';


class PokemonCarouselInfoPageTablet extends StatefulWidget {

  final String? pokemonName;
  final Function changeBodyWidget;
  const PokemonCarouselInfoPageTablet({ super.key, required this.changeBodyWidget, this.pokemonName });

  @override
  State<PokemonCarouselInfoPageTablet> createState() => _PokemonCarouselInfoPageTabletState();
}

class _PokemonCarouselInfoPageTabletState extends State<PokemonCarouselInfoPageTablet> {

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final pokemons = Provider.of<PokemonProvider>(context, listen: false).pokemonList;
    _selectedIndex = pokemons.indexOf(pokemons.firstWhere((element) => element.name == (widget.pokemonName ?? "Bulbasaur")));

    return CarouselSlider(
      options: CarouselOptions(
        initialPage: _selectedIndex,
        height: 750.0,
        enlargeCenterPage: true,
        autoPlay: false,
        aspectRatio: 16/9,
        enableInfiniteScroll: false,
        autoPlayAnimationDuration: const Duration(milliseconds: 600),
        viewportFraction: 0.4,
      ),
      items: pokemons.map((pokemon) {
        return Builder(
          builder: (BuildContext context) {
            return PokemonInfoPageForCarouselTablet(pokemon: pokemon, changeBodyWidget: widget.changeBodyWidget);
          },
        );
      }).toList(),
    );
  }

  List<Widget> getEvolutionImages(Pokemon pokemon, BuildContext context, PokemonProvider pokemonProvider) {
    return pokemon.evolutions.fold([], (list, pokemonID) {

      final pokemonEvolution = Provider.of<PokemonProvider>(context, listen: false).getPokemonById(pokemonID);
      if (pokemonEvolution == null) { throw ''; }
      if (pokemon.id == pokemonID) {
        list.add(
          Image.network(pokemonEvolution.imageUrl, width: 90, height: 90, fit: BoxFit.contain),
        );
      } else {
        Opacity(
            opacity: (0.5),
            child: Image.network(pokemonEvolution.imageUrl, width: 90, height: 90, fit: BoxFit.contain),
        );
      }
      if (pokemonID != pokemon.evolutions.last) {
        list.add(const Icon(Icons.arrow_forward));
      }
      return list;
    });
  }

  String _getNextPokemonID(String currPokemonID) {
    int? currentID = int.tryParse(currPokemonID.substring(1));
    if (currentID == 809) {
      throw Exception("LastPokemon");
    } // Wrong now, to get from the repository length
    return '#${((currentID ?? 0) + 1).toString().padLeft(3, '0')}';
  }

  String _getPrevPokemonID(String currPokemonID) {
    int? currentID = int.tryParse(currPokemonID.substring(1));
    if (currentID == 0) {
      throw Exception("FirstPokemon");
    }
    return '#${((currentID ?? 0) - 1).toString().padLeft(3, '0')}';
  }
}
