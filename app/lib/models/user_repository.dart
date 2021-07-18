import 'dart:convert';

import 'package:app/models/streaming_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class UserRepository {
  String repoUrl = dotenv.env['BACKEND_URL']!;

  Future<List<StreamingService>> loadEnabledServices(String userId) async {
    final url = Uri.parse('$repoUrl/users/$userId');
    final response = await http.get(url);
    final List<dynamic> body = jsonDecode(response.body);
    return body.map((movie) => StreamingService.fromId(serviceId).fromJson(movie)).toList();
  }
}
