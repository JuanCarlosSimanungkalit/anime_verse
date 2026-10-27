import 'package:anime_verse/data/dummy_data.dart';
import 'package:anime_verse/providers/app_state_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  group('AppStateProvider', () {
    test('toggleFavorite menambah lalu menghapus favorit & memanggil notifyListeners', () {
      final provider = AppStateProvider();
      var notified = 0;
      provider.addListener(() => notified++);
      final anime = DummyData.animeList.first;

      provider.toggleFavorite(anime);
      expect(provider.isFavorite(anime.id), isTrue);
      expect(provider.favorites.length, 1);

      provider.toggleFavorite(anime);
      expect(provider.isFavorite(anime.id), isFalse);
      expect(provider.favorites, isEmpty);
      expect(notified, 2);
    });

    test('daftar favorit tidak bisa diubah dari luar', () {
      final provider = AppStateProvider();
      expect(() => provider.favorites.add(DummyData.animeList.first),
          throwsUnsupportedError);
    });

    test('filter genre pada Home', () {
      final provider = AppStateProvider();
      provider.setSelectedGenre('Action');
      final result = provider.getFilteredAnimeForHome();
      expect(result, isNotEmpty);
      expect(
        result.every((a) =>
            a.genre.split(',').map((g) => g.trim()).contains('Action')),
        isTrue,
      );
    });

    test('filter pencarian Home case-insensitive', () {
      final provider = AppStateProvider();
      provider.setHomeSearchQuery('black CLOVER');
      final result = provider.getFilteredAnimeForHome();
      expect(result.length, 1);
      expect(result.first.title, 'Black Clover');
    });

    test('filter pencarian Favorit', () {
      final provider = AppStateProvider();
      provider.addFavorite(DummyData.animeList[0]);
      provider.addFavorite(DummyData.animeList[1]);
      provider.setFavoriteSearchQuery('hero');
      expect(provider.getFilteredFavorites().length, 1);
    });
  });
}
