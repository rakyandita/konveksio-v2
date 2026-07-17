import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Colors
  static const Color primary = Color(0xFF0D9488); // Emerald
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color secondary = Color(0xFF0F172A); // Navy
  static const Color background = Color(0xFFF8FAFC); // Off-white
  static const Color surface = Color(0xFFFFFFFF);
  static const Color foreground = Color(0xFF020617);
  static const Color muted = Color(0xFF64748B);
  static const Color destructive = Color(0xFFDC2626);
  static const Color success = Color(0xFF16A34A);
  static const Color border = Color(0xFFE2E8F0);
  
  // Branch Context (Mode Operasional)
  static const Color branchContext = Color(0xFFD97706); // Amber
  static const Color onBranchContext = Color(0xFFFFFFFF);

  // Spacing (8dp Rhythm)
  static const double spaceXs = 4.0;
  static const double spaceSm = 8.0;
  static const double spaceMd = 16.0;
  static const double spaceLg = 24.0;
  static const double spaceXl = 32.0;

  // Theme Data
  static ThemeData get lightTheme {
    final textTheme = GoogleFonts.plusJakartaSansTextTheme().copyWith(
      displayLarge: GoogleFonts.plusJakartaSans(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: foreground,
      ), // H1
      displayMedium: GoogleFonts.plusJakartaSans(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: foreground,
      ), // H2
      bodyLarge: GoogleFonts.plusJakartaSans(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: foreground,
      ), // Body 1
      bodyMedium: GoogleFonts.plusJakartaSans(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: foreground,
      ), // Body 2
      labelSmall: GoogleFonts.plusJakartaSans(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: muted,
      ), // Caption
    );

    return ThemeData(
      colorScheme: ColorScheme.light(
        primary: primary,
        onPrimary: onPrimary,
        secondary: secondary,
        surface: surface,
        onSurface: foreground,
        error: destructive,
        onError: onPrimary,
      ),
      scaffoldBackgroundColor: background,
      textTheme: textTheme,
      
      // Buttons
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: onPrimary,
          textStyle: GoogleFonts.plusJakartaSans(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          minimumSize: const Size.fromHeight(48), // Bottom tap area
          elevation: 0, // No shadow
        ),
      ),
      
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: foreground,
          backgroundColor: surface,
          side: const BorderSide(color: border, width: 1.5),
          textStyle: GoogleFonts.plusJakartaSans(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          minimumSize: const Size.fromHeight(48),
        ),
      ),

      // Input Decoration
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFFF1F5F9),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: const UnderlineInputBorder(
          borderSide: BorderSide.none,
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide.none,
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: primary, width: 2),
        ),
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: destructive, width: 2),
        ),
        hintStyle: textTheme.bodyLarge?.copyWith(color: muted),
      ),

      // Card
      cardTheme: CardThemeData(
        color: surface,
        elevation: 0, // No shadow
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: const BorderSide(color: border, width: 1),
        ),
      ),
      
      // Bottom Navigation Bar
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: surface,
        selectedItemColor: primary,
        unselectedItemColor: muted,
        selectedLabelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        unselectedLabelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        elevation: 8, // slight elevation for bottom nav is okay to separate from content
        type: BottomNavigationBarType.fixed,
      ),

      // App Bar
      appBarTheme: AppBarTheme(
        backgroundColor: primary,
        foregroundColor: onPrimary,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: GoogleFonts.plusJakartaSans(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: onPrimary,
        ),
      ),
    );
  }
}
