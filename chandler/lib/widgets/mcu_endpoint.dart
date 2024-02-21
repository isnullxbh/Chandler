import 'dart:typed_data';

import 'package:chandler/client.dart';
import 'package:chandler/mcu/state.dart';
import 'package:chandler/pages/periphery_management.dart';
import 'package:flutter/material.dart';

class McuEndpoint extends StatefulWidget {
  final Client client;
  const McuEndpoint({super.key, required this.client});

  @override
  State<McuEndpoint> createState() => McuEndpointState();
}

class McuEndpointState extends State<McuEndpoint> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "[${widget.client.endpoint()}]",
          style: const TextStyle(color: Colors.blue),
        )
      ]
    );
  }
}
