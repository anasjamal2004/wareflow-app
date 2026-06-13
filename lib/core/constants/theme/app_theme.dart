import 'package:flutter/material.dart';
import 'package:get/get.dart';

// 1. Ek Model Class jo tumhare UI ke required colors ko define karegi
class AppPalette {
  final Color background;
  final Color card;
  final Color textPrimary;
  final Color textSecondary;
  final Color border;
  final Color loadingColor;

  // Naye Colors
  final Color icon;
  final Color button;
  final Color appBar;
  final Color navSelected;
  final Color navUnselected;
  final Color avatarBg;
  final Color textFieldBg;

  const AppPalette({
    required this.background,
    required this.card,
    required this.textPrimary,
    required this.textSecondary,
    required this.border,
    required this.loadingColor,
    required this.icon,
    required this.button,
    required this.appBar,
    required this.navSelected,
    required this.navUnselected,
    required this.avatarBg,
    required this.textFieldBg,
  });
}

class AppTheme {
  // ==========================================
  // 2. LIGHT MODE WALE COLORS (Ek group mein)
  // ==========================================
  static const AppPalette light = AppPalette(
    background: Color(0xFFF1F2F6),
    card: Colors.white,
    textPrimary: Color(0xFF1A1A1A),
    textSecondary: Color(0xFF85848A),
    border: Color(0xFFD1D1D1),
    loadingColor: Colors
        .black, // AppTheme.blackColor ki jagah direct Colors.black use kiya const ke liye
    icon: Color(0xFF1A1A1A), // Text ke sath match karega
    button: Color(0xFF5865F2), // Discord Blue
    appBar: Colors.white,
    navSelected: Color(0xFF1A1A1A),
    navUnselected: Color(0xFF85848A),
    avatarBg: Color(0xFFE3E5E8), // Light grey background
    textFieldBg: Colors.white,
  );

  // ==========================================
  // 3. DARK MODE WALE COLORS (Discord Style)
  // ==========================================
  static const AppPalette dark = AppPalette(
    background: Color(0xFF1C1D22),
    card: Color(0xFF2B2D31),
    textPrimary: Color(0xFFF2F3F5),
    textSecondary: Color(0xFF949BA4),
    border: Color(0xFF3F4147),
    loadingColor: Colors.white,
    icon: Color(0xFFF2F3F5), // Text ke sath match karega
    button: Color(0xFF5865F2), // Button blue hi rahega dono modes mein
    appBar: Color(0xFF2B2D31), // Background se thoda alag
    navSelected: Colors.white,
    navUnselected: Color(0xFF949BA4),
    avatarBg: Color(0xFF3F4147), // Dark grey
    textFieldBg: Color(0xFF1E1F22), // Discord ka standard input field color
  );

  // ==========================================
  // 4. COMMON ACCENT COLORS (Jo kabhi change nahi hote)
  // ==========================================
  static const Color greenColor = Color(0xFF6DC595);
  static const Color redColor = Color(0xFFF23F43);
  static const Color blueColor = Color(0xFF5865F2);
  static const Color transparentColor = Colors.transparent;
  static const Color blackColor = Colors.black;
  static const Color whiteColor = Colors.white;
  static final Color greyColor = Colors.grey[300]!;

  // ==========================================
  // 5. THE MASTER GETTER (Sirf 1 dafa if-else)
  // ==========================================
  static AppPalette get current {
    if (Get.isDarkMode == true) {
      return dark;
    } else {
      return light;
    }
  }
}
