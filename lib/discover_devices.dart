import 'package:flutter/material.dart';
import 'package:flutter_blue_elves/flutter_blue_elves.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';

class DiscoverDevices extends StatefulWidget {
  const DiscoverDevices({Key? key}) : super(key: key);

  @override
  _DiscoverDevicesState createState() => _DiscoverDevicesState();
}

String serviceUuid = '6E400001-B5A3-F393-E0A9-E50E24DCCA9E';

class _DiscoverDevicesState extends State<DiscoverDevices> {
  final FlutterReactiveBle flutterReactiveBle = FlutterReactiveBle();

  @override
  void initState() {
    FlutterBlueElves.instance.androidApplyBluetoothPermission((isOk) {
      print(isOk
          ? "The user agrees to turn on the Bluetooth permission"
          : "The user does not agrees to turn on the Bluetooth permission");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scan Devices"),
      ),
      body: StreamBuilder<DiscoveredDevice>(
        stream: flutterReactiveBle
            .scanForDevices(withServices: [Uuid.parse(serviceUuid)]),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.builder(itemBuilder: (context, i) {
            return ListTile(
              title: Text(snapshot.data!.id.toString()),
            );
          });
        },
      ),
    );
  }
}
