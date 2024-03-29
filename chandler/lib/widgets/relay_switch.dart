import 'package:chandler/client.dart';
import 'package:chandler/mcu/state.dart';
import 'package:flutter/material.dart';

class RelaySwitchButton extends StatefulWidget {
  final int index;
  final Client client;
  final McuState mcuState;

  const RelaySwitchButton({super.key, required this.index, required this.client, required this.mcuState});

  static final List<String> states = <String>["Выкл.", "Вкл."];

  @override
  State<RelaySwitchButton> createState() => _RelaySwitchButtonState();
}

class _RelaySwitchButtonState extends State<RelaySwitchButton> {
  String value = "Выкл.";

  @override
  Widget build(BuildContext context) {
    value = widget.mcuState.isRelayOn(widget.index) ? "Вкл." : "Выкл.";
    return DropdownButton<String>(
      value: value,
      onChanged: (String? newValue) {
        setState(() => value = newValue!);
        if (newValue != null) {
          switch (newValue!) {
            case "Вкл.":
              widget.client.enableRelay(widget.index);
              break;

            case "Выкл.":
              widget.client.disableRelay(widget.index);
              break;
          }
        }
      },
      items: RelaySwitchButton.states.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}