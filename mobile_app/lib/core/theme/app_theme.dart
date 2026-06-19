import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppColors {
  static const primary = Color(0xFF000E34);
  static const primaryDark = Color(0xFF001754);
  static const accent = Color(0xFF3988FF);
  static const surface = Color(0xFFFCFCFC);
  static const onSurfaceVariant = Color(0xFF49454F);
  static const onSurface = Color(0xFF1D1B20);
  static const errorRed = Color(0xFFB11414);
  static const activeTab = Color(0xFF002651);
  static const textOnDark = Color(0xFFF6F6F6);
}

class AppTheme {
  static final light = ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      onPrimary: Colors.white,
      primaryContainer: AppColors.primaryDark,
      onPrimaryContainer: Colors.white,
      secondary: AppColors.primaryDark,
      onSecondary: Colors.white,
      secondaryContainer: Color(0xFFD0E4FF),
      onSecondaryContainer: AppColors.primary,
      tertiary: AppColors.accent,
      onTertiary: Colors.white,
      surface: AppColors.surface,
      onSurface: AppColors.onSurface,
      onSurfaceVariant: AppColors.onSurfaceVariant,
      outline: Color(0xFF79747E),
      outlineVariant: Color(0xFFCAC4D0),
      error: AppColors.errorRed,
      onError: Colors.white,
      errorContainer: Color(0xFFFFDAD6),
      onErrorContainer: Color(0xFF410002),
      inversePrimary: AppColors.accent,
      inverseSurface: AppColors.primary,
      onInverseSurface: AppColors.textOnDark,
    ),

    scaffoldBackgroundColor: AppColors.surface,

    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      elevation: 0,
      shadowColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      centerTitle: false,
      titleTextStyle: TextStyle(
        fontFamily: 'Roboto',
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
      ),
      iconTheme: IconThemeData(color: Colors.white),
      actionsIconTheme: IconThemeData(color: Colors.white),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: AppColors.primary,
        statusBarIconBrightness: Brightness.light,
      ),
    ),

    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 2,
      shadowColor: Color(0x26000000),
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        side: BorderSide(color: Color(0x1F000000), width: 1),
      ),
      margin: EdgeInsets.zero,
    ),

    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        minimumSize: const Size.fromHeight(44),
        shape: StadiumBorder(),
        textStyle: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14,
          letterSpacing: 0.5,
        ),
        elevation: 2,
        shadowColor: Color(0x40000E34),
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        minimumSize: const Size.fromHeight(44),
        shape: StadiumBorder(),
        elevation: 2,
        shadowColor: Color(0x40000E34),
        textStyle: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14,
          letterSpacing: 0.5,
        ),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary,
        side: const BorderSide(color: AppColors.primary, width: 1.5),
        minimumSize: const Size.fromHeight(44),
        shape: StadiumBorder(),
        textStyle: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14,
          letterSpacing: 0.5,
        ),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.accent,
        textStyle: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
      ),
    ),

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      elevation: 4,
      shape: StadiumBorder(),
      extendedTextStyle: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 14,
        letterSpacing: 0.5,
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        borderSide: BorderSide(color: AppColors.onSurfaceVariant),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        borderSide: BorderSide(color: Color(0x7949454F)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        borderSide: BorderSide(color: AppColors.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        borderSide: BorderSide(color: AppColors.errorRed),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        borderSide: BorderSide(color: AppColors.errorRed, width: 2),
      ),
      labelStyle: TextStyle(color: AppColors.onSurfaceVariant, fontSize: 14),
      floatingLabelStyle: TextStyle(color: AppColors.primary, fontSize: 12),
      hintStyle: TextStyle(
        color: Color(0x7F49454F),
        fontSize: 14,
      ),
      prefixIconColor: AppColors.onSurfaceVariant,
      suffixIconColor: AppColors.onSurfaceVariant,
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    ),

    dividerTheme: const DividerThemeData(
      color: Color(0x1F000000),
      thickness: 1,
      space: 1,
    ),

    listTileTheme: const ListTileThemeData(
      tileColor: Colors.white,
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    ),

    chipTheme: ChipThemeData(
      backgroundColor: Color(0xFFE8EAFF),
      labelStyle: TextStyle(color: AppColors.primaryDark, fontSize: 12),
      side: BorderSide(color: AppColors.primaryDark, width: 1),
      shape: StadiumBorder(),
    ),

    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColors.primaryDark,
      contentTextStyle: const TextStyle(color: Colors.white, fontSize: 14),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      behavior: SnackBarBehavior.floating,
      insetPadding: EdgeInsets.all(16),
    ),

    dialogTheme: DialogThemeData(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      titleTextStyle: TextStyle(
        color: AppColors.onSurface,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    ),

    iconTheme: const IconThemeData(
      color: AppColors.onSurfaceVariant,
      size: 24,
    ),

    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        color: AppColors.onSurface,
      ),
      headlineMedium: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        color: AppColors.onSurface,
      ),
      headlineSmall: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        color: AppColors.onSurface,
      ),
      titleLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        color: AppColors.onSurface,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.15,
        color: AppColors.onSurface,
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
        color: AppColors.onSurface,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
        color: AppColors.onSurface,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
        color: AppColors.onSurface,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
        color: AppColors.onSurfaceVariant,
      ),
      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
        color: AppColors.onSurface,
      ),
      labelMedium: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        color: AppColors.onSurfaceVariant,
      ),
      labelSmall: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        color: AppColors.onSurfaceVariant,
      ),
    ),
  );
}
