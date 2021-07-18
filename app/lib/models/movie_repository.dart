import 'dart:convert';

import 'package:app/models/streaming_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'movie.dart';

class MovieRepository {
  // String repoUrl = dotenv.env['BACKEND_URL']!;
  String repoUrl = 'foobar';

  Future<List<Movie>> loadRecommendations(String userId) async {
    await Future.delayed(Duration(seconds: 2));
    print('awaited recos');
    return MovieRepository.loadMovies();
    // final url = Uri.parse('$repoUrl/premieres/$userId');
    // final response = await http.get(url);
    // final Map<String, dynamic> body = jsonDecode(response.body);
    // return body['movies'].map((movie) => Movie.fromJson(movie));
  }

  Future<List<Movie>> loadReleases() async {
    await Future.delayed(Duration(seconds: 2));
    final url = Uri.parse('https://labsoft2.adarah.info/releases');
    final response = await http.get(url);
    final Map<String, dynamic> body = jsonDecode(response.body);
    return body['movies'].map((movie) => Movie.fromJson(movie));
  }

  Future<List<Movie>> search(String searchTerm) async {
    await Future.delayed(Duration(seconds: 1));
    return MovieRepository.loadMovies();
  }

  Future<List<Movie>> loadReviewedMovies(String userId) async {
    await Future.delayed(Duration(seconds: 1));
    return MovieRepository.loadMovies();
  }


  static List<Movie> loadMovies() {
    final allMovies = <Movie>[
      Movie(
        id: 0,
        title: 'O Hobbit: Uma Jornada Inesperada',
        posterUrl: 'assets/images/hobbit.jpg',
        releaseYear: 2012,
        duration: '3h2m',
        genres: ['Fantasia', 'Aventura'],
        score: 7.8,
        streamingServices: [PrimeVideo()],
      ),
      Movie(
        id: 1,
        title: 'Matrix',
        posterUrl: 'assets/images/matrix.jpg',
        releaseYear: 1999,
        duration: '2h16m',
        genres: ['Ação', 'Ficção Científica'],
        score: 8.7,
        streamingServices: [Netflix()],
      ),
      Movie(
        id: 2,
        title: 'Star Wars IV: Uma nova Esperaça',
        posterUrl: 'assets/images/star_wars.jpg',
        releaseYear: 1977,
        duration: '2h1m',
        genres: ['Ação', 'Fantasia', 'Aventura'],
        score: 8.6,
        streamingServices: [DisneyPlus()],
      ),
      Movie(
        id: 3,
        title: 'Bastardos Inglórios',
        posterUrl: 'assets/images/inglorious_bastards.jpg',
        releaseYear: 2009,
        duration: '2h33m',
        genres: ['Aventura', 'Drama', 'Guerra'],
        score: 8.3,
        streamingServices: [PrimeVideo(), Netflix()],
      ),
    ];
    return allMovies;
  }
}
