import 'package:app/models/movie.dart';

class MovieReview {
  final Movie movie;
  final double rating;

  MovieReview._(this.movie, this.rating);

  factory MovieReview.fromJson(Map<String, dynamic> json) {
    final movie = Movie.fromJson(json['movie']);
    return MovieReview._(movie, json['rating']);
  }
}