import 'dart:convert';

Device deviceFromJson(String str) => Device.fromJson(json.decode(str));

String deviceToJson(Device data) => json.encode(data.toJson());

class Device {
  final String status;
  final String requestId;
  final String id;
  final String name;
  final List<String> aliases;
  final String type;
  final String state;
  final List<String> groups;
  final String room;
  final String externalId;
  final String skillId;
  final List<Capability> capabilities;
  final List<Capability> properties;

  Device({
    required this.status,
    required this.requestId,
    required this.id,
    required this.name,
    required this.aliases,
    required this.type,
    required this.state,
    required this.groups,
    required this.room,
    required this.externalId,
    required this.skillId,
    required this.capabilities,
    required this.properties,
  });

  factory Device.fromJson(Map<String, dynamic> json) => Device(
        status: json["status"],
        requestId: json["request_id"],
        id: json["id"],
        name: json["name"],
        aliases: List<String>.from(json["aliases"].map((x) => x)),
        type: json["type"],
        state: json["state"],
        groups: List<String>.from(json["groups"].map((x) => x)),
        room: json["room"],
        externalId: json["external_id"],
        skillId: json["skill_id"],
        capabilities: List<Capability>.from(
            json["capabilities"].map((x) => Capability.fromJson(x))),
        properties: List<Capability>.from(
            json["properties"].map((x) => Capability.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "request_id": requestId,
        "id": id,
        "name": name,
        "aliases": List<dynamic>.from(aliases.map((x) => x)),
        "type": type,
        "state": state,
        "groups": List<dynamic>.from(groups.map((x) => x)),
        "room": room,
        "external_id": externalId,
        "skill_id": skillId,
        "capabilities": List<dynamic>.from(capabilities.map((x) => x.toJson())),
        "properties": List<dynamic>.from(properties.map((x) => x.toJson())),
      };
}

class Capability {
  final bool retrievable;
  final String type;
  final Parameters parameters;
  final Parameters state;
  final double lastUpdated;

  Capability({
    required this.retrievable,
    required this.type,
    required this.parameters,
    required this.state,
    required this.lastUpdated,
  });

  factory Capability.fromJson(Map<String, dynamic> json) => Capability(
        retrievable: json["retrievable"],
        type: json["type"],
        parameters: Parameters.fromJson(json["parameters"]),
        state: Parameters.fromJson(json["state"]),
        lastUpdated: json["last_updated"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "retrievable": retrievable,
        "type": type,
        "parameters": parameters.toJson(),
        "state": state.toJson(),
        "last_updated": lastUpdated,
      };
}

class Parameters {
  Parameters();

  factory Parameters.fromJson(Map<String, dynamic> json) => Parameters();

  Map<String, dynamic> toJson() => {};
}
