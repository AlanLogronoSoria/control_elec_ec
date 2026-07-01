/// Definición de la paleta de colores y tema Material Design 3 para la app.
///
/// Esquema: Azul electoral profundo + dorado/ámbar como acento,
/// con modo oscuro diferenciado por rol.
library;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Colores centrales de la aplicación.
class AppColors {
  AppColors._();

  // ── Primarios (Azul Electoral) ────────────────────────────────────────
  static const Color primary = Color(0xFF0D47A1);
  static const Color primaryLight = Color(0xFF1565C0);
  static const Color primaryDark = Color(0xFF0A2F6B);

  // ── Acento (Dorado Ecuador) ───────────────────────────────────────────
  static const Color accent = Color(0xFFFFBF00);
  static const Color accentLight = Color(0xFFFFD54F);
  static const Color accentDark = Color(0xFFF9A825);

  // ── Rojo (Nacional Ecuador) ───────────────────────────────────────────
  static const Color danger = Color(0xFFC62828);
  static const Color dangerLight = Color(0xFFEF5350);

  // ── Éxito / Completado ────────────────────────────────────────────────
  static const Color success = Color(0xFF2E7D32);
  static const Color successLight = Color(0xFF43A047);

  // ── Advertencia ───────────────────────────────────────────────────────
  static const Color warning = Color(0xFFE65100);
  static const Color warningLight = Color(0xFFEF6C00);
  static const Color warningDark = Color(0xFFBF360C);

  // ── Información ───────────────────────────────────────────────────────
  static const Color info = Color(0xFF0277BD);
  static const Color infoLight = Color(0xFF0288D1);

  // ── Neutrales (Light) ─────────────────────────────────────────────────
  static const Color surface = Color(0xFFF8F9FE);
  static const Color surfaceVariant = Color(0xFFEEF2FF);
  static const Color cardColor = Color(0xFFFFFFFF);
  static const Color divider = Color(0xFFE8EAF6);
  static const Color textPrimary = Color(0xFF1A1C2E);
  static const Color textSecondary = Color(0xFF5C6270);
  static const Color textHint = Color(0xFF9EA4B0);

  // ── Dark Mode ─────────────────────────────────────────────────────────
  static const Color darkBackground = Color(0xFF0D0F1A);
  static const Color darkSurface = Color(0xFF141728);
  static const Color darkCard = Color(0xFF1C2035);
  static const Color darkDivider = Color(0xFF2A2E45);
  static const Color darkTextPrimary = Color(0xFFE8EAF6);
  static const Color darkTextSecondary = Color(0xFF9EA4C8);

  // ── Por rol ───────────────────────────────────────────────────────────
  static const Color provincialColor = Color(0xFF1565C0);  // Azul provincial
  static const Color recintoColor = Color(0xFF7B1FA2);     // Púrpura recinto
  static const Color veedorColor = Color(0xFF00695C);      // Verde veedor

  // ── Charts ───────────────────────────────────────────────────────────
  static const List<Color> chartColors = [
    Color(0xFF1565C0),
    Color(0xFFFFBF00),
    Color(0xFFC62828),
    Color(0xFF2E7D32),
    Color(0xFF7B1FA2),
  ];
}

/// Tema principal de la aplicación (Material Design 3).
class AppTheme {
  AppTheme._();

