// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:signalr_netcore/hub_connection.dart';

class HubConnectionProvider extends ChangeNotifier {
  HubConnection? _hubConnection;

  HubConnection? get hubConnection => _hubConnection;

  void updateHub(HubConnection hubConnection) {
    _hubConnection = hubConnection;
    notifyListeners();
  }

  void clearHub() {
    _hubConnection = null;
    notifyListeners();
  }
}
