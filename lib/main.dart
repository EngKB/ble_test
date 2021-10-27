import 'package:flutter/material.dart';
import 'package:flutter_application_1/bluetooth_permission.dart';
import 'package:flutter_application_1/discover_devices.dart';
import 'package:flutter_application_1/discover_services.dart';
import 'package:flutter_application_1/elevs_scan.dart';
import 'package:flutter_application_1/scan_basic.dart';
import 'package:location/location.dart';

import 'elevs_example_scan.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<bool> locationPermission() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return false;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return false;
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Home"),
        ),
        body: FutureBuilder<bool>(
            future: locationPermission(),
            builder: (context, permissionsnapshot) {
              if (!permissionsnapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              return FutureBuilder<bool>(
                  future: checkPermission(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (permissionsnapshot.data!) {
                      return Builder(builder: (context) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const DiscoverDevices()));
                                },
                                child: const Text("Scan Devices"),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const DiscoverServices()));
                                },
                                child: const Text("Scan Services"),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const ElevsScan()));
                                },
                                child: const Text("Elevs Scan"),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const ScanBasic()));
                                },
                                child: const Text("Basic Scan"),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const ElevsExampleScan()));
                                },
                                child: const Text("Elevs Example Scan"),
                              )
                            ],
                          ),
                        );
                      });
                    } else {
                      return const Center(
                          child: Text("Location permission required"));
                    }
                  });
            }),
      ),
    );
  }
}
