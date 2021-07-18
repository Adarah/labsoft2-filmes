import 'package:app/models/streaming_service.dart';

class MovieUser {
  final String id;
  final String username;
  final String? email;
  final List<StreamingService> streamingServices;

  MovieUser({
    required this.id,
    required this.username,
    required this.email,
    required this.streamingServices,
  });

  factory MovieUser.fromJson(Map<String, dynamic> json) {
    return MovieUser(
        id: json['id'],
        username: json['username'],
        email: json['email'],
        streamingServices: (json['streamings'].cast<int>() as List<int>)
            .map((i) => StreamingService.fromId(i))
            .toList());
  }
}
