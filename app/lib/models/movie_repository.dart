import 'dart:convert';

import 'package:app/core/reviews/movie_reviews.dart';
import 'package:app/models/streaming_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'movie.dart';

class MovieRepository {
  String repoUrl = dotenv.env['BACKEND_URL']!;

  Future<List<Movie>> loadRecommendations(String userId) async {
    final url = Uri.parse('$repoUrl/recommendations/$userId');
    final response = await http.get(url);
    final List<dynamic> body = jsonDecode(response.body);
    return body.map((movie) => Movie.fromJson(movie)).toList();
  }

  Future<List<Movie>> loadReleases(String userId) async {
    final url = Uri.parse('$repoUrl/premieres/$userId');
    final response = await http.get(url);
    final List<dynamic> body = jsonDecode(response.body);
    return body.map((movie) => Movie.fromJson(movie)).toList();
  }

  Future<List<Movie>> search(String searchTerm) async {
    final url = Uri.parse('$repoUrl/movie_search?search=$searchTerm');
    final response = await http.get(url);
    final List<dynamic> body = jsonDecode(response.body);
    return body.map((movie) => Movie.fromJson(movie)).toList();
  }

  Future<List<MovieReview>> loadReviewedMovies(String userId) async {
    final url = Uri.parse('$repoUrl/rating/$userId');
    final response = await http.get(url);
    final List<dynamic> body = jsonDecode(response.body);
    return body.map((review) => MovieReview.fromJson(review)).toList();
  }

  static List<Movie> loadMovies() {
    final allMovies = <Movie>[
      Movie(
        id: "0",
        title: 'O Hobbit: Uma Jornada Inesperada',
        posterUrl: 'assets/images/hobbit.jpg',
        releaseYear: 2012,
        duration: 182,
        genres: ['Fantasia', 'Aventura'],
        score: 78,
        streamingServices: [PrimeVideo()],
      ),
      Movie(
        id: "1",
        title: 'Matrix',
        posterUrl: 'assets/images/matrix.jpg',
        releaseYear: 1999,
        duration: 136,
        genres: ['Ação', 'Ficção Científica'],
        score: 87,
        streamingServices: [Netflix()],
      ),
      Movie(
        id: '2',
        title: 'Star Wars IV: Uma nova Esperaça',
        posterUrl: 'assets/images/star_wars.jpg',
        releaseYear: 1977,
        duration: 121,
        genres: ['Ação', 'Fantasia', 'Aventura'],
        score: 86,
        streamingServices: [DisneyPlus()],
      ),
      Movie(
        id: '3',
        title: 'Bastardos Inglórios',
        posterUrl: 'assets/images/inglorious_bastards.jpg',
        releaseYear: 2009,
        duration: 153,
        genres: ['Aventura', 'Drama', 'Guerra'],
        score: 83,
        streamingServices: [PrimeVideo(), Netflix()],
      ),
    ];
    return allMovies;
  }
}
