import 'package:chandler/client.dart';
import 'package:chandler/widgets/connection_status.dart';
import 'package:chandler/widgets/led_strip.dart';
import 'package:chandler/widgets/light_sensor.dart';
import 'package:chandler/widgets/relay.dart';
import 'package:flutter/material.dart';

class PeripheryManagementPage extends StatefulWidget {
  final Client client;
  const PeripheryManagementPage({super.key, required this.client});

  @override
  State<PeripheryManagementPage> createState() => PeripheryManagementPageState();
}

class PeripheryManagementPageState extends State<PeripheryManagementPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Periphery Management"),),
      body: Center(
        child: Column(
          children: <Widget>[
            ConnectionStatus(),
            Relay(index: 1),
            Relay(index: 2),
            LedStrip(),
            LightSensor()
          ],
        ),
      ),
    );
  }
}
