import 'dart:convert';

import 'package:app/models/movie_user.dart';
import 'package:app/models/streaming_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart' as Firebase;

class BackendService {
  final String repoUrl = dotenv.env['BACKEND_URL']!;

  Future<MovieUser> getUser(String id) async {
    final getUserUri = Uri.parse('$repoUrl/user/$id');
    final response = await http.get(getUserUri);
    return MovieUser.fromJson(jsonDecode(response.body));
  }

  Future<MovieUser> createUser(Firebase.User firebaseUser) async {
    final postUserUri = Uri.parse('$repoUrl/user');
    final response = await http.post(
      postUserUri,
      headers: {
        'Content-type': 'application/json'
      },
      body: jsonEncode(
        {
          'id': firebaseUser.uid,
          'email': firebaseUser.email,
          'username': firebaseUser.email,
          'age': 18,
          'streamings': [1, 2, 3, 4],
        },
      ),
    );
    return MovieUser.fromJson(jsonDecode(response.body));
  }

  Future<MovieUser> updateStreamingServices(
      List<StreamingService> svcs, String userId) async {
    final uri = Uri.parse('$repoUrl/user/$userId');
    final b =  jsonEncode({'streamings': svcs.map((svc) => svc.id).toList()});
    print(b);
    final response = await http.patch(
      uri,
      headers: {
        "Content-Type": "application/json",
      },
      body: b,
    );
    print(response.body);
    final body = jsonDecode(response.body);
    print(body);
    return MovieUser.fromJson(body);
  }

  Future<void> updateUserRating(String movieId, String userId, double rating) async {
    final uri = Uri.parse('$repoUrl/rating');
    final response = await http.post(
      uri,
      headers: {
        'Content-type': 'application/json'
      },
      body: jsonEncode(
        {
          "user": userId,
          "movie": movieId,
          "rating": rating,
          "review": "a",
          "created_at": DateTime.now().toIso8601String(),
        },
      ),
    );
    print(response.body);
    print(movieId);
    print('finished posting');
  }
}
