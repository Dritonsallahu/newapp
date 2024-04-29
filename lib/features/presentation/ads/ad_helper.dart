import 'dart:io';

class AdHepler {
  static get bannerAdUnitId {
    if (Platform.isAndroid) {
      print("Sdfdd");
      return "ca-app-pub-1646221758634680/2913246056";
    } else if (Platform.isIOS) {
      // return "ca-app-pub-1928357711411275/4600936089";
      return "ca-app-pub-1928357711411275/5507109054";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  static get interstitialAdUniId {
    if (Platform.isAndroid) {
      return "ca-app-pub-1928357711411275~9689611232";
    } else if (Platform.isIOS) {
      return "ca-app-pub-1928357711411275/9498039546";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }
}
