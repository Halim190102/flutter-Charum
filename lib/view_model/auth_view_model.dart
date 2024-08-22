import 'dart:convert';

import 'package:charum/api/auth_api.dart';
import 'package:charum/models/register_error.dart';
import 'package:charum/models/token.dart';
import 'package:charum/models/user.dart';
import 'package:charum/utils/logic_data.dart';
import 'package:charum/utils/snackbar.dart';
import 'package:charum/utils/verify.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'dart:io';

final imageRegisProvider = StateProvider((ref) => '');

final authProvider = ChangeNotifierProvider<AuthProvider>((ref) {
  return AuthProvider();
});

class AuthProvider extends ChangeNotifier {
  final AuthApi _auth = AuthApi();

  Token? token;

  RegisterError? registerError;

  Data? data;

  String emails = '';

  String? verifMessage;

  authRegister({
    required File cropped,
    required String name,
    required String username,
    required String email,
    required String password,
    required String passwordconfirmation,
    required BuildContext context,
    required WidgetRef ref,
  }) async {
    Response response = await _auth.register(
      cropped: cropped,
      name: name,
      username: username,
      email: email,
      password: password,
      passwordconfirmation: passwordconfirmation,
      context: context,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      switch (response.data['type']) {
        case 0:
          registerError = RegisterError.fromJson(response.data);
          Navigator.of(context).pop();
          final errorMessages =
              registerError?.getMessages() ?? ['An unknown error occurred'];
          showSnackBarFun(
            context,
            Row(
              children: errorMessages.map((msg) => Text(msg)).toList(),
            ),
          );
          break;
        case 1:
          emails = email;
          Navigator.of(context).pop();
          showSnackBarFun(context,
              const Text('Register successfully, please verify your email'));
          verif(context, true);
          break;
        default:
      }
    });
    notifyListeners();
  }

  authLogin({
    required String email,
    required String password,
    required BuildContext context,
    required WidgetRef ref,
  }) async {
    Response response = await _auth.login(
      email: email,
      password: password,
      context: context,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      switch (response.data['type']) {
        case 0:
          Navigator.of(context).pop();
          showSnackBarFun(context, const Text('Failed to generate token'));
          break;
        case 1:
          token = Token.fromJson(response.data);
          Tokens().saveTokens(jsonEncode(token));
          await ref.read(authProvider.notifier).getDataUser(context: context);

          WidgetsBinding.instance.addPostFrameCallback((_) async {
            Navigator.of(context).pop();
            await Navigator.of(context)
                .pushNamedAndRemoveUntil('/menu', (route) => false);
          });
          break;
        case 2:
          Navigator.of(context).pop();
          showSnackBarFun(context, const Text('Email or password was wrong'));
          break;
        case 3:
          Navigator.of(context).pop();
          showSnackBarFun(context, const Text('Email not verified'));
          verif(context, false);
          break;
        case 4:
          Navigator.of(context).pop();
          showSnackBarFun(context, const Text('User not found'));
          break;
        default:
      }
    });
    notifyListeners();
  }

  checkEmailWasVerify({
    required String email,
    required BuildContext context,
    required bool registerPage,
  }) async {
    Response response = await _auth.checkEmail(email: email);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (response.data['type'] == 1) {
        Navigator.of(context).pop();
        registerPage
            ? Navigator.of(context)
                .pushNamedAndRemoveUntil('/login', (route) => false)
            : Navigator.of(context).pop();
        showSnackBarFun(context, const Text('Email verified successfully'));
      } else {
        Navigator.of(context).pop();
        verifMessage = 'Email has not been verified';
      }
    });
    notifyListeners();
  }

  resendEmailLink({
    required String email,
    required BuildContext context,
  }) async {
    Response response = await _auth.resendEmail(email: email);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (response.data['type'] == 1) {
        Navigator.of(context).pop();
        verifMessage = 'Link was sent successfully';
      }
    });
    notifyListeners();
  }

  authLogout({
    required BuildContext context,
  }) async {
    try {
      Response response = await _auth.logout();
      if (response.data['type'] == 1) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          tokenError(context);
        });
      }
    } catch (e) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        tokenError(context);
      });
    }
    notifyListeners();
  }

  getDataUser({
    required BuildContext context,
  }) async {
    try {
      print('sdfdsfsfd');

      Response response = await _auth.getdata();
      UserModel userModel = UserModel.fromJson(response.data);
      if (response.data['type'] == 1) {
        data = userModel.data;
      }
    } catch (e) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await refresh(
            context: context, function: getDataUser(context: context));
      });
    }
    notifyListeners();
  }

  refresh({required BuildContext context, required dynamic function}) async {
    try {
      Response response = await _auth.refreshToken();
      print(response.data['type']);
      if (response.data['type'] == 1) {
        token = Token.fromJson(response.data);
        await Tokens().saveTokens(jsonEncode(token));
        if (token != null) {
          Future.delayed(Duration.zero, () => function);
        }
      }
    } catch (e) {
      print(e);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        tokenError(context);
      });
    }
    notifyListeners();
  }
}
