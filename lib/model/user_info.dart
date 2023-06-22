// To parse this JSON data, do
//
//     final userInfo = userInfoFromJson(jsonString);

import 'dart:convert';

UserInfo userInfoFromJson(String str) => UserInfo.fromJson(json.decode(str));

String userInfoToJson(UserInfo data) => json.encode(data.toJson());

class UserInfo {
  final String? status;
  final String? requestId;
  final List<Room>? rooms;
  final List<dynamic>? groups;
  final List<Device>? devices;
  final List<dynamic>? scenarios;
  final List<Household>? households;

  UserInfo({
    this.status,
    this.requestId,
    this.rooms,
    this.groups,
    this.devices,
    this.scenarios,
    this.households,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
        status: json["status"],
        requestId: json["request_id"],
        rooms: json["rooms"] == null
            ? []
            : List<Room>.from(json["rooms"]!.map((x) => Room.fromJson(x))),
        groups: json["groups"] == null
            ? []
            : List<dynamic>.from(json["groups"]!.map((x) => x)),
        devices: json["devices"] == null
            ? []
            : List<Device>.from(
                json["devices"]!.map((x) => Device.fromJson(x))),
        scenarios: json["scenarios"] == null
            ? []
            : List<dynamic>.from(json["scenarios"]!.map((x) => x)),
        households: json["households"] == null
            ? []
            : List<Household>.from(
                json["households"]!.map((x) => Household.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "request_id": requestId,
        "rooms": rooms == null
            ? []
            : List<dynamic>.from(rooms!.map((x) => x.toJson())),
        "groups":
            groups == null ? [] : List<dynamic>.from(groups!.map((x) => x)),
        "devices": devices == null
            ? []
            : List<dynamic>.from(devices!.map((x) => x.toJson())),
        "scenarios": scenarios == null
            ? []
            : List<dynamic>.from(scenarios!.map((x) => x)),
        "households": households == null
            ? []
            : List<dynamic>.from(households!.map((x) => x.toJson())),
      };
}

class Device {
  final String? id;
  final String? name;
  final List<dynamic>? aliases;
  final String? type;
  final String? externalId;
  final String? skillId;
  final String? householdId;
  final String? room;
  final List<dynamic>? groups;
  final List<Capability>? capabilities;
  final List<Property>? properties;

  Device({
    this.id,
    this.name,
    this.aliases,
    this.type,
    this.externalId,
    this.skillId,
    this.householdId,
    this.room,
    this.groups,
    this.capabilities,
    this.properties,
  });

  factory Device.fromJson(Map<String, dynamic> json) => Device(
        id: json["id"],
        name: json["name"],
        aliases: json["aliases"] == null
            ? []
            : List<dynamic>.from(json["aliases"]!.map((x) => x)),
        type: json["type"],
        externalId: json["external_id"],
        skillId: json["skill_id"],
        householdId: json["household_id"],
        room: json["room"],
        groups: json["groups"] == null
            ? []
            : List<dynamic>.from(json["groups"]!.map((x) => x)),
        capabilities: json["capabilities"] == null
            ? []
            : List<Capability>.from(
                json["capabilities"]!.map((x) => Capability.fromJson(x))),
        properties: json["properties"] == null
            ? []
            : List<Property>.from(
                json["properties"]!.map((x) => Property.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "aliases":
            aliases == null ? [] : List<dynamic>.from(aliases!.map((x) => x)),
        "type": type,
        "external_id": externalId,
        "skill_id": skillId,
        "household_id": householdId,
        "room": room,
        "groups":
            groups == null ? [] : List<dynamic>.from(groups!.map((x) => x)),
        "capabilities": capabilities == null
            ? []
            : List<dynamic>.from(capabilities!.map((x) => x.toJson())),
        "properties": properties == null
            ? []
            : List<dynamic>.from(properties!.map((x) => x.toJson())),
      };
}

class Capability {
  final bool? reportable;
  final bool? retrievable;
  final String? type;
  final CapabilityParameters? parameters;
  final CapabilityState? state;

  Capability({
    this.reportable,
    this.retrievable,
    this.type,
    this.parameters,
    this.state,
  });

  factory Capability.fromJson(Map<String, dynamic> json) => Capability(
        reportable: json["reportable"],
        retrievable: json["retrievable"],
        type: json["type"],
        parameters: json["parameters"] == null
            ? null
            : CapabilityParameters.fromJson(json["parameters"]),
        state: json["state"] == null
            ? null
            : CapabilityState.fromJson(json["state"]),
      );

  Map<String, dynamic> toJson() => {
        "reportable": reportable,
        "retrievable": retrievable,
        "type": type,
        "parameters": parameters?.toJson(),
        "state": state?.toJson(),
      };
}

class CapabilityParameters {
  final bool? split;

  CapabilityParameters({
    this.split,
  });

  factory CapabilityParameters.fromJson(Map<String, dynamic> json) =>
      CapabilityParameters(
        split: json["split"],
      );

  Map<String, dynamic> toJson() => {
        "split": split,
      };
}

class CapabilityState {
  final String? instance;
  final bool? value;

  CapabilityState({
    this.instance,
    this.value,
  });

  factory CapabilityState.fromJson(Map<String, dynamic> json) =>
      CapabilityState(
        instance: json["instance"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "instance": instance,
        "value": value,
      };
}

class Property {
  final String? type;
  final bool? reportable;
  final bool? retrievable;
  final PropertyParameters? parameters;
  final PropertyState? state;

  Property({
    this.type,
    this.reportable,
    this.retrievable,
    this.parameters,
    this.state,
  });

  factory Property.fromJson(Map<String, dynamic> json) => Property(
        type: json["type"],
        reportable: json["reportable"],
        retrievable: json["retrievable"],
        parameters: json["parameters"] == null
            ? null
            : PropertyParameters.fromJson(json["parameters"]),
        state: json["state"] == null
            ? null
            : PropertyState.fromJson(json["state"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "reportable": reportable,
        "retrievable": retrievable,
        "parameters": parameters?.toJson(),
        "state": state?.toJson(),
      };
}

class PropertyParameters {
  final String? instance;
  final String? unit;

  PropertyParameters({
    this.instance,
    this.unit,
  });

  factory PropertyParameters.fromJson(Map<String, dynamic> json) =>
      PropertyParameters(
        instance: json["instance"],
        unit: json["unit"],
      );

  Map<String, dynamic> toJson() => {
        "instance": instance,
        "unit": unit,
      };
}

class PropertyState {
  final String? instance;
  final dynamic value;

  PropertyState({
    this.instance,
    this.value,
  });

  factory PropertyState.fromJson(Map<String, dynamic> json) => PropertyState(
        instance: json["instance"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "instance": instance,
        "value": value,
      };
}

class Household {
  final String? id;
  final String? name;

  Household({
    this.id,
    this.name,
  });

  factory Household.fromJson(Map<String, dynamic> json) => Household(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class Room {
  final String? id;
  final String? name;
  final String? householdId;
  final List<String>? devices;

  Room({
    this.id,
    this.name,
    this.householdId,
    this.devices,
  });

  factory Room.fromJson(Map<String, dynamic> json) => Room(
        id: json["id"],
        name: json["name"],
        householdId: json["household_id"],
        devices: json["devices"] == null
            ? []
            : List<String>.from(json["devices"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "household_id": householdId,
        "devices":
            devices == null ? [] : List<dynamic>.from(devices!.map((x) => x)),
      };
}
