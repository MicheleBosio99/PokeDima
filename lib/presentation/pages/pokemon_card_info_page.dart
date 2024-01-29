import 'package:flutter/material.dart';
import 'package:pokedex_dima_new/application/providers/pokemon_cards_provider.dart';
import 'package:pokedex_dima_new/application/providers/pokemon_provider.dart';
import 'package:pokedex_dima_new/domain/pokemon_card.dart';
import 'package:pokedex_dima_new/presentation/widgets/favourite_icon.dart';
import 'package:pokedex_dima_new/presentation/widgets/pokemon_cards_grid.dart';
import 'package:provider/provider.dart';


class PokemonCardInfoPage extends StatefulWidget {

  final PokemonCard pokemonCard;
  final Function changeBodyWidget;
  const PokemonCardInfoPage({ super.key, required this.pokemonCard, required this.changeBodyWidget });

  @override
  State<PokemonCardInfoPage> createState() => _PokemonCardInfoPageState();
}

class _PokemonCardInfoPageState extends State<PokemonCardInfoPage> {

  bool isPageTransitionInProgress = false;

  @override
  Widget build(BuildContext context) {
    final pokemonCard = widget.pokemonCard;
    final pokemonCardsProvider = Provider.of<PokemonCardsProvider>(context, listen: false);
    final relativePokemon = Provider.of<PokemonProvider>(context, listen: false).getPokemonByName(pokemonCard.pokemonName)!;

    return GestureDetector(
      onHorizontalDragUpdate: (DragUpdateDetails details) {
        if (!isPageTransitionInProgress) {
          try {
            if (details.delta.dx > 10) {
              var nextPokemonCard = pokemonCardsProvider.getPokemonCardById(_getPrevPokemonID(pokemonCard.id));
              isPageTransitionInProgress = true;
              widget.changeBodyWidget(PokemonCardInfoPage(pokemonCard: nextPokemonCard, changeBodyWidget: widget.changeBodyWidget));
            } else if (details.delta.dx < - 10) {
              var nextPokemonCard = pokemonCardsProvider.getPokemonCardById(_getNextPokemonID(pokemonCard.id, pokemonCardsProvider.pokemonCardsList.length),);
              isPageTransitionInProgress = true;
              widget.changeBodyWidget(PokemonCardInfoPage(pokemonCard: nextPokemonCard, changeBodyWidget: widget.changeBodyWidget));
            }
          } catch (e) { }
        }
      },
      onHorizontalDragEnd: (details) {
        isPageTransitionInProgress = false;
      },
      child: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [relativePokemon.pokemonTypes.first.color, Colors.white],
            ),
          ),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 240,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: relativePokemon.pokemonTypes[0].backgroundColor,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(25.0),
                        bottomRight: Radius.circular(25.0),
                      ),
                      image: DecorationImage(
                        image: NetworkImage(pokemonCard.imageUrl),
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () {
                          widget.changeBodyWidget(PokemonCardsGrid(changeBodyWidget: widget.changeBodyWidget), index: 0);
                        },
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0, right: 2.0),
                      child: FavouriteIcon(pokemonName: relativePokemon.name, favouriteType: 'cards'),
                    ),
                  ),
                ],
              ),




            ],
          ),
        ),
      ),
    );
  }

  String _getNextPokemonID(String currPokemonID, int pokemonCardsLength) {
    int? currentID = int.tryParse(currPokemonID.substring(1));
    if (currentID == pokemonCardsLength - 1) {
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