  // ── Esquema de colores base ───────────────────────────────────────────
  static const _colorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.primary,
    onPrimary: Colors.white,
    primaryContainer: Color(0xFFD6E4FF),
    onPrimaryContainer: AppColors.primaryDark,
    secondary: AppColors.accent,
    onSecondary: Colors.black,
    secondaryContainer: Color(0xFFFFF3CD),
    onSecondaryContainer: Color(0xFF3D2F00),
    tertiary: AppColors.success,
    onTertiary: Colors.white,
    tertiaryContainer: Color(0xFFD4EDDA),
    onTertiaryContainer: Color(0xFF0A3C14),
    error: AppColors.danger,
    onError: Colors.white,
    errorContainer: Color(0xFFFFDAD6),
    onErrorContainer: Color(0xFF410002),
    surface: AppColors.surface,
    onSurface: AppColors.textPrimary,
    surfaceContainerHighest: AppColors.surfaceVariant,
    onSurfaceVariant: AppColors.textSecondary,
    outline: AppColors.divider,
    outlineVariant: Color(0xFFCAC4D0),
    shadow: Color(0xFF000000),
    scrim: Color(0xFF000000),
    inverseSurface: AppColors.textPrimary,
    onInverseSurface: AppColors.surface,
    inversePrimary: Color(0xFFADC6FF),
  );

  // ── TextTheme con Outfit ───────────────────────────────────────────────
  static TextTheme get _textTheme {
    final base = GoogleFonts.outfitTextTheme();
    return base.copyWith(
      displayLarge: base.displayLarge?.copyWith(
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        letterSpacing: -1.0,
      ),
      displayMedium: base.displayMedium?.copyWith(
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      headlineLarge: base.headlineLarge?.copyWith(
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
      ),
      headlineMedium: base.headlineMedium?.copyWith(
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      titleLarge: base.titleLarge?.copyWith(
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      titleMedium: base.titleMedium?.copyWith(
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary,
      ),
      bodyLarge: base.bodyLarge?.copyWith(
        color: AppColors.textPrimary,
      ),
      bodyMedium: base.bodyMedium?.copyWith(
        color: AppColors.textSecondary,
      ),
      labelLarge: base.labelLarge?.copyWith(
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
      ),
    );
  }

  /// Tema claro (principal).
  static ThemeData get lightTheme => ThemeData(
        useMaterial3: true,
        colorScheme: _colorScheme,
        textTheme: _textTheme,

        // ── AppBar ──────────────────────────────────────────────────────
        appBarTheme: AppBarTheme(
          elevation: 0,
          scrolledUnderElevation: 2,
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          centerTitle: false,
          titleTextStyle: GoogleFonts.outfit(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
            letterSpacing: 0.3,
          ),
          shadowColor: AppColors.primary.withOpacity(0.3),
        ),

        // ── Cards ────────────────────────────────────────────────────────
        cardTheme: CardThemeData(
          color: AppColors.cardColor,
          elevation: 2,
          shadowColor: AppColors.primary.withOpacity(0.12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 0),
        ),

        // ── ElevatedButton ────────────────────────────────────────────────
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            elevation: 2,
            shadowColor: AppColors.primary.withOpacity(0.4),
            minimumSize: const Size(double.infinity, 52),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            textStyle: GoogleFonts.outfit(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
        ),

        // ── OutlinedButton ────────────────────────────────────────────────
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.primary,
            side: const BorderSide(color: AppColors.primary, width: 1.5),
            minimumSize: const Size(double.infinity, 52),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            textStyle: GoogleFonts.outfit(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        // ── TextButton ────────────────────────────────────────────────────
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: AppColors.primary,
            textStyle: GoogleFonts.outfit(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),

        // ── InputDecoration ───────────────────────────────────────────────
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.surfaceVariant,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: AppColors.divider),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: AppColors.divider),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: AppColors.primary, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: AppColors.danger),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: AppColors.danger, width: 2),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          labelStyle: const TextStyle(color: AppColors.textSecondary),
          hintStyle: const TextStyle(color: AppColors.textHint),
          prefixIconColor: AppColors.primary,
        ),

        // ── BottomNavigationBar ───────────────────────────────────────────
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: AppColors.cardColor,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.textHint,
          type: BottomNavigationBarType.fixed,
          elevation: 8,
        ),

        // ── FloatingActionButton ──────────────────────────────────────────
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: AppColors.accent,
          foregroundColor: Colors.black87,
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),

        // ── SnackBar ──────────────────────────────────────────────────────
        snackBarTheme: SnackBarThemeData(
          backgroundColor: AppColors.textPrimary,
          contentTextStyle: GoogleFonts.outfit(
            color: Colors.white,
            fontSize: 14,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          behavior: SnackBarBehavior.floating,
          insetPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),

        // ── Chip ──────────────────────────────────────────────────────────
        chipTheme: ChipThemeData(
          backgroundColor: AppColors.surfaceVariant,
          selectedColor: AppColors.primaryLight,
          labelStyle: GoogleFonts.outfit(fontSize: 13),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),

        // ── Divider ───────────────────────────────────────────────────────
        dividerTheme: const DividerThemeData(
          color: AppColors.divider,
          thickness: 1,
          space: 1,
        ),

        scaffoldBackgroundColor: AppColors.surface,
      );

  /// Tema oscuro (opcional, para usuarios que lo prefieran).
  static ThemeData get darkTheme => lightTheme.copyWith(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.darkBackground,
        colorScheme: _colorScheme.copyWith(
          brightness: Brightness.dark,
          surface: AppColors.darkSurface,
          onSurface: AppColors.darkTextPrimary,
        ),
        cardTheme: CardThemeData(
          color: AppColors.darkCard,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.darkSurface,
          foregroundColor: AppColors.darkTextPrimary,
          elevation: 0,
          titleTextStyle: GoogleFonts.outfit(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: AppColors.darkTextPrimary,
          ),
        ),
      );
}
