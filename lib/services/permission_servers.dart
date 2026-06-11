import 'dart:io';

import 'package:permission_handler/permission_handler.dart';

class PermissionServers {
  Future<void> requestAllPermissions() async {
    if (Platform.isAndroid || Platform.isIOS) {
      await [Permission.storage, Permission.camera].request();
    }
  }

  Future<bool> checkInternet() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (e) {
      return false;
    }
  }
}
