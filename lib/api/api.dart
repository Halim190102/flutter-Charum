import 'package:dio/dio.dart';

const url = 'http://192.168.136.56:8000';

Dio dio = Dio(
  BaseOptions(
    headers: {
      "Accept": "application/json",
    },
  ),
);
