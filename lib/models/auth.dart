import 'package:charum/models/user.dart';

class LoginModel {
  String? status;
  String? tokens;
  Data? data;

  LoginModel({this.status, this.tokens, this.data});

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    tokens = json['tokens'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['tokens'] = tokens;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}
