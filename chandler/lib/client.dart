import 'dart:io';
import 'dart:typed_data';

import 'package:chandler/mcu/led_strip_state.dart';
import 'package:chandler/mcu/light_sensor_dependency.dart';

class Client {
  final RawDatagramSocket _socket;
  final InternetAddress   _address;
  final int               _port;

  void Function(Uint8List data)? onMessageReceived;

  Client._construct(this._socket, this._address, this._port) {
    _socket.listen((event) {
      switch (event) {
        case RawSocketEvent.read:
          final datagram = _socket.receive();
          if (datagram != null && onMessageReceived != null) {
            onMessageReceived!(datagram.data);
          }
          break;

        case RawSocketEvent.closed:
          print("Socket was closed");
          break;

        default:
          print("Unknown event");
      }
    });
  }

  static Future<Client> connect(InternetAddress host, int port) async {
    final socket = RawDatagramSocket.bind(InternetAddress.anyIPv4, 0);
    return socket.then((socket) => Client._construct(socket, host, port));
  }

  String endpoint() {
    return "${_address.host}:$_port";
  }

  void enableRelay(int relayIndex) {
    print("Send command to enable relay ${relayIndex}...");
    var data = Uint8List(2);
    data[0] = relayIndex + 1;
    data[1] = 1;
    _socket.send(data, _address, _port);
    print("Send command to enable relay ${relayIndex}...Done");
  }

  void disableRelay(int relayIndex) {
    print("Send command to disable relay ${relayIndex}...");
    var data = Uint8List(2);
    data[0] = relayIndex + 1;
    data[1] = 0;
    _socket.send(data, _address, _port);
    print("Send command to disable relay ${relayIndex}...Done");
  }

  void setLightSensorDependencyForRelay(int relayIndex, LightSensorDependency mode) {
    print("Send command to set light sensor dependency mode for relay $relayIndex...");
    var data = Uint8List(2);
    data[0] = relayIndex + 3;
    data[1] = mode.index;
    _socket.send(data, _address, _port);
    print("Send command to set light sensor dependency mode for relay $relayIndex...Done");
  }

  void setLedStripState(LedStripState state) {
    print("Send command to set LED strip state...");
    var data = Uint8List(2);
    data[0] = 0x06;
    data[1] = state.index;
    _socket.send(data, _address, _port);
    print("Send command to set LED strip state...Done");
  }

  void setLightSensorDependencyForLedStrip(LightSensorDependency mode) {
    print("Send command to set light sensor dependency mode for LED strip...");
    var data = Uint8List(2);
    data[0] = 0x07;
    data[1] = mode.index;
    _socket.send(data, _address, _port);
    print("Send command to set light sensor dependency mode for LED strip...Done");
  }

  Future<bool> getState() async {
    print("Get state...");
    final data = Uint8List(2);
    data[0] = 0x08;
    data[1] = 0x00;
    final bytesTransferred = _socket.send(data, _address, _port);
    print("Get state...Done");
    return Future.value(bytesTransferred > 0);
  }
}
