import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/anime.dart';

class AnimeApiService {
  static const String baseUrl = "https://api.jikan.moe/v4";

  static Future<List<Anime>> fetchTopAnime() async {
    final response = await http.get(Uri.parse("$baseUrl/top/anime"));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List animeList = data["data"];

      return animeList.map((item) {
        return Anime(
          id: item["mal_id"],
          title: item["title"],
          imageUrl: item["images"]["jpg"]["image_url"],
          type: item["type"] ?? "TV",
          score: (item["score"] as num?)?.toDouble() ?? 0.0,
          synopsis: item["synopsis"] ?? "No synopsis provided.",
        );
      }).toList();
    } else {
      throw Exception("Błąd pobierania listy top anime: ${response.statusCode}");
    }
  }

  static Future<Anime> fetchAnimeDetails(int id) async {
    final response = await http.get(Uri.parse("$baseUrl/anime/$id"));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final item = data["data"];

      return Anime(
        id: item["mal_id"],
        title: item["title"],
        imageUrl: item["images"]["jpg"]["large_image_url"] ?? item["images"]["jpg"]["image_url"],
        type: item["type"] ?? "TV",
        score: (item["score"] as num?)?.toDouble() ?? 0.0,
        synopsis: item["synopsis"] ?? "No synopsis provided.",
      );
    } else {
      throw Exception("Błąd pobierania szczegółów anime: ${response.statusCode}");
    }
  }
}