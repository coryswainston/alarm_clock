import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_notifier.g.dart';

@Riverpod(keepAlive: true)
class ThemeNotifier extends _$ThemeNotifier {
  @override
  ThemeData build() {
    return ThemeData.dark().copyWith(
      textTheme: GoogleFonts.figtreeTextTheme(ThemeData.dark().textTheme),
    );
  }

  void toggleDarkMode() {
    if (state.brightness == Brightness.light) {
      state = ThemeData.dark().copyWith(
        textTheme: GoogleFonts.figtreeTextTheme(ThemeData.dark().textTheme),
      );
    } else {
      state = ThemeData.light().copyWith(
        textTheme: GoogleFonts.figtreeTextTheme(ThemeData.light().textTheme),
      );
    }
  }
}
