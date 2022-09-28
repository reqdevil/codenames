// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:signalr_netcore/hub_connection.dart';

class HubConnectionProvider extends ChangeNotifier {
  HubConnection? _hubConnection;

  HubConnection? get hubConnection => _hubConnection;

  void updateKisi(HubConnection hubConnection) {
    _hubConnection = hubConnection;
    notifyListeners();
  }

  void clearKisi() {
    _hubConnection = null;
    notifyListeners();
  }
}
