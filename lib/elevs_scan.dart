import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blue_elves/flutter_blue_elves.dart';
import 'package:location/location.dart';

class ElevsScan extends StatefulWidget {
  const ElevsScan({Key? key}) : super(key: key);

  @override
  State<ElevsScan> createState() => _ElevsScanState();
}

class _ElevsScanState extends State<ElevsScan> {
  late StreamSubscription<ScanResult> scanResult;
  List<ScanResult> loResult = [];
  FlutterBlueElves flutterBlueElves = FlutterBlueElves.instance;

  @override
  void dispose() {
    scanResult.cancel();
    super.dispose();
  }

  @override
  void initState() {
    scanResult = FlutterBlueElves.instance.startScan(20000).listen((event) {
      print(event);
      setState(() {
        loResult.add(event);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("scan"),
      ),
      body: ListView.builder(
          itemCount: loResult.length,
          itemBuilder: (context, i) {
            return ListTile(
              title: Text(loResult[i].id.toString()),
              subtitle: Row(
                children: loResult[i].uuids.map((e) => Text(e)).toList(),
              ),
            );
          }),
    );
  }
}
