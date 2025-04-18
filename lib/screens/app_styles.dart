import 'package:flutter/material.dart';

class AppStyles {
  static const primaryColor = Color(0xFF000000);
  static const secondaryColor = Color(0xFFFFFFFF);
  static const accentColor = Color(0xFFFFD700); // Gold accent
  static const backgroundColor = Color(0xFFF5F5F5);

  static const headlineStyle = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w800,
    color: primaryColor,
    letterSpacing: 0.5,
  );

  static const subtitleStyle = TextStyle(
    fontSize: 16,
    color: Colors.grey,
    height: 1.5,
  );

  static InputDecoration textFieldDecoration(String hint, {Widget? suffixIcon}) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      suffixIcon: suffixIcon,
    );
  }

  static ButtonStyle primaryButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: primaryColor,
    foregroundColor: secondaryColor,
    padding: const EdgeInsets.symmetric(vertical: 18),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    elevation: 0,
  );

  static ButtonStyle secondaryButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: secondaryColor,
    foregroundColor: primaryColor,
    padding: const EdgeInsets.symmetric(vertical: 18),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
      side: BorderSide(color: primaryColor, width: 1.5),
    ),
    elevation: 0,
  );
}