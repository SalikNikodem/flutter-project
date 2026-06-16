class Anime {
  final int id;
  final String title;
  final String imageUrl;
  final String type;
  final double score;
  final String synopsis;

  Anime({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.type,
    required this.score,
    required this.synopsis,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "imageUrl": imageUrl,
      "type": type,
      "score": score,
      "synopsis": synopsis,
    };
  }

  factory Anime.fromMap(Map map) {
    return Anime(
      id: map["id"],
      title: map["title"],
      imageUrl: map["imageUrl"],
      type: map["type"],
      score: (map["score"] as num?)?.toDouble() ?? 0.0,
      synopsis: map["synopsis"] ?? "No description.",
    );
  }
}