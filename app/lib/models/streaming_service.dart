import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

abstract class StreamingService with EquatableMixin {
  abstract final String name;
  abstract final SvgPicture logo;

  List<Object?> get props => [name, logo];
}

class Netflix extends StreamingService {
  final String name = 'Netflix';
  SvgPicture logo = SvgPicture.asset('assets/images/netflix_logo.svg');
}

class DisneyPlus extends StreamingService {
  final String name = 'Disney+';
  SvgPicture logo = SvgPicture.asset('assets/images/disney_plus_logo.svg');
}

class PrimeVideo extends StreamingService {
  final String name = 'Prime Video';
  SvgPicture logo = SvgPicture.asset('assets/images/prime_video_logo.svg');
}

class HboMax extends StreamingService {
  final String name = 'netflix';
  SvgPicture logo = SvgPicture.asset('assets/images/netflix_logo.svg');
}
