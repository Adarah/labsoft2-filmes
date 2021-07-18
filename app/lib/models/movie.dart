import 'package:app/models/streaming_service.dart';

class Movie {
  final String id;
  final String title;
  final String posterUrl;
  final int releaseYear;
  final int duration;
  final List<String> genres;
  final int score;
  final List<StreamingService> streamingServices;

  const Movie({
    required this.id,
    required this.title,
    required this.posterUrl,
    required this.releaseYear,
    required this.duration,
    required this.genres,
    required this.score,
    required this.streamingServices,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'],
      posterUrl: json['url'],
      releaseYear: json['year'],
      duration: json['runningTimeInMinutes'],
      genres: json['genres'].cast<String>(),
      score: json['metaScore'],
      streamingServices: (json['streamings'].cast<int>() as List<int>)
          .map((i) => StreamingService.fromId(i))
          .toList(),
    );
  }
}
