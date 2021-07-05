import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'movie.dart';

class MovieTile extends StatelessWidget {
  final Movie movie;

  const MovieTile({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: Card(
        elevation: 2.0,
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
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    SizedBox(height: 8.0),
                    Text(
                        'FILME | Ano: ${movie.releaseYear} | Duração: ${movie.duration}'),
                    Text('Gêneros: ${movie.genres.join('/')}'),
                    Text('NOTA: ${movie.score} (IMDB)'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: movie.streamingServices
                          .expand((svc) => [SizedBox(width: 8.0), _streamingServiceLogo(svc)])
                          .toList(),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _streamingServiceLogo(StreamingService svc) {
    switch (svc) {
      case StreamingService.netflix:
        return SvgPicture.asset(
          'assets/images/netflix_logo.svg',
          height: 20,
        );
      case StreamingService.disneyPlus:
        return SvgPicture.asset(
          'assets/images/disney_plus_logo.svg',
          height: 20,
        );
      case StreamingService.primeVideo:
        return SvgPicture.asset(
          'assets/images/prime_video_logo.svg',
          height: 20,
        );
      default:
        throw Exception('Unknown streaming $svc');
    }
  }
}
