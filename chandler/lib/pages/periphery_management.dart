import 'dart:typed_data';

import 'package:chandler/client.dart';
import 'package:chandler/mcu/device_identity.dart';
import 'package:chandler/mcu/device_type.dart';
import 'package:chandler/widgets/connection_status.dart';
import 'package:chandler/widgets/led_strip.dart';
import 'package:chandler/widgets/light_sensor.dart';
import 'package:chandler/widgets/relay.dart';
import 'package:chandler/mcu/state.dart';
import 'package:flutter/material.dart';

class PeripheryManagementPage extends StatefulWidget {
  final Client client;

  const PeripheryManagementPage({super.key, required this.client});

  @override
  State<PeripheryManagementPage> createState() => PeripheryManagementPageState();
}

class PeripheryManagementPageState extends State<PeripheryManagementPage> {
  var mcuState = McuState();

  @override
  Widget build(BuildContext context) {
    widget.client.getState().ignore();
    return Scaffold(
      appBar: AppBar(title: const Text("Управление периферией"),),
      body: Center(
        child: Column(
          children: <Widget>[
            const ConnectionStatus(),
            Relay(deviceIdentity: const DeviceIdentity(type: DeviceType.relay, index: 1), client: widget.client),
            Relay(deviceIdentity: const DeviceIdentity(type: DeviceType.relay, index: 2), client: widget.client),
            LedStrip(deviceIdentity: const DeviceIdentity(type: DeviceType.ledStrip), client: widget.client),
            LightSensor(client: widget.client)
          ],
        ),
      ),
    );
  }
}
