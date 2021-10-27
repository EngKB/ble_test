import 'package:flutter/material.dart';
import 'package:flutter_application_1/bluetooth_permission.dart';
import 'package:flutter_application_1/discover_devices.dart';
import 'package:flutter_application_1/discover_services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Home"),
        ),
        body: FutureBuilder<bool>(
            future: checkPermission(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
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
                        )
                      ],
                    ),
                  );
                });
              }
            }),
      ),
    );
  }
}
