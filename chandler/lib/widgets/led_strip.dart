import 'package:chandler/widgets/led_strip_mode.dart';
import 'package:chandler/widgets/light_sensor_dependency_mode_button.dart';
import 'package:chandler/widgets/relay_switch.dart';
import 'package:flutter/material.dart';

import '../client.dart';
import '../mcu/device_identity.dart';

class LedStrip extends StatefulWidget {
  final DeviceIdentity deviceIdentity;
  final Client client;
  LedStrip({super.key, required this.deviceIdentity, required this.client});

  @override
  State<LedStrip> createState() => _LedStripState();
}

class _LedStripState extends State<LedStrip> {
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
                child: Image.asset("assets/images/led-light.png", height: 64,)
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text("Устройство: LED-лента",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black.withOpacity(0.9),
                      fontSize: 16
                    ))
                ],
              ),
              Row(
                children: <Widget>[
                  const Text("Состояние:"),
                  LedStripMode(deviceIdentity: widget.deviceIdentity, client: widget.client)
                ],
              ),
              Row(
                children: <Widget>[
                  const Text("Режим работы по датчику освещенности:")
                ],
              ),
              Row(children: <Widget>[
                LightSensorDependencyModeButton(deviceIdentity: widget.deviceIdentity, client: widget.client)
              ],)
            ],
          )
        ],
      ),
    );
  }
}
