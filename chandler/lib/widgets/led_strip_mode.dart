import 'package:flutter/material.dart';

class LedStripMode extends StatefulWidget {
  const LedStripMode({super.key});

  static final List<String> states = <String>["Выкл.", "Пресет 1", "Пресет 2", "Пресет 3"];

  @override
  State<LedStripMode> createState() => _LedStripModeStatus();
}

class _LedStripModeStatus extends State<LedStripMode> {
  String value = "Выкл.";
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: value,
      onChanged: (String? newValue) {
        setState(() => value = newValue!);
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
