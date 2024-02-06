import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex_dima_new/application/providers/username_provider.dart';
import 'package:pokedex_dima_new/presentation/widgets/favourite_icon.dart';
import 'package:pokedex_dima_new/data/firebase_cloud_services/firebase_cloud_services.dart';
import 'package:pokedex_dima_new/domain/pokemon.dart';
import 'package:pokedex_dima_new/domain/pokemon_type.dart';
import 'package:pokedex_dima_new/application/providers/pokemon_provider.dart';
import 'package:provider/provider.dart';
import 'package:mockito/mockito.dart';


// This class Mock is not working as it should...
class MockFirebaseCloudServices extends Mock implements FirebaseCloudServices {}

void main() {

  final Pokemon testPokemon = Pokemon(
    name: 'Bulbasaur',
    imageUrl: 'https://firebasestorage.googleapis.com/v0/b/pokedexdima-new.appspot.com/o/_%24BaseFolder-PokeDima%2Fbulbasaur_test?alt=media&token=c2f67553-e570-413c-9802-54fcc24d1b5f',
    pokemonTypes: [PokemonType(name: "Grass", color: Colors.green[700]!, backgroundColor: Colors.green)],
    id: '',
    xDescription: '',
    height: '',
    weight: '',
    evolutions: [],
    hp: 100,
    attack: 0,
    defense: 0,
    specialAttack: 0,
    specialDefense: 0,
    speed: 0,
    evolvedFrom: '#001',
  );

  testWidgets('FavouriteIcon toggles correctly', (WidgetTester tester) async {

    final mockFirebaseCloudServices = MockFirebaseCloudServices();
    when(mockFirebaseCloudServices.saveUserFavourites(
        ["Bulbasaur"],
        "user1test",
        "pokemon")
    ).thenAnswer((_) async => true);
    when(mockFirebaseCloudServices.loadUserFavourites(
        "user1test",
        "pokemon")
    ).thenAnswer((_) async => ['Bulbasaur']);

    final mockUsernameProvider = UsernameProvider();
    final mockPokemonProvider = PokemonProvider();
    const mockFavouriteType = 'Grass';

    mockPokemonProvider.setPokemonList([testPokemon]);

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          Provider<UsernameProvider>(
            create: (_) => mockUsernameProvider,
          ),
          Provider<PokemonProvider>(
            create: (_) => mockPokemonProvider,
          ),
          Provider<FirebaseCloudServices>(
            create: (_) => mockFirebaseCloudServices,
          ),
        ],
        child: const MaterialApp(
          home: FavouriteIcon(
            pokemonName: 'Bulbasaur',
            favouriteType: mockFavouriteType,
          ),
        ),
      ),
    );


    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.byType(IconButton), findsOneWidget);
    expect(find.byIcon(Icons.star_border), findsOneWidget);

    await tester.tap(find.byType(IconButton));
    await tester.pump();
    expect(find.byIcon(Icons.star), findsOneWidget);

    await tester.tap(find.byType(IconButton));
    await tester.pump();
    expect(find.byIcon(Icons.star_border), findsOneWidget);
  });
}
