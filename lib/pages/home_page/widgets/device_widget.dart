import 'package:flutter/material.dart';
import 'package:smart_home/pages/device_page/device_page.dart';

import '../../../model/user_info.dart';

class DeviceWidget extends StatefulWidget {
  final Device device;
  final Room room;
  final Household household;
  const DeviceWidget(
      {super.key,
      required this.device,
      required this.room,
      required this.household});

  @override
  State<DeviceWidget> createState() => _DeviceWidgetState();
}

class _DeviceWidgetState extends State<DeviceWidget> {
  bool isOn = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (builder) => DevicePage(
                device: widget.device,
                room: widget.room,
                household: widget.household,
              ),
            ),
          );
        },
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
                  deviceIcon(),
                  text(),
                  action(),
                ]),
          ),
        ),
      ),
    );
  }

  Icon deviceIcon() {
    switch (widget.device.type) {
      case "devices.types.light":
        return const Icon(Icons.lightbulb, size: 55);
      case "devices.types.openable":
        return const Icon(Icons.door_sliding_rounded, size: 55);
      case "devices.types.sensor.climate":
        return const Icon(Icons.settings_remote_sharp, size: 55);
    }
    return const Icon(Icons.question_mark_outlined, size: 55);
  }

  Widget text() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.device.name!,
              textAlign: TextAlign.start,
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
            ),
            Text(
              widget.room.name!,
              textAlign: TextAlign.start,
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
            )
          ],
        ),
      ),
    );
  }

  Widget action() {
    switch (widget.device.type) {
      case "devices.types.light":
        Capability deviceCapability = widget.device.capabilities!.firstWhere(
            (element) => element.type == "devices.capabilities.on_off");

        return Text(
          deviceCapability.state?.value == true ? "ВКЛ" : "ВЫКЛ",
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 20,
              color: deviceCapability.state?.value == true
                  ? Colors.green
                  : Colors.red),
        );
      case "devices.types.sensor.climate":
        Property property = widget.device.properties!.firstWhere(
            (element) => element.parameters?.instance == "humidity");
        return Text("${property.state!.value.toString()} %",
            style: const TextStyle(
                fontWeight: FontWeight.w700, fontSize: 20, color: Colors.blue));
      case "devices.types.openable":
        return Container();
    }
    return const Icon(Icons.question_mark_outlined, size: 55);
  }
}
