import 'dart:io';

import 'package:charum/api/api.dart';
import 'package:charum/models/token.dart';
import 'package:charum/utils/logic_data.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AuthApi {
  register({
    required File cropped,
    required String name,
    required String username,
    required String email,
    required String password,
    required String passwordconfirmation,
    required BuildContext context,
  }) async {
    String fileName = cropped.path.split('/').last;

    FormData form = FormData.fromMap({
      'name': name,
      'username': username,
      'email': email,
      'password': password,
      'password_confirmation': passwordconfirmation,
      'profilepict': await MultipartFile.fromFile(
        cropped.path,
        filename: fileName,
      ),
    });

    return await dio.post(
      '$url/api/register',
      data: form,
    );
  }

  login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    FormData form = FormData.fromMap({
      'email': email,
      'password': password,
    });
    return await dio.post(
      '$url/api/login',
      data: form,
    );
  }

  logout() async {
    Token tokens = await Tokens().getTokens();

    return await dio.get(
      '$url/api/logout',
      options: Options(
        headers: {
          "Authorization": "Bearer ${tokens.accessToken}",
        },
      ),
    );
  }

  resendEmail({
    required String email,
  }) async {
    FormData form = FormData.fromMap({
      'email': email,
    });
    return await dio.post(
      '$url/api/resend_email',
      data: form,
    );
  }

  checkEmail({
    required String email,
  }) async {
    FormData form = FormData.fromMap({
      'email': email,
    });
    return await dio.post(
      '$url/api/check_verify_email',
      data: form,
    );
  }

  getdata() async {
    Token tokens = await Tokens().getTokens();

    return await dio.get(
      '$url/api/me',
      options: Options(
        headers: {
          "Authorization": "Bearer ${tokens.accessToken}",
        },
      ),
    );
  }

  refreshToken() async {
    Token tokens = await Tokens().getTokens();
    FormData form = FormData.fromMap({
      'refresh_token': tokens.refreshToken,
    });
    return await dio.post(
      '$url/api/refresh',
      data: form,
      options: Options(
        headers: {
          "Authorization": "Bearer ${tokens.accessToken}",
        },
      ),
    );
  }
}
