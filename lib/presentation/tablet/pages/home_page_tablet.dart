import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:pokedex_dima_new/application/auth_services/auth_service.dart';
import 'package:pokedex_dima_new/images/icons/poke_dima_icons.dart';
import 'package:pokedex_dima_new/presentation/phone/pages/scanner_page.dart';
import 'package:pokedex_dima_new/presentation/phone/pages/pokemon_cards_list_page.dart';
import 'package:pokedex_dima_new/presentation/phone/pages/pokemon_grid_page.dart';
import 'package:pokedex_dima_new/presentation/phone/pages/user_profile_page.dart';
import 'package:pokedex_dima_new/presentation/phone/widgets/menu_drawer.dart';

class HomePageTablet extends StatefulWidget {

  const HomePageTablet({ super.key });

  @override
  _HomePageTabletState createState() => _HomePageTabletState();
}

class _HomePageTabletState extends State<HomePageTablet> {
  int _currentIndex = 1;
  late Widget bodyWidget;
  late Widget cardsCollectionPage;
  late Widget pokemonGridPage;
  late Widget scannerPage;
  late Widget userProfilePage;

  final List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();

    cardsCollectionPage = PokemonCardsList(changeBodyWidget: changeBodyWidget);
    pokemonGridPage = PokemonGrid(changeBodyWidget: changeBodyWidget);
    scannerPage = Scanner(changeBodyWidget: changeBodyWidget);
    userProfilePage = UserProfile(changeBodyWidget: changeBodyWidget);

    _pages.add(cardsCollectionPage);
    _pages.add(pokemonGridPage);
    _pages.add(scannerPage);
    _pages.add(userProfilePage);

    bodyWidget = _pages[_currentIndex];
  }

  void changeBodyWidget(Widget newWidget, {int index = -1}) {
    setState(() {
      bodyWidget = index != -1 ? _pages[index] : newWidget;
      _currentIndex = index;
    });
  }

  void _bottomBarNavigateTo(int index) {
    setState(() {
      _currentIndex = index;
      bodyWidget = _pages[_currentIndex];
    } );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF111318),
        title: const Text(
          "P O K E D I M A",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Image.asset("lib/images/logos/poke_dima_app_icon.png",),
            ),
          ],
        ),
        centerTitle: true,
        leadingWidth: 60,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 0),
            child: IconButton(
              icon: const Icon(Icons.logout),
              color: Colors.white,
              iconSize: 32,
              onPressed: () async {
                await AuthServices().signOut();
              },
            ),
          ),
        ],
      ),
      body: Row(
        children:[
          NavigationRail(
            selectedIndex: _currentIndex,
            groupAlignment: 0,
            minWidth: 68.0,

            onDestinationSelected: (int index) {
              setState(() {
                _currentIndex = index;
                _bottomBarNavigateTo(_currentIndex);
              });
            },

            backgroundColor: const Color(0xFF111318),
            indicatorColor: const Color(0xFF111318),
            indicatorShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),

            labelType: NavigationRailLabelType.none,
            destinations: <NavigationRailDestination>[
              NavigationRailDestination(
                icon: const Icon(PokeDima.cards, color: Colors.white, size: 32),
                selectedIcon: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey[700],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(PokeDima.cards, color: Colors.white, size: 32),
                ),
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                label: const Text(""),
              ),
              NavigationRailDestination(
                icon: const Icon(PokeDima.pokemon, color: Colors.white, size: 32),
                selectedIcon: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey[700],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(PokeDima.pokemon, color: Colors.white, size: 32),
                ),
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                label: const Text(""),
              ),
              NavigationRailDestination(
                icon: const Icon(PokeDima.scanner, color: Colors.white, size: 32),
                selectedIcon: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey[700],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(PokeDima.scanner, color: Colors.white, size: 32),
                ),
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                label: const Text(""),
              ),
              NavigationRailDestination(
                icon: const Icon(PokeDima.personal, color: Colors.white, size: 32),
                selectedIcon: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey[700],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(PokeDima.personal, color: Colors.white, size: 32),
                ),
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                label: const Text(""),
              ),
            ],
          ),

          Expanded(
            child: bodyWidget,
          ),
        ],
      ),
    );
  }
}