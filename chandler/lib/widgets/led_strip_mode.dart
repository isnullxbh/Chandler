import 'package:chandler/client.dart';
import 'package:chandler/mcu/device_identity.dart';
import 'package:chandler/mcu/led_strip_state.dart';
import 'package:chandler/mcu/state.dart';
import 'package:flutter/material.dart';

class LedStripMode extends StatefulWidget {
  final DeviceIdentity deviceIdentity;
  final Client client;
  final McuState mcuState;

  const LedStripMode({super.key, required this.deviceIdentity, required this.client, required this.mcuState});

  static final List<String> states = <String>["Выкл.", "Пресет 1", "Пресет 2", "Пресет 3"];

  @override
  State<LedStripMode> createState() => _LedStripModeStatus();
}

class _LedStripModeStatus extends State<LedStripMode> {
  String value = "";

  static String getStateDescriptor(LedStripState state) {
    switch (state) {
      case LedStripState.disabled:
        return "Выкл.";

      case LedStripState.coolWhite:
        return "Пресет 1";

      case LedStripState.moderateWhite:
        return "Пресет 2";

      case LedStripState.warmWhite:
        return "Пресет 3";
    }
  }

  @override
  Widget build(BuildContext context) {
    value = getStateDescriptor(widget.mcuState.ledStripState);
    return DropdownButton<String>(
      value: value,
      onChanged: (String? newValue) {
        setState(() => value = newValue!);
        if (newValue != null) {
          switch (newValue!) {
            case "Выкл.":
              widget.client.setLedStripState(LedStripState.disabled);
              break;

            case "Пресет 1":
              widget.client.setLedStripState(LedStripState.coolWhite);
              break;

            case "Пресет 2":
              widget.client.setLedStripState(LedStripState.moderateWhite);
              break;

            case "Пресет 3":
              widget.client.setLedStripState(LedStripState.warmWhite);
              break;
          }
        }
      },
      items: LedStripMode.states.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
