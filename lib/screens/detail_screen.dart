import 'package:flutter/material.dart';
import '../models/anime.dart';
import '../services/anime_api_service.dart';

class DetailScreen extends StatelessWidget {
  final int animeId;

  const DetailScreen({super.key, required this.animeId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Szczegóły produkcji"),
      ),
      body: FutureBuilder<Anime>(
        future: AnimeApiService.fetchAnimeDetails(animeId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Nie udało się załadować szczegółów: ${snapshot.error}"));
          }

          final anime = snapshot.data!;

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        anime.imageUrl,
                        height: 300,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    anime.title,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Chip(label: Text(anime.type)),
                      const SizedBox(width: 10),
                      Icon(Icons.star, color: Colors.amber[700]),
                      const SizedBox(width: 4),
                      Text(
                        "${anime.score} / 10",
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Fabuła / Opis:",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    anime.synopsis,
                    style: const TextStyle(fontSize: 16, height: 1.4),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}