import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const Color primary = Color(0xFF0D9488);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color secondary = Color(0xFF0F172A);
  static const Color background = Color(0xFFF8FAFC);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color foreground = Color(0xFF020617);
  static const Color muted = Color(0xFF64748B);
  static const Color destructive = Color(0xFFDC2626);
  static const Color success = Color(0xFF16A34A);
  static const Color border = Color(0xFFE2E8F0);
  static const Color surfaceVariant = Color(0xFFF1F5F9);
  
  // Khusus Branch Context Mode (Owner)
  static const Color branchContext = Color(0xFFD97706);
  static const Color onBranchContext = Color(0xFFFFFFFF);

  // Status Colors (from DS-05)
  static const Color statusDraftBg = Color(0xFFF1F5F9);
  static const Color statusDraftText = Color(0xFF64748B);
  
  static const Color statusKonfirmasiBg = Color(0xFFEFF6FF);
  static const Color statusKonfirmasiText = Color(0xFF1D4ED8);
  
  static const Color statusProdJalanBg = Color(0xFFFEF9C3);
  static const Color statusProdJalanText = Color(0xFFA16207);
  
  static const Color statusProdSelesaiBg = Color(0xFFDCFCE7);
  static const Color statusProdSelesaiText = Color(0xFF16A34A);
  
  static const Color statusBatalBg = Color(0xFFFEE2E2);
  static const Color statusBatalText = Color(0xFFDC2626);
}

class AppSpacing {
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;

  // Semantic spacing
  static const double pagePadding = 16.0; // --space-md
  static const double maxContentWidth = 600.0;
}

class AppRadius {
  static const double sm = 4.0;
  static const double md = 8.0; // Standar tombol & card
  static const double lg = 16.0;
  static const double full = 9999.0;
}

class AppTypography {
  static TextStyle get h1 => GoogleFonts.poppins(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: AppColors.foreground,
      );

  static TextStyle get h2 => GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.w600, // SemiBold
        color: AppColors.foreground,
      );

  static TextStyle get body1 => GoogleFonts.openSans(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: AppColors.foreground,
      );

  static TextStyle get body2 => GoogleFonts.openSans(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: AppColors.foreground,
      );

  static TextStyle get caption => GoogleFonts.openSans(
        fontSize: 12,
        fontWeight: FontWeight.w500, // Medium
        color: AppColors.muted,
      );
}

class AppShadows {
  // Soft drop shadow (2-5% opacity) sesuai DS-02
  static List<BoxShadow> get softCard => [
        BoxShadow(
          color: AppColors.secondary.withValues(alpha: 0.04),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ];
}

class AppTheme {
  // Hanya menyediakan theme standar agar MaterialApp jalan, 
  // tapi kita mengandalkan komponen kustom (Hybrid).
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        onPrimary: AppColors.onPrimary,
        secondary: AppColors.secondary,
        surface: AppColors.surface,
        error: AppColors.destructive,
      ),
      textTheme: TextTheme(
        displayLarge: AppTypography.h1,
        titleLarge: AppTypography.h2,
        bodyLarge: AppTypography.body1,
        bodyMedium: AppTypography.body2,
        labelSmall: AppTypography.caption,
      ),
    );
  }
}
