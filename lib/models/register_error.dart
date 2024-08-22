class RegisterError {
  List<String>? username;
  List<String>? email;

  RegisterError({this.username, this.email});

  RegisterError.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['email'] = email;
    return data;
  }

  List<String> getMessages() {
    final messages = <String>[];

    if (username != null) {
      messages.addAll(username!);
    }

    if (email != null) {
      messages.addAll(email!);
    }

    return messages;
  }
}
