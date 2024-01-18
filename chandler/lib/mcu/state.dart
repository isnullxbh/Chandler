import 'dart:typed_data';

import 'package:chandler/mcu/control_type.dart';
import 'package:chandler/mcu/led_strip_state.dart';
import 'package:chandler/mcu/light_sensor_dependency.dart';
import 'package:chandler/mcu/light_sensor_state.dart';

class McuState {
  ControlType controlType = ControlType.local;
  bool relay1Enabled = false;
  LightSensorDependency relay1Lsd = LightSensorDependency.disabled;
  bool relay2Enabled = false;
  LightSensorDependency relay2Lsd = LightSensorDependency.disabled;
  LedStripState ledStripState = LedStripState.disabled;
  LightSensorDependency ledStripLsd = LightSensorDependency.disabled;
  LightSensorState lightSensorState = LightSensorState.low;

  bool isRelayOn(int relayIndex) {
    switch (relayIndex) {
      case 1:
        return relay1Enabled;

      case 2:
        return relay2Enabled;

      default:
        throw Exception("Invalid index");
    }
  }

  void update(Uint8List data) {
    final tmp = createFrom(data);
    controlType = tmp.controlType;
    relay1Enabled = tmp.relay1Enabled;
    relay1Lsd = tmp.relay1Lsd;
    relay2Enabled = tmp.relay2Enabled;
    relay2Lsd = tmp.relay2Lsd;
    ledStripState = tmp.ledStripState;
    ledStripLsd = tmp.ledStripLsd;
    lightSensorState = tmp.lightSensorState;
  }

  static McuState createFrom(Uint8List data) {
    var state = McuState();
    state.controlType = ControlType.fromInt(data.elementAt(0))!;
    state.relay1Enabled = data.elementAt(1) == 1;
    state.relay1Lsd = LightSensorDependency.fromInt(data.elementAt(3))!;
    state.relay2Enabled = data.elementAt(2) == 1;
    state.relay2Lsd = LightSensorDependency.fromInt(data.elementAt(4))!;
    state.ledStripState = LedStripState.fromInt(data.elementAt(5))!;
    state.ledStripLsd = LightSensorDependency.fromInt(data.elementAt(6))!;
    state.lightSensorState = data.elementAt(7) == 0 ? LightSensorState.low : LightSensorState.high;
    return state;
  }
}
