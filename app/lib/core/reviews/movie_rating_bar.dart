import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MovieRatingBar extends StatefulWidget {
  final Function(double)? onRatingUpdate;
  final bool enabled;
  final double initialRating;

  const MovieRatingBar({
    Key? key,
    required this.enabled,
    required this.initialRating,
    this.onRatingUpdate,
  }) : super(key: key);

  @override
  _MovieRatingBarState createState() => _MovieRatingBarState();
}

class _MovieRatingBarState extends State<MovieRatingBar> {
  Timer? _debounce;

  @override
  Widget build(BuildContext context) {
    return widget.enabled
        ? _ratingBarBuilder(context)
        : IgnorePointer(child: _ratingBarBuilder(context));
  }

  Widget _ratingBarBuilder(BuildContext context) {
    return RatingBar.builder(
      minRating: 0.5,
      maxRating: 5,
      initialRating: widget.initialRating,
      allowHalfRating: true,
      glowColor: Colors.amberAccent,
      itemBuilder: (context, _) => Icon(
        Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: (rating) {
        if (!widget.enabled) {
          return;
        }
        if (_debounce?.isActive ?? false) {
          _debounce?.cancel();
        }
        _debounce = Timer(const Duration(seconds: 1), () {
          // TODO: Make backend request to add rating to movie
          widget.onRatingUpdate!(rating);
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
