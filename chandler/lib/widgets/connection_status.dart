import 'package:flutter/material.dart';

class ConnectionStatus extends StatefulWidget {
  const ConnectionStatus({ super.key });

  @override
  State<ConnectionStatus> createState() => _ConnectionStatusState();
}

class _ConnectionStatusState extends State<ConnectionStatus> {
  @override
  Widget build(BuildContext context) {
    return Container(child: const Text("Connected"),);
  }
}
