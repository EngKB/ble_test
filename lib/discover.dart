import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'dart:math' as math;

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({Key? key}) : super(key: key);

  @override
  _DiscoverPageState createState() => _DiscoverPageState();
}

String serviceUuid = '6E400001-B5A3-F393-E0A9-E50E24DCCA9E';

class _DiscoverPageState extends State<DiscoverPage> {
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
    flutterReactiveBle.discoverServices(_normalizeMacAddress('C428AD6A738A'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
