

import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';

class DeviceInfoService {
  Future<Map<String, String>> getDeviceInfo() async {
    final deviceInfo = DeviceInfoPlugin();

    try {
      if (Platform.isAndroid) {
        final android = await deviceInfo.androidInfo;
        return {
          "device_id": android.id,
          "device_name": "${android.manufacturer} ${android.model}",
          "os": "Android ${android.version.release}",
          "brand": android.manufacturer,
          "model": android.model,
          "is_current": "true",
        };
      } else if (Platform.isIOS) {
        final ios = await deviceInfo.iosInfo;
        return {
          "device_id": ios.identifierForVendor ?? "unknown_id",
          "device_name": ios.name,
          "os": "iOS ${ios.systemVersion}",
          "brand": "Apple",
          "model": ios.model,
          "is_current": "true",
        };
      }
    } catch (e) {
      debugPrint("Device info error: $e");
    }

    return {
      "device_id": "unknown",
      "device_name": "Unknown device",
      "os": "",
      "is_current": "true",
    };
  }
}
