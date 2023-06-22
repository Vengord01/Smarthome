import 'dart:convert';

Actions actionsFromJson(String str) => Actions.fromJson(json.decode(str));

String actionsToJson(Actions data) => json.encode(data.toJson());

class Actions {
  final List<Device> devices;

  Actions({
    required this.devices,
  });

  factory Actions.fromJson(Map<String, dynamic> json) => Actions(
        devices:
            List<Device>.from(json["devices"].map((x) => Device.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "devices": List<dynamic>.from(devices.map((x) => x.toJson())),
      };
}

class Device {
  final String id;
  final List<Action> actions;

  Device({
    required this.id,
    required this.actions,
  });

  factory Device.fromJson(Map<String, dynamic> json) => Device(
        id: json["id"],
        actions:
            List<Action>.from(json["actions"].map((x) => Action.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "actions": List<dynamic>.from(actions.map((x) => x.toJson())),
      };
}

class Action {
  final String type;
  final State state;

  Action({
    required this.type,
    required this.state,
  });

  factory Action.fromJson(Map<String, dynamic> json) => Action(
        type: json["type"],
        state: State.fromJson(json["state"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "state": state.toJson(),
      };
}

class State {
  State();

  factory State.fromJson(Map<String, dynamic> json) => State();

  Map<String, dynamic> toJson() => {};
}
