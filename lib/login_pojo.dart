import 'dart:convert';

class LoginResponse {
  final String message;
  final LoginData data;

  LoginResponse({required this.message, required this.data});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      message: json["message"],
      data: LoginData.fromJson(json["data"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "message": message,
      "data": data.toJson(),
    };
  }

  static LoginResponse fromRawJson(String str) => LoginResponse.fromJson(json.decode(str));
  String toRawJson() => json.encode(toJson());
}

class LoginData {
  final String token;

  LoginData({required this.token});

  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(
      token: json["token"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "token": token,
    };
  }
}
