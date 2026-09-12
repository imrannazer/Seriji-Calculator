import 'package:flutter/material.dart';

class SirajiShapes {
  SirajiShapes._();

  static const double radiusXs = 4.0;
  static const double radiusSm = 8.0;
  static const double radiusMd = 12.0;
  static const double radiusLg = 16.0;
  static const double radiusXl = 24.0;

  static final RoundedRectangleBorder cardShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(radiusMd),
  );

  static final RoundedRectangleBorder dialogShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(radiusLg),
  );

  static final RoundedRectangleBorder buttonShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(radiusMd),
  );

  static final RoundedRectangleBorder footerShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(radiusXl),
  );

  static final RoundedRectangleBorder inputShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(radiusSm),
  );
}
