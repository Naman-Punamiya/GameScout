import 'package:flutter/material.dart';

class AppRadius {
  AppRadius._();

  static const double xs = 4;
  static const double sm = 6;
  static const double md = 8;
  static const double lg = 10;
  static const double card = 16;
  static const double largeCard = 20;
  static const double xl = 24;
  static const double pill = 30;
  static const double roundPill = 40;
  static const double full = 999;

  static const BorderRadius roundedXs = BorderRadius.all(Radius.circular(xs));
  static const BorderRadius roundedSm = BorderRadius.all(Radius.circular(sm));
  static const BorderRadius roundedMd = BorderRadius.all(Radius.circular(md));
  static const BorderRadius roundedLg = BorderRadius.all(Radius.circular(lg));
  static const BorderRadius roundedCard = BorderRadius.all(
    Radius.circular(card),
  );
  static const BorderRadius roundedLargeCard = BorderRadius.all(
    Radius.circular(largeCard),
  );
  static const BorderRadius roundedXl = BorderRadius.all(Radius.circular(xl));
  static const BorderRadius roundedPill = BorderRadius.all(
    Radius.circular(pill),
  );
  static const BorderRadius roundedRoundPill = BorderRadius.all(
    Radius.circular(roundPill),
  );
}
