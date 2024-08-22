class UserModel {
  Data? data;

  UserModel({this.data});

  UserModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? username;
  String? profilepict;
  String? name;
  String? email;

  Data({this.id, this.username, this.profilepict, this.name, this.email, t});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    profilepict = json['profilepict'];
    name = json['name'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['profilepict'] = profilepict;
    data['name'] = name;
    data['email'] = email;

    return data;
  }
}
