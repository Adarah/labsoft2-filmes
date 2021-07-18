import 'package:app/models/streaming_service.dart';
import 'package:app/viewmodels/auth_viewmodel.dart';
import 'package:flutter/foundation.dart';

class LinkedAccountsViewmodel with ChangeNotifier {
  AuthViewmodel _authModel;

  LinkedAccountsViewmodel(AuthViewmodel authViewmodel)
      : _authModel = authViewmodel;

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
