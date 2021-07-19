import 'dart:convert';

import 'package:app/models/streaming_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class UserPreferencesService {
  String repoUrl = dotenv.env['BACKEND_URL']!;

  Future<List<StreamingService>> loadEnabledServices(String userId) async {
    final url = Uri.parse('$repoUrl/user/$userId');
    final response = await http.get(url);
    final Map<String, dynamic> body = jsonDecode(response.body);
    return body['streamings']
        .map((serviceId) => StreamingService.fromId(serviceId))
        .toList();
  }
}
