import 'dart:convert';

import 'package:app/models/movie_user.dart';
import 'package:app/models/streaming_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart' as Firebase;

class BackendService {
  final String repoUrl = dotenv.env['BACKEND_URL']!;

  Future<MovieUser> login(Firebase.User firebaseUser) async {
    final getUseruri = Uri.parse('$repoUrl/user/${firebaseUser.uid}');
    final response = await http.get(getUseruri);
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

  Future<void> updateStreamingServices(
      List<StreamingService> svcs, String userId) async {
    final uri = Uri.parse('$repoUrl/api/user/$userId');
    final response = await http.patch(
      uri,
      body: jsonEncode({'streamings': svcs.map((svc) => svc.id)}),
    );
  }
}
