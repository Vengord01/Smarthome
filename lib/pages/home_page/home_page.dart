import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_home/model/token.dart';
import 'package:smart_home/pages/home_page/widgets/device_widget.dart';
import 'package:smart_home/pages/login_page/login_page.dart';
import 'package:smart_home/utils/cache.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../model/user_info.dart';
import '../../utils/api.dart';
import '../../widgets/loading_widget.dart';

class HomePage extends StatefulWidget {
  final Token token;
  const HomePage({super.key, required this.token});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UserInfo? userInfo;
  Timer? timer;

  @override
  void initState() {
    super.initState();

    Timer.periodic(const Duration(seconds: 5), (timer) {
      getUserInfo();
    });
    getUserInfo();
  }

  void getUserInfo() async {
    final info = await Api.instance.getUserInfo(widget.token.accessToken);

    setState(() {
      userInfo = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (userInfo == null) {
      return const LoadingWidget();
    }
    return Scaffold(appBar: appBar(), body: deviceList());
  }

  Widget logOutIcon() {
    return IconButton(
        onPressed: () async {
          final cookieManager = WebViewCookieManager();
          await cookieManager.clearCookies();
          Cache.instance.clearCache();
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (builder) => const LoginPage()));
        },
        icon: const Icon(
          Icons.logout,
          size: 30,
        ));
  }

  AppBar appBar() {
    return AppBar(
      title: const Text(
        "Мои устройства",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
      ),
      actions: [logOutIcon()],
    );
  }

  Widget deviceList() {
    return RefreshIndicator(
      color: Colors.white,
      backgroundColor: Colors.blue,
      strokeWidth: 4.0,
      onRefresh: () async {
        // Replace this delay with the code to be executed during refresh
        // and return a Future when code finishes execution.
        return getUserInfo();
      },
      // Pull from top to show refresh indicator.
      child: ListView.builder(
        itemCount: userInfo!.devices?.length ?? 0,
        itemBuilder: (context, index) {
          Device device = userInfo!.devices![index];
          Household household = userInfo!.households!
              .firstWhere((household) => household.id == device.householdId);
          Room room =
              userInfo!.rooms!.firstWhere((room) => room.id == device.room);
          return DeviceWidget(
            device: device,
            room: room,
            household: household,
          );
        },
      ),
    );
  }
}
