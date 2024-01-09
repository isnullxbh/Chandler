import 'dart:io';

import 'package:chandler/pages/periphery_management.dart';
import 'package:flutter/material.dart';
import 'package:chandler/client.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int    _counter = 0;
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

  void _connectToMcu() async {
    final endpoint = _endpointController.text;
    final separator = endpoint.indexOf(":");

    if (separator == -1) {
      updateStatus("Invalid endpoint address");
      return;
    }

    final host = InternetAddress.tryParse(endpoint.substring(0, separator));
    final port = int.tryParse(endpoint.substring(separator + 1));

    if (host == null || port == null) {
      updateStatus("Invalid host or(and) port");
      return;
    }

    updateStatus("Connecting to $endpoint...");

    final client = Client.connect(host, port);

    client.then(onConnectionEstablished)
          .catchError(handleConnectionError);

    updateStatus("Connecting to $endpoint... Done");
  }

  void onConnectionEstablished(Client client) {
    Navigator.push(_context!,
        MaterialPageRoute(builder: (context) => PeripheryManagementPage(client: client)));
  }

  void handleConnectionError(error) {
    print("An error occurred while connecting to the MCU: $error");
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        // backgroundColor: Colors.black54,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(_status),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextField(
                controller: _endpointController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter MCU/SBC endpoint:"))
            ),
            TextButton(
                onPressed: _connectToMcu,
                child: const Text("Connect"))
          ],
        ),
      ),
    );
  }
}
