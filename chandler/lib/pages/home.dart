import 'dart:io';
import 'dart:typed_data';

import 'package:chandler/mcu/state.dart';
import 'package:chandler/pages/add_mcu.dart';
import 'package:chandler/pages/periphery_management.dart';
import 'package:chandler/widgets/mcu_endpoint.dart';
import 'package:flutter/material.dart';
import 'package:chandler/client.dart';

class HomePage extends StatefulWidget {
  final List<Client> clients;

  const HomePage({super.key, required this.clients});

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  void goToPeripheryManagementPage(Client client, BuildContext context) {
    client.onMessageReceived = (Uint8List data) {
      final state = McuState.createFrom(data);
      final route = MaterialPageRoute(builder: (context) => PeripheryManagementPage(client: client, mcuState: state));
      Navigator.push(context, route);
    };
    client.getState().ignore();
  }

  ListView createMcuListView() {
    var view = ListView.builder(
        itemCount: widget.clients.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 4),
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                    "Тестовый стенд #$index ",
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                McuEndpoint(client: widget.clients[index]),
                TextButton(
                    onPressed: () => goToPeripheryManagementPage(widget.clients[index], context),
                    child: const Text("Управление")),
                TextButton(
                    onPressed: () {
                        widget.clients.removeAt(index);
                        setState(() => {});
                    },
                    child: const Text("Удалить"))
              ],
            ),
          );
        },
        scrollDirection: Axis.vertical,
        shrinkWrap: true);
    return view;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Список стендов"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              // color: Colors.blue,
              child: createMcuListView(),
            ),
            TextButton(
                onPressed: () => { Navigator.push(context, MaterialPageRoute(builder: (context) => AddMcuPage(clients: widget.clients))) },
                child: const Text("Добавить")),
          ],
        ),
      ),
    );
  }
}
