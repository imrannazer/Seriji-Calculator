import 'package:flutter/foundation.dart';

class PlatformConfig {
  PlatformConfig._();

  static bool get isWeb => kIsWeb;

  static bool get isAndroid {
    if (kIsWeb) return false;
    return defaultTargetPlatform == TargetPlatform.android;
  }

  static bool get isIOS {
    if (kIsWeb) return false;
    return defaultTargetPlatform == TargetPlatform.iOS;
  }

  static bool get isMobile => isAndroid || isIOS;

  static bool get isDesktop {
    if (kIsWeb) return false;
    return defaultTargetPlatform == TargetPlatform.macOS ||
        defaultTargetPlatform == TargetPlatform.windows ||
        defaultTargetPlatform == TargetPlatform.linux;
  }
}
