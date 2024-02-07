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

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
        systemOverlayStyle: SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.grey[900],
          statusBarColor: Colors.grey[850],
        ),
        elevation: 0,
        backgroundColor: Colors.grey[850],
        title: const Text(
          "P O K E D I M A",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu_outlined),
              color: Colors.white,
              iconSize: 32,
              onPressed: () => Scaffold.of(context).openDrawer(),
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
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
      body: bodyWidget,
      drawer: MenuDrawer(changeBodyWidget: changeBodyWidget, ),
      bottomNavigationBar: Container(
        color: Colors.grey[850],
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          child: GNav(
            backgroundColor: Colors.grey[850]!,
            color: Colors.white,
            activeColor: Colors.white,
            tabBackgroundColor: Colors.grey[700]!,
            gap: 12,
            iconSize: 24,
            padding: const EdgeInsets.all(12),
            // duration: const Duration(milliseconds: 800),
            tabs: const [
              GButton(
                icon: PokeDima.cards,
                iconSize: 30,
                text: 'Collection',
              ),
              GButton(
                icon: PokeDima.pokemon,
                iconSize: 30,
                text: 'Pokemons',
              ),
              GButton(
                icon: PokeDima.scanner,
                iconSize: 30,
                text: 'Scanner',
              ),
              GButton(
                icon: PokeDima.personal,
                iconSize: 30,
                text: 'Social',
              ),
            ],
            selectedIndex: _currentIndex,
            onTabChange: _bottomBarNavigateTo,
          ),
        )
      ),
    );
  }
}