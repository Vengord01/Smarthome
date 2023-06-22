import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_home/model/token.dart';
import 'package:smart_home/utils/api.dart';

import '../../model/user_info.dart';
import '../../utils/cache.dart';

class DevicePage extends StatefulWidget {
  final Device device;
  final Room room;
  final Household household;

  const DevicePage(
      {super.key,
      required this.device,
      required this.room,
      required this.household});

  @override
  State<DevicePage> createState() => _DevicePageState();
}

class _DevicePageState extends State<DevicePage> {
  late Device _device;
  late Token token;

  @override
  void initState() {
    super.initState();
    setState(
      () {
        token =
            Token.fromJson(jsonDecode(Cache.instance.getFromCache("token")));
        Timer.periodic(
          const Duration(seconds: 5),
          (timer) async {
            final d = await Api.instance
                .updateDeviceInfo(widget.device.id!, token.accessToken);
            if (mounted) {
              if (d != null) {
                setState(
                  () {
                    _device = d;
                  },
                );
              }
            }
          },
        );

        _device = widget.device;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(_device.name!)),
        body: ListView(
          children: [
            deviceInfo(),
            ...List.generate(
                _device.capabilities?.length ?? 0, (index) => switcher()),
            ...List.generate(
                _device.properties?.length ?? 0, (index) => humidity()),
          ],
        ));
  }

  IconData deviceIcon() {
    switch (_device.type) {
      case "devices.types.light":
        return Icons.lightbulb;
      case "devices.types.sensor.climate":
        return Icons.settings_remote_sharp;
      default:
        return Icons.question_mark;
    }
  }

  Widget switcher() {
    Capability deviceCapability = _device.capabilities!
        .firstWhere((element) => element.type == "devices.capabilities.on_off");
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 100,
        decoration: BoxDecoration(
            color: const Color(0xFF363636),
            borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CupertinoSwitch(
                    value: deviceCapability.state?.value == true,
                    onChanged: (value) {}),
                Text(
                  deviceCapability.state?.value == true ? "ВКЛ" : "ВЫКЛ",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      color: deviceCapability.state?.value == true
                          ? Colors.green
                          : Colors.red),
                )
              ]),
        ),
      ),
    );
  }

  Widget humidity() {
    Property property = widget.device.properties!
        .firstWhere((element) => element.parameters?.instance == "humidity");
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 100,
        decoration: BoxDecoration(
            color: const Color(0xFF363636),
            borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
            const Icon(Icons.water_drop, size: 55),
            const Padding(padding: EdgeInsets.symmetric(horizontal: 4)),
            Text(
              "${property.state!.value.toString()} %",
              style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: Colors.blue),
            )
          ]),
        ),
      ),
    );
  }

  Widget textRow(String text1, String text2) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text(
            text1,
            style: TextStyle(color: Colors.grey.shade400),
          ),
          const Padding(padding: EdgeInsets.only(left: 8)),
          Text(
            text2,
            style: const TextStyle(fontWeight: FontWeight.w700),
          )
        ],
      ),
    );
  }

  Widget deviceInfo() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 100,
        decoration: BoxDecoration(
            color: const Color(0xFF363636),
            borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(children: [
            Icon(
              deviceIcon(),
              size: 50,
            ),
            Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  textRow("Дом", widget.household.name ?? ''),
                  textRow("Комната", widget.room.name ?? ''),
                ])
          ]),
        ),
      ),
    );
  }
}
