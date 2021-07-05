enum StreamingService {
  netflix,
  disneyPlus,
  primeVideo,
}

class Movie {
  final String title;
  final String posterUrl;
  final int releaseYear;
  final String duration;
  final List<String> genres;
  final double score;
  final List<StreamingService> streamingServices;

  const Movie({
    required this.title,
    required this.posterUrl,
    required this.releaseYear,
    required this.duration,
    required this.genres,
    required this.score,
    required this.streamingServices,
  });
}
