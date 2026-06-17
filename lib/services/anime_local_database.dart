import 'package:hive_ce/hive.dart';
import '../models/anime.dart';

class AnimeLocalDatabase {
  static Box get _box => Hive.box("anime");

  static List<Anime> getAnimeList() {
    return _box.values.map((item) {
      return Anime.fromMap(Map<String, dynamic>.from(item));
    }).toList();
  }

  static Future<void> saveAnimeList(List<Anime> animeList) async {
    await _box.clear();
    for (final anime in animeList) {
      await _box.put(anime.id, anime.toMap());
    }
  }

  static Future<void> updateAnime(Anime anime) async {
    await _box.put(anime.id, anime.toMap());
  }

  static Future<void> deleteAllAnime() async {
    await _box.clear();
  }

  static bool isEmpty() {
    return _box.isEmpty;
  }
}