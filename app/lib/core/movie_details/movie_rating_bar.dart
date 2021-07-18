import 'dart:async';

import 'package:app/models/movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MovieRatingBar extends StatefulWidget {
  final Movie movie;

  const MovieRatingBar({Key? key, required this.movie}) : super(key: key);

  @override
  _MovieRatingBarState createState() => _MovieRatingBarState();
}

class _MovieRatingBarState extends State<MovieRatingBar> {
  Timer? _debounce;

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      minRating: 0.5,
      maxRating: 5,
      allowHalfRating: true,
      glowColor: Colors.amberAccent,
      itemBuilder: (context, _) => Icon(
        Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: (rating) {
        if (_debounce?.isActive ?? false) {
          _debounce?.cancel();
        }
        _debounce = Timer(const Duration(seconds: 1), () {
          // TODO: Make backend request to add rating to movie
          print(rating);
        });
      },
    );
  }

  @override
  dispose() {
    _debounce?.cancel();
    super.dispose();
  }
}
