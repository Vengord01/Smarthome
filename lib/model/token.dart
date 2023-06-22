import 'dart:convert';

Token tokenFromJson(String str) => Token.fromJson(json.decode(str));

String tokenToJson(Token data) => json.encode(data.toJson());

class Token {
  final String accessToken;
  final int expiresIn;
  final String refreshToken;
  final String tokenType;

  Token({
    required this.accessToken,
    required this.expiresIn,
    required this.refreshToken,
    required this.tokenType,
  });

  factory Token.fromJson(Map<String, dynamic> json) => Token(
        accessToken: json["access_token"],
        expiresIn: json["expires_in"],
        refreshToken: json["refresh_token"],
        tokenType: json["token_type"],
      );

  Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "expires_in": expiresIn,
        "refresh_token": refreshToken,
        "token_type": tokenType,
      };
}
