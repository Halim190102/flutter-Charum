import 'dart:async';

import 'package:charum/models/token.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authNotifier = ChangeNotifierProvider<AuthNotifier>((ref) {
  return AuthNotifier();
});

class AuthNotifier extends ChangeNotifier {
  final StreamController<Token?> _authController =
      StreamController<Token?>.broadcast();

  Stream<Token?> get authStream => _authController.stream;

  void login(Token token) {
    _authController.sink.add(token);
    notifyListeners();
  }

  void logout() {
    _authController.sink.add(null);
    notifyListeners();
  }

  Future<Token?> fetchTokenFromStream() async {
    try {
      return await authStream.firstWhere((token) => token != null);
    } catch (e) {
      return null;
    }
  }

  @override
  void dispose() {
    _authController.close();
    super.dispose();
  }
}
