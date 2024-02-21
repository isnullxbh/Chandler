import 'dart:io';
import 'dart:typed_data';

import 'package:chandler/mcu/state.dart';
import 'package:chandler/pages/home.dart';
import 'package:chandler/pages/periphery_management.dart';
import 'package:flutter/material.dart';
import 'package:chandler/client.dart';

class AddMcuPage extends StatefulWidget {
  final List<Client> clients;
  const AddMcuPage({super.key, required this.clients});

  @override
  State<AddMcuPage> createState() => AddMcuPageState();
}

class AddMcuPageState extends State<AddMcuPage> {
  String _status = "";
  final  _endpointController = TextEditingController();
  BuildContext? _context;

  @override
  void dispose() {
    _endpointController.dispose();
    super.dispose();
  }

  void updateStatus(String status) {
    setState(() => _status = status);
  }

  void addMcu() async {
    final endpoint = _endpointController.text;
    final separator = endpoint.indexOf(":");

    if (separator == -1) {
      updateStatus("Invalid endpoint address");
      return;
    }

    final host = InternetAddress.tryParse(endpoint.substring(0, separator));
    final port = int.tryParse(endpoint.substring(separator + 1));

    if (host == null || port == null) {
      updateStatus("Invalid host/port");
      return;
    }

    Client.connect(host, port)
        .then(onConnectionEstablished)
        .catchError(handleConnectionError);
  }

  void onConnectionEstablished(Client client) {
    widget.clients.add(client);
    final route = MaterialPageRoute(builder: (context) => HomePage(clients: widget.clients));
    Navigator.push(_context!, route);
  }

  void handleConnectionError(error) {
    print("An error occurred while connecting to the MCU: $error");
  }

  @override
  Widget build(BuildContext context) {
    _context = context;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Добавление стенда"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(_status),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextField(
                    controller: _endpointController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Введите адрес (ip:port):"))
            ),
            TextButton(
                onPressed: addMcu,
                child: const Text("Добавить"))
          ],
        ),
      ),
    );
  }
}
