import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NeoTheme {
  static const Color background = Color(0xFF0F0F13);
  static const Color surface = Color(0xFF1A1A24);
  static const Color primaryCyan = Color(0xFF00E5FF);
  static const Color primaryMagenta = Color(0xFFFF00FF);
  static const Color textWhite = Colors.white;
  static const Color textGrey = Color(0xFF8B8B9E);

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: background,
      primaryColor: primaryCyan,
      colorScheme: const ColorScheme.dark(
        primary: primaryCyan,
        secondary: primaryMagenta,
        surface: surface,
      ),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.orbitron(
            fontSize: 32, fontWeight: FontWeight.bold, color: textWhite),
        displayMedium: GoogleFonts.orbitron(
            fontSize: 24, fontWeight: FontWeight.bold, color: textWhite),
        titleLarge: GoogleFonts.orbitron(
            fontSize: 20, fontWeight: FontWeight.bold, color: textWhite),
        bodyLarge: GoogleFonts.inter(fontSize: 16, color: textWhite),
        bodyMedium: GoogleFonts.inter(fontSize: 14, color: textGrey),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: background,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.orbitron(
            fontSize: 22, fontWeight: FontWeight.bold, color: primaryCyan),
        iconTheme: const IconThemeData(color: primaryCyan),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryCyan,
          foregroundColor: background,
          textStyle: GoogleFonts.orbitron(fontWeight: FontWeight.bold),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        ).copyWith(
          overlayColor: WidgetStateProperty.all(primaryMagenta.withValues(alpha: 0.3)),
        ),
      ),
    );
  }
}
