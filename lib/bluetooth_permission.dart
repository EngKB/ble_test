import 'package:permission_handler/permission_handler.dart';

Future<bool> checkPermission() async {
  if (await Permission.bluetooth.isGranted) {
    return Future.value(true);
  } else {
    return await Permission.bluetooth.request().isGranted;
  }
}
