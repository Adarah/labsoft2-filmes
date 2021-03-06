import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

abstract class StreamingService with EquatableMixin {
  final int id;
  final String name;
  final SvgPicture logo;

  StreamingService(int id, String name, SvgPicture logo)
      : id = id,
        name = name,
        logo = logo;

  List<Object?> get props => [name];

  @override
  String toString() {
    return name;
  }

  factory StreamingService.fromId(int serviceId) {
    switch (serviceId) {
      case (1):
        return Netflix();
      case (2):
        return DisneyPlus();
      case (3):
        return PrimeVideo();
      case (4):
        return HboMax();
      default:
        throw Exception('Unknown service id');
    }
  }
}

class Netflix extends StreamingService {
  // final String name = 'Netflix';
  // SvgPicture logo = SvgPicture.asset('assets/images/netflix_logo.svg');
  Netflix()
      : super(1, 'Netflix', SvgPicture.asset('assets/images/netflix_logo.svg'));
}

class DisneyPlus extends StreamingService {
  DisneyPlus()
      : super(2, 'Disney+', SvgPicture.asset('assets/images/disney_plus_logo.svg'));
}

class PrimeVideo extends StreamingService {
  PrimeVideo()
      : super(3, 'Prime Video+', SvgPicture.asset('assets/images/prime_video_logo.svg'));
}

class HboMax extends StreamingService {
  HboMax()
      : super(4, 'HBO Max', SvgPicture.asset('assets/images/hbo_max_logo.svg'));
}
