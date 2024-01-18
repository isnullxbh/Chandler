import 'package:chandler/mcu/light_sensor_state.dart';
import 'package:chandler/mcu/state.dart';
import 'package:flutter/material.dart';

import '../client.dart';

class LightSensor extends StatefulWidget {
  final Client client;
  final McuState mcuState;
  const LightSensor({super.key, required this.client, required this.mcuState});

  @override
  State<LightSensor> createState() => _LightSensorState();
}

class _LightSensorState extends State<LightSensor> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
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
                child: Image.asset("assets/images/light-sensor.png", height: 64,)
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text("Устройство: Датчик освещенности",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black.withOpacity(0.9),
                      fontSize: 16
                    ))
                ],
              ),
              Row(
                children: <Widget>[
                  Text("Состояние: ${widget.mcuState.lightSensorState == LightSensorState.low ? "Низкое" : "Высокое"}"),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
