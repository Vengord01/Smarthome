import 'dart:convert';
import 'dart:developer';

import 'package:smart_home/model/user_info.dart';

import '../model/token.dart';
import 'package:http/http.dart' as http;

import 'const.dart';

class Api {
  Api._privateConstructor();

  static final Api instance = Api._privateConstructor();

  Future<Token?> getToken(String code) async {
    try {
      final response = await http.post(
        Uri.parse(getTokenUrl),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
        },
        encoding: Encoding.getByName('utf-8'),
        body: {
          "grant_type": "authorization_code",
          "code": code,
          "client_id": clientId,
          "client_secret": clienSecret,
        },
      );
      return Token.fromJson(jsonDecode(response.body));
    } catch (error) {
      log("getToken: ${error.toString()}");
      return null;
    }
  }

  Future<UserInfo?> getUserInfo(String token) async {
    try {
      final response = await http.get(
        Uri.parse(getUserInfoUrl),
        headers: {"Authorization": "Bearer $token"},
      );
      log(response.body.toString());
      return UserInfo.fromJson(jsonDecode(response.body));
    } catch (_) {
      return null;
    }
  }

  Future<Device?> updateDeviceInfo(String id, String token) async {
    //  try {
    final response = await http.get(
      Uri.parse("$getDeviceInfoUrl/$id"),
      headers: {"Authorization": "Bearer $token"},
    );
    return Device.fromJson(jsonDecode(response.body));
    // }
    //  catch (_) {
    //     return null;
  }
}
