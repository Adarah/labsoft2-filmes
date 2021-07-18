import 'package:app/models/streaming_service.dart';
import 'package:flutter/foundation.dart';

class LinkedAccountsViewmodel with ChangeNotifier {
  // Replace this by network call
  Set<StreamingService> _enabledServices = Set();
  Iterable<StreamingService> get enabledServices => _enabledServices;
  toggleService(StreamingService service, bool isEnabled) {
    if (isEnabled) {
      _enabledServices.add(service);
    } else {
      _enabledServices.remove(service);
    }
    notifyListeners();
  }
}