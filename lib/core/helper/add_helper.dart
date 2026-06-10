import 'dart:io';

class AddHelper {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-1272555603875021/8343659919";
    } else {
      throw UnsupportedError("UnsupportedError");
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-1272555603875021/7564055000";
    } else {
      throw UnsupportedError("UnsupportedError");
    }
  }

  static String get rewardedAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-1272555603875021/8663224115";
    } else {
      throw UnsupportedError("UnsupportedError");
    }
  }
}
