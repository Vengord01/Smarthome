import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:smart_home/model/user_info.dart';
import 'package:smart_home/pages/home_page/home_page.dart';
import 'package:smart_home/pages/login_page/login_page.dart';
import 'package:smart_home/utils/api.dart';
import 'package:smart_home/utils/cache.dart';
import 'package:smart_home/utils/const.dart';
import 'package:smart_home/widgets/loading_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'model/token.dart';

const SnackBar snackBar = SnackBar(content: Text("Ошибка авторизации"));

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  ThemeData _buildTheme(brightness) {
    var baseTheme = ThemeData(brightness: brightness);

    return baseTheme.copyWith(
      textTheme: GoogleFonts.interTextTheme(const TextTheme()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _buildTheme(Brightness.dark),
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
    );
  }
}
