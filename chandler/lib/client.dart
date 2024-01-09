import 'dart:io';
import 'dart:typed_data';

class Client {
  final RawDatagramSocket _socket;
  final InternetAddress   _address;
  final int               _port;

  void _handleData(Uint8List data) {
    print("Data received: $data");
  }

  void _handleError(error) {
    print("An error occurred while reading: $error");
  }

  Client._construct(this._socket, this._address, this._port) {
    _socket.listen((event) {
      switch (event) {
        case RawSocketEvent.read:
          print("Receiving datagram...");
          final datagram = _socket.receive();
          print("Receiving datagram...Done");
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
