import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:pokedex_dima_new/application/services/auth_service.dart';
import 'package:pokedex_dima_new/icons/poke_dima_icons.dart';
import 'package:pokedex_dima_new/presentation/pages/pokemon_grid_page.dart';
import 'package:pokedex_dima_new/presentation/pages/scanner_page.dart';
import 'package:pokedex_dima_new/presentation/pages/social_page.dart';
import 'package:pokedex_dima_new/presentation/pages/user_card_collection.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _pageController = PageController(initialPage: 0);
  int _currentIndex = 0;

  final List<Widget> _pages = [
    CardsCollection(),
    PokemonGrid(),
    Scanner(),
    SocialNotifications(),
  ];

  void _bottomBarNavigateTo(int index) {
    setState(() { _currentIndex = index;} );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.black,
          statusBarColor: Colors.black,
        ),
        elevation: 0,
        backgroundColor: Colors.black,
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
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          child: GNav(
            backgroundColor: Colors.black,
            color: Colors.white,
            activeColor: Colors.white,
            tabBackgroundColor: Colors.grey[800]!,
            gap: 12,
            iconSize: 24,
            padding: const EdgeInsets.all(16),
            // duration: const Duration(milliseconds: 800),
            tabs: const [
              GButton(
                icon: PokeDima.cards,
                text: 'Collection',
              ),
              GButton(
                icon: PokeDima.pokemon,
                text: 'Pokemons',
              ),
              GButton(
                icon: PokeDima.scanner,
                text: 'Scanner',
              ),
              GButton(
                icon: PokeDima.personal,
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