import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:pokedex_dima_new/application/services/auth_service.dart';
import 'package:pokedex_dima_new/icons/poke_dima_icons.dart';
import 'package:pokedex_dima_new/presentation/pages/scanner_page.dart';
import 'package:pokedex_dima_new/presentation/pages/social_page.dart';
import 'package:pokedex_dima_new/presentation/pages/user_card_collection.dart';
import 'package:pokedex_dima_new/presentation/widgets/pokemon_grid.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  late Widget bodyWidget;
  Widget cardsCollectionPage = const CardsCollection();
  late Widget pokemonGridPage;
  Widget scannerPage = const Scanner();
  Widget socialNotificationsPage = const SocialNotifications();

  final List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    pokemonGridPage = PokemonGrid(changeBodyWidget: changeBodyWidget);

    _pages.add(cardsCollectionPage);
    _pages.add(pokemonGridPage);
    _pages.add(scannerPage);
    _pages.add(socialNotificationsPage);

    bodyWidget = _pages[_currentIndex];
  }

  void changeBodyWidget(Widget newWidget) {
    setState(() {
      _currentIndex = -1;
      bodyWidget = newWidget;
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
        leading: IconButton(
          icon: const Icon(Icons.menu_outlined),
          color: Colors.white,
          iconSize: 32,
          onPressed: () {},
        ),
        leadingWidth: 60,
        actions: [
          Padding(padding: const EdgeInsets.only(right: 0),
          child: IconButton(
            icon: const Icon(Icons.logout),
            color: Colors.white,
            iconSize: 32,
            onPressed: () async {
              await AuthService().signOut();
            },
          ),
          ),
        ],
      ),
      body: bodyWidget,
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