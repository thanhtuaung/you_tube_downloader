import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionUtils {

  static Future<bool> getPermissions() async {
    bool gotPermissions = false;

    var androidInfo = await DeviceInfoPlugin().androidInfo;
    var release = androidInfo.version.release; // Version number, example: Android 12
    var sdkInt = androidInfo.version.sdkInt; // SDK, example: 31
    var manufacturer = androidInfo.manufacturer;
    var model = androidInfo.model;

    print('Android $release (SDK $sdkInt), $manufacturer $model');

    if (Platform.isAndroid) {
      var storage = await Permission.storage.status;

      if (storage != PermissionStatus.granted) {
        await Permission.storage.request();
      }

      if (sdkInt >= 30) {
        var storage_external = await Permission.manageExternalStorage.status;

        if (storage_external != PermissionStatus.granted) {
          await Permission.manageExternalStorage.request();
        }

        storage_external = await Permission.manageExternalStorage.status;

        if (storage_external == PermissionStatus.granted
            && storage == PermissionStatus.granted) {
          gotPermissions = true;
        }
      }
    else {
        // (SDK < 30)
        storage = await Permission.storage.status;

        if (storage == PermissionStatus.granted) {
          gotPermissions = true;
        }
      }
    }

    return gotPermissions;
  }

}