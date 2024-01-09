import 'package:chandler/widgets/light_sensor_dependency_mode_button.dart';
import 'package:chandler/widgets/switch.dart';
import 'package:flutter/material.dart';

class Relay extends StatefulWidget {

  final int index;

  Relay({super.key, required this.index});

  @override
  State<Relay> createState() => _RelayState();
}

class _RelayState extends State<Relay> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.85),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 1)
          )
        ]
      ),
      child: Row(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                width: 100,
                child: Image.asset("assets/images/switch-off.png", height: 64,)
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text("Устройство: Реле ${widget.index}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black.withOpacity(0.9),
                      fontSize: 16
                    ))
                ],
              ),
              Row(
                children: <Widget>[
                  Text("Состояние:"),
                  SwitchButton()
                ],
              ),
              Row(
                children: <Widget>[
                  Text("Режим работы по датчику освещенности:")
                ],
              ),
              Row(children: <Widget>[
                LightSensorDependencyModeButton()
              ],)
            ],
          )
        ],
      ),
    );
  }
}
