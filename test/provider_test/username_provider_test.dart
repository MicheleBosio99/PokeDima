import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex_dima_new/application/providers/username_provider.dart';

void main() {
  group('UsernameProvider Tests', () {
    late UsernameProvider provider;

    setUp(() {
      provider = UsernameProvider();
    });

    test('Initial state', () {
      expect(provider.username, isEmpty);
    });

    test('Set username', () {
      provider.setUsername('TestUser');
      expect(provider.username, equals('TestUser'));
    });

    test('Notify listeners on username change', () {
      bool listenerCalled = false;

      provider.addListener(() {
        listenerCalled = true;
      });

      provider.setUsername('TestUser');
      expect(listenerCalled, isTrue);
    });
  });
}
