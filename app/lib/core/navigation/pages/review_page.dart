import 'package:app/core/reviews/reviews_screen.dart';
import 'package:flutter/material.dart';

class ReviewPage extends Page {
  const ReviewPage({Key? key}) : super(key: const ValueKey('ReviewPage'));

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) => ReviewScreen(),
    );
  }
}
