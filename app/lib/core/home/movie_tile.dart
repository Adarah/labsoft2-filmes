import 'package:app/viewmodels/navigator_viewmodel.dart';
import 'package:app/widgets/ink_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../models/movie.dart';

class MovieTile extends StatelessWidget {
  final Movie movie;

  const MovieTile({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: Card(
        elevation: 2.0,
        child: Consumer<NavigatorViewmodel>(
          builder: (context, model, child) {
            return InkWrapper(
              onTap: () {
                model.selectedMovie = movie;
              }, child: child!,
            );
          },
          child: Row(
            children: [
              Image.asset(
                movie.posterUrl,
                fit: BoxFit.cover,
              ),
              SizedBox(width: 16.0),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0, right: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movie.title,
                        style: Theme
                            .of(context)
                            .textTheme
                            .headline6,
                      ),
                      SizedBox(height: 8.0),
                      Text('FILME | ${movie.releaseYear}'),
                      Text('${movie.score} (IMDB)'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: movie.streamingServices
                            .expand((svc) =>
                        [
                          SizedBox(
                            width: 100.0,
                            height: 20,
                            child: svc.logo,
                          ),
                        ])
                            .toList(),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),)
      ,
    );
  }
}
