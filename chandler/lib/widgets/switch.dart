import 'package:flutter/material.dart';

class SwitchButton extends StatefulWidget {
  const SwitchButton({super.key});

  static final List<String> states = <String>["Выкл.", "Вкл."];

  @override
  State<SwitchButton> createState() => _SwitchButtonState();
}

class _SwitchButtonState extends State<SwitchButton> {
  String value = "Выкл.";
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: value,
      onChanged: (String? newValue) {
        setState(() => value = newValue!);
      },
      items: SwitchButton.states.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}