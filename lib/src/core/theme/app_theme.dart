import 'package:flutter/material.dart';
import '../models/user_profile.dart';

class AppTheme {
  static ThemeData lightTheme(UserSettings settings) {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: settings.primaryColor,
        secondary: settings.accentColor,
        brightness: Brightness.light,
      ),
      fontFamily: settings.fontFamily,
      
      // App Bar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: settings.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontFamily: settings.fontFamily,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      
      // Card Theme
      cardTheme: CardTheme(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_getButtonRadius(settings.buttonStyle)),
        ),
        clipBehavior: Clip.antiAlias,
      ),
      
      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: settings.primaryColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: _getButtonShape(settings.buttonStyle),
          textStyle: TextStyle(
            fontFamily: settings.fontFamily,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      
      // Outlined Button Theme
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: settings.primaryColor,
          side: BorderSide(color: settings.primaryColor, width: 2),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: _getButtonShape(settings.buttonStyle),
          textStyle: TextStyle(
            fontFamily: settings.fontFamily,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      
      // Text Button Theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: settings.primaryColor,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: _getButtonShape(settings.buttonStyle),
          textStyle: TextStyle(
            fontFamily: settings.fontFamily,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      
      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_getButtonRadius(settings.buttonStyle)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_getButtonRadius(settings.buttonStyle)),
          borderSide: BorderSide(color: settings.primaryColor, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
      
      // Floating Action Button Theme
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: settings.accentColor,
        foregroundColor: Colors.white,
        shape: _getFabShape(settings.buttonStyle),
      ),
      
      // Bottom Navigation Bar Theme
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: settings.primaryColor,
        unselectedItemColor: Colors.grey[600],
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: TextStyle(
          fontFamily: settings.fontFamily,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: TextStyle(
          fontFamily: settings.fontFamily,
        ),
      ),
      
      // Slider Theme
      sliderTheme: SliderThemeData(
        activeTrackColor: settings.primaryColor,
        inactiveTrackColor: settings.primaryColor.withOpacity(0.3),
        thumbColor: settings.accentColor,
        overlayColor: settings.primaryColor.withOpacity(0.2),
      ),
      
      // Switch Theme
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return settings.accentColor;
          }
          return null;
        }),
        trackColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return settings.primaryColor.withOpacity(0.5);
          }
          return null;
        }),
      ),
      
      // Text Theme
      textTheme: _buildTextTheme(settings),
    );
  }

  static ThemeData darkTheme(UserSettings settings) {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: settings.primaryColor,
        secondary: settings.accentColor,
        brightness: Brightness.dark,
      ),
      fontFamily: settings.fontFamily,
      
      // App Bar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: settings.primaryColor.withOpacity(0.8),
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontFamily: settings.fontFamily,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      
      // Card Theme
      cardTheme: CardTheme(
        elevation: 8,
        color: Colors.grey[850],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_getButtonRadius(settings.buttonStyle)),
        ),
        clipBehavior: Clip.antiAlias,
      ),
      
      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: settings.primaryColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: _getButtonShape(settings.buttonStyle),
          textStyle: TextStyle(
            fontFamily: settings.fontFamily,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      
      // Text Theme
      textTheme: _buildTextTheme(settings).apply(
        bodyColor: Colors.white,
        displayColor: Colors.white,
      ),
    );
  }

  static TextTheme _buildTextTheme(UserSettings settings) {
    return TextTheme(
      // Display styles (largest)
      displayLarge: TextStyle(
        fontFamily: settings.fontFamily,
        fontSize: 57 * settings.textScale,
        fontWeight: FontWeight.w400,
        letterSpacing: -0.25,
      ),
      displayMedium: TextStyle(
        fontFamily: settings.fontFamily,
        fontSize: 45 * settings.textScale,
        fontWeight: FontWeight.w400,
      ),
      displaySmall: TextStyle(
        fontFamily: settings.fontFamily,
        fontSize: 36 * settings.textScale,
        fontWeight: FontWeight.w400,
      ),
      
      // Headline styles
      headlineLarge: TextStyle(
        fontFamily: settings.fontFamily,
        fontSize: 32 * settings.textScale,
        fontWeight: FontWeight.w400,
      ),
      headlineMedium: TextStyle(
        fontFamily: settings.fontFamily,
        fontSize: 28 * settings.textScale,
        fontWeight: FontWeight.w400,
      ),
      headlineSmall: TextStyle(
        fontFamily: settings.fontFamily,
        fontSize: 24 * settings.textScale,
        fontWeight: FontWeight.w400,
      ),
      
      // Title styles
      titleLarge: TextStyle(
        fontFamily: settings.fontFamily,
        fontSize: 22 * settings.textScale,
        fontWeight: FontWeight.w400,
      ),
      titleMedium: TextStyle(
        fontFamily: settings.fontFamily,
        fontSize: 16 * settings.textScale,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.15,
      ),
      titleSmall: TextStyle(
        fontFamily: settings.fontFamily,
        fontSize: 14 * settings.textScale,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
      ),
      
      // Body styles
      bodyLarge: TextStyle(
        fontFamily: settings.fontFamily,
        fontSize: 16 * settings.textScale,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
      ),
      bodyMedium: TextStyle(
        fontFamily: settings.fontFamily,
        fontSize: 14 * settings.textScale,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
      ),
      bodySmall: TextStyle(
        fontFamily: settings.fontFamily,
        fontSize: 12 * settings.textScale,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
      ),
      
      // Label styles
      labelLarge: TextStyle(
        fontFamily: settings.fontFamily,
        fontSize: 14 * settings.textScale,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
      ),
      labelMedium: TextStyle(
        fontFamily: settings.fontFamily,
        fontSize: 12 * settings.textScale,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
      ),
      labelSmall: TextStyle(
        fontFamily: settings.fontFamily,
        fontSize: 11 * settings.textScale,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
      ),
    );
  }

  static OutlinedBorder _getButtonShape(ButtonStyle buttonStyle) {
    switch (buttonStyle) {
      case ButtonStyle.rounded:
        return RoundedRectangleBorder(borderRadius: BorderRadius.circular(24));
      case ButtonStyle.square:
        return RoundedRectangleBorder(borderRadius: BorderRadius.circular(4));
      case ButtonStyle.circular:
        return RoundedRectangleBorder(borderRadius: BorderRadius.circular(50));
      case ButtonStyle.outlined:
        return RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: const BorderSide(width: 2),
        );
    }
  }

  static ShapeBorder _getFabShape(ButtonStyle buttonStyle) {
    switch (buttonStyle) {
      case ButtonStyle.rounded:
        return RoundedRectangleBorder(borderRadius: BorderRadius.circular(16));
      case ButtonStyle.square:
        return RoundedRectangleBorder(borderRadius: BorderRadius.circular(4));
      case ButtonStyle.circular:
        return const CircleBorder();
      case ButtonStyle.outlined:
        return RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(width: 2),
        );
    }
  }

  static double _getButtonRadius(ButtonStyle buttonStyle) {
    switch (buttonStyle) {
      case ButtonStyle.rounded:
        return 24;
      case ButtonStyle.square:
        return 4;
      case ButtonStyle.circular:
        return 50;
      case ButtonStyle.outlined:
        return 8;
    }
  }

  // Predefined theme presets
  static const List<Map<String, dynamic>> themePresets = [
    {
      'name': 'Magical Purple',
      'primaryColor': Colors.purple,
      'accentColor': Colors.pink,
      'description': 'Mystical and enchanting',
    },
    {
      'name': 'Forest Green',
      'primaryColor': Colors.green,
      'accentColor': Colors.lightGreen,
      'description': 'Nature and adventure',
    },
    {
      'name': 'Ocean Blue',
      'primaryColor': Colors.blue,
      'accentColor': Colors.cyan,
      'description': 'Calm and soothing',
    },
    {
      'name': 'Sunset Orange',
      'primaryColor': Colors.orange,
      'accentColor': Colors.deepOrange,
      'description': 'Warm and cozy',
    },
    {
      'name': 'Royal Red',
      'primaryColor': Colors.red,
      'accentColor': Colors.pink,
      'description': 'Bold and dramatic',
    },
    {
      'name': 'Galaxy Black',
      'primaryColor': Colors.black,
      'accentColor': Colors.white,
      'description': 'Elegant and mysterious',
    },
  ];

  // Age-appropriate color schemes
  static Map<AgeGroup, Map<String, Color>> ageAppropriateColors = {
    AgeGroup.toddler: {
      'primary': Colors.yellow[600]!,
      'accent': Colors.orange[400]!,
      'background': Colors.yellow[50]!,
    },
    AgeGroup.preschool: {
      'primary': Colors.pink[400]!,
      'accent': Colors.purple[300]!,
      'background': Colors.pink[50]!,
    },
    AgeGroup.elementary: {
      'primary': Colors.blue[500]!,
      'accent': Colors.green[400]!,
      'background': Colors.blue[50]!,
    },
    AgeGroup.teen: {
      'primary': Colors.purple[600]!,
      'accent': Colors.indigo[400]!,
      'background': Colors.purple[50]!,
    },
    AgeGroup.adult: {
      'primary': Colors.indigo[700]!,
      'accent': Colors.teal[500]!,
      'background': Colors.grey[100]!,
    },
    AgeGroup.all: {
      'primary': Colors.purple[500]!,
      'accent': Colors.pink[400]!,
      'background': Colors.purple[50]!,
    },
  };

  // Interface mode configurations
  static TextTheme getTextThemeForMode(InterfaceMode mode, UserSettings settings) {
    switch (mode) {
      case InterfaceMode.child:
        return _buildTextTheme(settings.copyWith(textScale: 1.2));
      case InterfaceMode.advanced:
        return _buildTextTheme(settings);
      case InterfaceMode.accessibility:
        return _buildTextTheme(settings.copyWith(textScale: 1.5));
    }
  }
}