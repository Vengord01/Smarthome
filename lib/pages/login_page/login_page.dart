import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:smart_home/main.dart';
import 'package:smart_home/model/token.dart';
import 'package:smart_home/pages/home_page/home_page.dart';
import 'package:smart_home/utils/api.dart';
import 'package:smart_home/utils/cache.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../utils/const.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late WebViewController? _controller;
  late String code;
  late Token? token;
  late Cache cache;

  void initCache() async {
    cache.init().then((_) {
      try {
        token = Token.fromJson(jsonDecode(cache.getFromCache("token")));
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (builder) => HomePage(token: token!)));
      } catch (error) {
        setState(() {
          _controller!.loadRequest(Uri.parse(loginUrl));
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _controller = WebViewController()
        ..clearCache()
        ..clearLocalStorage()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setNavigationDelegate(
          NavigationDelegate(
            onProgress: (int progress) {
              // Update loading bar.
            },
            onPageStarted: (String url) {},
            onPageFinished: (String url) {},
            onWebResourceError: (WebResourceError error) {},
            onNavigationRequest: (NavigationRequest request) async {
              if (request.url.startsWith(codeUrl)) {
                String code = request.url.replaceAll(codeUrl, "");

                token = await Api.instance.getToken(code);
                if (token == null) {
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  return NavigationDecision.navigate;
                }

                cache.saveToCache("token", tokenToJson(token!));

                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (builder) => HomePage(token: token!)));
              }
              return NavigationDecision.navigate;
            },
          ),
        );
    });

    cache = Cache.instance;
    initCache();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _controller == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: WebViewWidget(controller: _controller!),
            ),
    );
  }
}
