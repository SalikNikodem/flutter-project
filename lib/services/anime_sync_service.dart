import 'anime_api_service.dart';
import 'anime_local_database.dart';
import '../models/anime.dart';

class AnimeSyncService {
  static Future<void> loadInitialDataIfNeeded() async {
    if (!AnimeLocalDatabase.isEmpty()) {
      return;
    }

    final animeList = await AnimeApiService.fetchTopAnime();
    await AnimeLocalDatabase.saveAnimeList(animeList);
  }
}