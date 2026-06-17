import 'package:flutter/material.dart';
import '../models/anime.dart';
import '../services/anime_local_database.dart';
import '../services/anime_sync_service.dart';
import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Anime>> animeFuture;

  @override
  void initState() {
    super.initState();
    animeFuture = loadAnimeData();
  }

  Future<List<Anime>> loadAnimeData() async {
    await AnimeSyncService.loadInitialDataIfNeeded();
    return AnimeLocalDatabase.getAnimeList();
  }

  void refreshData() {
    setState(() {
      animeFuture = loadAnimeData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("KrakFlow Anime Tracker"),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep, color: Colors.red),
            tooltip: "Wyczyść pamięć podręczną",
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("Potwierdzenie"),
                  content: const Text("Czy chcesz wyczyścić zapisaną listę anime?"),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Anuluj"),
                    ),
                    TextButton(
                      onPressed: () async {
                        await AnimeLocalDatabase.deleteAllAnime();
                        Navigator.pop(context);
                        refreshData();
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Pamięć podręczna wyczyszczona")),
                          );
                        }
                      },
                      child: const Text("Wyczyść"),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Anime>>(
        future: animeFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Błąd: ${snapshot.error}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
              ),
            );
          }

          final list = snapshot.data ?? [];

          if (list.isEmpty) {
            return const Center(child: Text("Brak danych. Włącz internet i odśwież aplikację."));
          }

          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              final anime = list[index];

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: ListTile(
                  leading: Image.network(
                    anime.imageUrl,
                    width: 50,
                    height: 70,
                    fit: BoxFit.cover,
                  ),
                  title: Text(anime.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text("Typ: ${anime.type} | Ocena: ${anime.score}"),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailScreen(animeId: anime.id),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}