import 'package:flutter/material.dart';

class LightSensorDependencyModeButton extends StatefulWidget {
  const LightSensorDependencyModeButton({super.key});

  static final List<String> states = <String>["Выкл.", "Прямой", "Инверсный"];

  @override
  State<LightSensorDependencyModeButton> createState() => _LightSensorDependencyModeButtonState();
}

class _LightSensorDependencyModeButtonState extends State<LightSensorDependencyModeButton> {
  String value = "Выкл.";
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: value,
      onChanged: (String? newValue) {
        setState(() => value = newValue!);
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
