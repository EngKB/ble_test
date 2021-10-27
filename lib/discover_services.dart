import 'package:flutter/material.dart';
import 'package:flutter_blue_elves/flutter_blue_elves.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'dart:math' as math;

class DiscoverServices extends StatefulWidget {
  const DiscoverServices({Key? key}) : super(key: key);

  @override
  _DiscoverServicesState createState() => _DiscoverServicesState();
}

String serviceUuid = '6E400001-B5A3-F393-E0A9-E50E24DCCA9E';

class _DiscoverServicesState extends State<DiscoverServices> {
  final FlutterReactiveBle flutterReactiveBle = FlutterReactiveBle();
  String _normalizeMacAddress(String mac) {
    String newStr = '';
    int step = 2;
    for (int i = 0; i < mac.length; i += step) {
      newStr += mac.substring(i, math.min(i + step, mac.length));
      if (i + step < mac.length) newStr += ':';
    }
    return newStr;
  }

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
        title: const Text("Scan Services"),
      ),
      body: FutureBuilder<List<DiscoveredService>>(
        future: flutterReactiveBle
            .discoverServices(_normalizeMacAddress('C428AD6A738A')),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.builder(itemBuilder: (context, i) {
            return ListTile(
              title: Text(snapshot.data![i].serviceId.toString()),
            );
          });
        },
      ),
    );
  }
}
