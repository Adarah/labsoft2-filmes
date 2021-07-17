import 'package:app/models/movie.dart';
import 'package:app/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';

class MovieDetailsScreen extends StatelessWidget {
  final Movie movie;

  const MovieDetailsScreen({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: movie.title,
      body: Placeholder(),
    );
  }
}
