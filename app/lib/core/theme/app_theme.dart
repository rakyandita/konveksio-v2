import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Brand Colors based on SoT (docs/design_system.md)
  static const Color primary = Color(0xFF0D9488); // Emerald/Teal
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color secondary = Color(0xFF0F172A); // Navy
  static const Color background = Color(0xFFF8FAFC); // Off-white/Light Gray
  static const Color surface = Color(0xFFFFFFFF); // White
  static const Color foreground = Color(0xFF020617); // Text Utama
  static const Color muted = Color(0xFF64748B); // Text Sekunder
  static const Color border = Color(0xFFE2E8F0); // Divider/Outline
  static const Color destructive = Color(0xFFDC2626); // Error/Tolak
  static const double borderRadius = 8.0;

  // Spacing & Radius
  static const double spacingSm = 8.0;
  static const double spacingBase = 16.0;
  static const double spacingLg = 24.0;
  static const double spacingXl = 32.0;
  static const double radiusSm = 4.0;
  static const double radiusMd = 8.0;
  static const double radiusLg = 12.0;

  // Branch Context Specific
  static const Color branchContext = Color(0xFFD97706); // Amber
  static const Color onBranchContext = Color(0xFFFFFFFF);

  // Status Colors
  static const Color success = Color(0xFF16A34A);
  static const Color warning = Color(0xFFEAB308); // Amber/Yellow

  static ThemeData get lightTheme {
    // Kombinasi Font: Poppins untuk Heading, Open Sans untuk Body
    final poppinsTheme = GoogleFonts.poppinsTextTheme();
    final openSansTheme = GoogleFonts.openSansTextTheme();

    return ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme.light(
        primary: primary,
        onPrimary: onPrimary,
        secondary: secondary,
        onSecondary: onPrimary,
        error: destructive,
        onError: onPrimary,
        background: background,
        onBackground: foreground,
        surface: surface,
        onSurface: foreground,
        outline: border,
        surfaceVariant: muted,
      ),
      scaffoldBackgroundColor: background,
      textTheme: openSansTheme.copyWith(
        displayLarge: poppinsTheme.displayLarge?.copyWith(color: foreground, fontWeight: FontWeight.bold),
        displayMedium: poppinsTheme.displayMedium?.copyWith(color: foreground, fontWeight: FontWeight.bold),
        displaySmall: poppinsTheme.displaySmall?.copyWith(color: foreground, fontWeight: FontWeight.bold),
        headlineLarge: poppinsTheme.headlineLarge?.copyWith(color: foreground, fontWeight: FontWeight.bold),
        headlineMedium: poppinsTheme.headlineMedium?.copyWith(color: foreground, fontWeight: FontWeight.w600),
        headlineSmall: poppinsTheme.headlineSmall?.copyWith(color: foreground, fontWeight: FontWeight.w600),
        titleLarge: poppinsTheme.titleLarge?.copyWith(color: foreground, fontWeight: FontWeight.w600),
        titleMedium: poppinsTheme.titleMedium?.copyWith(color: foreground, fontWeight: FontWeight.w600),
        titleSmall: poppinsTheme.titleSmall?.copyWith(color: foreground, fontWeight: FontWeight.w600),
        bodyLarge: openSansTheme.bodyLarge?.copyWith(color: foreground, fontSize: 16),
        bodyMedium: openSansTheme.bodyMedium?.copyWith(color: foreground, fontSize: 14),
        bodySmall: openSansTheme.bodySmall?.copyWith(color: muted, fontSize: 12),
        labelLarge: openSansTheme.labelLarge?.copyWith(color: foreground, fontWeight: FontWeight.w600),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: onPrimary,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14), // Sesuai DS-01
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8), // Melengkung lembut, bukan pil bulat
          ),
          textStyle: const TextStyle(
            fontFamily: 'Open Sans',
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primary,
          textStyle: const TextStyle(
            fontFamily: 'Open Sans',
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surface,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: destructive),
        ),
        labelStyle: const TextStyle(color: muted, fontSize: 14),
        hintStyle: const TextStyle(color: border, fontSize: 16), // Placeholder color
      ),
    );
  }
}
