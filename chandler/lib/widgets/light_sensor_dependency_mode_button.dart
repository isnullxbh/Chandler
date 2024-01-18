import 'package:chandler/client.dart';
import 'package:chandler/mcu/device_identity.dart';
import 'package:chandler/mcu/device_type.dart';
import 'package:chandler/mcu/light_sensor_dependency.dart';
import 'package:chandler/mcu/state.dart';
import 'package:flutter/material.dart';

class LightSensorDependencyModeButton extends StatefulWidget {
  final Client client;
  final DeviceIdentity deviceIdentity;
  final McuState mcuState;

  const LightSensorDependencyModeButton({super.key, required this.client, required this.deviceIdentity, required this.mcuState});

  static final List<String> states = <String>["Выкл.", "Прямой", "Инверсный"];

  @override
  State<LightSensorDependencyModeButton> createState() => _LightSensorDependencyModeButtonState();
}

class _LightSensorDependencyModeButtonState extends State<LightSensorDependencyModeButton> {
  String value = "";

  static String getModeDescriptor(LightSensorDependency dependency) {
    switch (dependency) {
      case LightSensorDependency.disabled:
        return "Выкл.";
      case LightSensorDependency.inverse:
        return "Инверсный";
      case LightSensorDependency.direct:
        return "Прямой";
    }
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.deviceIdentity.type) {
      case DeviceType.relay:
        value = getModeDescriptor(widget.deviceIdentity.index! == 1 ? widget.mcuState.relay1Lsd : widget.mcuState.relay2Lsd);
        break;

      case DeviceType.ledStrip:
        value = getModeDescriptor(widget.mcuState.ledStripLsd);
        break;

      default:
        value = "Выкл.";
    }

    return DropdownButton<String>(
      value: value,
      onChanged: (String? newValue) {
        setState(() => value = newValue!);
        if (newValue != null) {
          switch (newValue!) {
            case "Выкл.":
              if (widget.deviceIdentity.type == DeviceType.relay) {
                widget.client.setLightSensorDependencyForRelay(widget.deviceIdentity.index!, LightSensorDependency.disabled);
              } else if (widget.deviceIdentity.type == DeviceType.ledStrip) {
                widget.client.setLightSensorDependencyForLedStrip(LightSensorDependency.disabled);
              }
              break;

            case "Прямой":
              if (widget.deviceIdentity.type == DeviceType.relay) {
                widget.client.setLightSensorDependencyForRelay(widget.deviceIdentity.index!, LightSensorDependency.direct);
              } else if (widget.deviceIdentity.type == DeviceType.ledStrip) {
                widget.client.setLightSensorDependencyForLedStrip(LightSensorDependency.direct);
              }
              break;

            case "Инверсный":
              if (widget.deviceIdentity.type == DeviceType.relay) {
                widget.client.setLightSensorDependencyForRelay(widget.deviceIdentity.index!, LightSensorDependency.inverse);
              } else if (widget.deviceIdentity.type == DeviceType.ledStrip) {
                widget.client.setLightSensorDependencyForLedStrip(LightSensorDependency.inverse);
              }
              break;
          }
        }
      },
      items: LightSensorDependencyModeButton.states.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
