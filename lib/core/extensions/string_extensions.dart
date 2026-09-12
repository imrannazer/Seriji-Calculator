import 'package:flutter/material.dart';

extension StringExtensions on String {
  bool get isRTL {
    if (isEmpty) return false;
    final firstChar = trim().characters.firstOrNull;
    if (firstChar == null) return false;
    final codeUnit = firstChar.codeUnitAt(0);
    return (codeUnit >= 0x0600 && codeUnit <= 0x06FF) ||
        (codeUnit >= 0x0750 && codeUnit <= 0x077F) ||
        (codeUnit >= 0x08A0 && codeUnit <= 0x08FF);
  }

  bool get containsArabicScript {
    return runes.any((r) =>
        (r >= 0x0600 && r <= 0x06FF) ||
        (r >= 0x0750 && r <= 0x077F) ||
        (r >= 0x08A0 && r <= 0x08FF));
  }

  String get trimmed => trim();
  bool get isNullOrEmpty => isEmpty;
  bool get isNotNullOrEmpty => isNotEmpty;
}

extension NullableStringExtensions on String? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;
  bool get isNotNullOrEmpty => !isNullOrEmpty;
  String get orEmpty => this ?? '';
}
