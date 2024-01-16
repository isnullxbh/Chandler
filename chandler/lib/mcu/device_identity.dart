import 'package:chandler/mcu/device_type.dart';

class DeviceIdentity {
  final DeviceType type;
  final int? index;
  const DeviceIdentity({required this.type, this.index});
}
