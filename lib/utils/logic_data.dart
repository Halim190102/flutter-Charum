import 'dart:async';
import 'dart:convert';

import 'package:charum/models/token.dart';
import 'package:charum/utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

tokenError(BuildContext context) async {
  await Tokens().reloadTokens();
  WidgetsBinding.instance.addPostFrameCallback((_) {
    showSnackBarFun(context, const Text('Login kembali'));
    Future.delayed(
      Duration.zero,
      () => Navigator.of(context).pushNamedAndRemoveUntil(
        '/login',
        (route) => false,
      ),
    );
  });
}

class Tokens {
  saveTokens(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('tokensKey', token);
  }

  Future<Token> getTokens() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final String? prefTokens = prefs.getString('tokensKey');
    if (prefTokens != null) {
      Map<String, dynamic> jsonMap = jsonDecode(prefTokens);
      return Token(
          accessToken: Token.fromJson(jsonMap).accessToken,
          refreshToken: Token.fromJson(jsonMap).refreshToken);
    } else {
      return Token();
    }
  }

  reloadTokens() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('tokensKey');
  }
}
