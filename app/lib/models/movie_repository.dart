import 'dart:convert';

import 'package:http/http.dart' as http;
import 'movie.dart';

class MovieRepository {
  static Future<List<Movie>> loadRecommendations(String userId) async {
    final url = Uri.parse('https://labsoft2.adarah.info/recommendations/$userId');
    final response = await http.get(url);
    final Map<String, dynamic> body = jsonDecode(response.body);
    return body['movies'].map((movie) => Movie.fromJson(movie));
  }

  static Future<List<Movie>> loadReleases() async {
    final url = Uri.parse('https://labsoft2.adarah.info/releases');
    final response = await http.get(url);
    final Map<String, dynamic> body = jsonDecode(response.body);
    return body['movies'].map((movie) => Movie.fromJson(movie));
  }

  static List<Movie> loadMovies() {
    const allMovies = <Movie>[
      Movie(
        title: 'O Hobbit: Uma Jornada Inesperada',
        posterUrl: 'assets/images/hobbit.jpg',
        releaseYear: 2012,
        duration: '3h2m',
        genres: ['Fantasia', 'Aventura'],
        score: 7.8,
        streamingServices: [StreamingService.primeVideo],
      ),
      Movie(
        title: 'Matrix',
        posterUrl: 'assets/images/matrix.jpg',
        releaseYear: 1999,
        duration: '2h16m',
        genres: ['Ação', 'Ficção Científica'],
        score: 8.7,
        streamingServices: [StreamingService.netflix],
      ),
      Movie(
        title: 'Star Wars IV: Uma nova Esperaça',
        posterUrl: 'assets/images/star_wars.jpg',
        releaseYear: 1977,
        duration: '2h1m',
        genres: ['Ação', 'Fantasia', 'Aventura'],
        score: 8.6,
        streamingServices: [StreamingService.disneyPlus],
      ),
      Movie(
        title: 'Bastardos Inglórios',
        posterUrl: 'assets/images/inglorious_bastards.jpg',
        releaseYear: 2009,
        duration: '2h33m',
        genres: ['Aventura', 'Drama', 'Guerra'],
        score: 8.3,
        streamingServices: [StreamingService.primeVideo, StreamingService.netflix],
      ),
    ];
    return allMovies;
  }
}
