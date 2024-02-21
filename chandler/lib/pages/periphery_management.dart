import 'dart:typed_data';

import 'package:chandler/client.dart';
import 'package:chandler/mcu/device_identity.dart';
import 'package:chandler/mcu/device_type.dart';
import 'package:chandler/widgets/led_strip.dart';
import 'package:chandler/widgets/light_sensor.dart';
import 'package:chandler/widgets/relay.dart';
import 'package:chandler/mcu/state.dart';
import 'package:flutter/material.dart';

class PeripheryManagementPage extends StatefulWidget {
  final Client client;
  final McuState mcuState;

  const PeripheryManagementPage({super.key, required this.client, required this.mcuState});

  @override
  State<PeripheryManagementPage> createState() => PeripheryManagementPageState();
}

class PeripheryManagementPageState extends State<PeripheryManagementPage> {
  @override
  Widget build(BuildContext context) {
    widget.client.onMessageReceived = (Uint8List data) {
      if (mounted) {
        setState(() => widget.mcuState.update(data));
      }
    };

    return Scaffold(
      appBar: AppBar(title: const Text("Управление периферией"),),
      body: Center(
        child: Column(
          children: <Widget>[
            Relay(deviceIdentity: const DeviceIdentity(type: DeviceType.relay, index: 1), client: widget.client, mcuState: widget.mcuState),
            Relay(deviceIdentity: const DeviceIdentity(type: DeviceType.relay, index: 2), client: widget.client, mcuState: widget.mcuState),
            LedStrip(deviceIdentity: const DeviceIdentity(type: DeviceType.ledStrip), client: widget.client, mcuState: widget.mcuState),
            LightSensor(client: widget.client, mcuState: widget.mcuState)
          ],
        ),
      ),
    );
  }
}
