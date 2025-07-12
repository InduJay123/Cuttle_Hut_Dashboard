import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppColors{
  static const background = Color(0xFF0E1323);
  static const card = Color(0xFF1A1F37);
  static const primary = Color(0xFF1E74FF);
  static const secondary = Color(0xFF030D45);
  static const accentGreen= Color(0xFF00FF9D);
  static const accentBlue= Color(0xFF00D1FF);
  static const accentOrange = Color(0xFFFFA726);
  static const textPrimary = Colors.white;
  static const textSecondary = Colors.white70;
  static const boarderGray = Colors.white24;
  static const buttonDark = Color(0xFF2A2E45);
  static const Color btnViewSummaryBg = Color(0xFF202020);
  static const Color btnLightBlue = Color(0xFF289BF6);
  static const Color btnDarkBlue = Color(0xFF070974);
  static const Color btnDarkBlueText = Color(0xFFFBFBFB);
  static const Color btnBlack = Color(0xFF202020);
  static const cardBackground = Color(0xFF1B1E2C);
  static const blue = Color(0xFF1C77FF);
  static const red = Color(0xFFFF4D4F);
  static const green = Color(0xFF00C853);
}

class AppTextStyles{
  static const heading = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary
  );

  static const subHeading = TextStyle(
      fontSize: 14,
      color: AppColors.textSecondary,
  );

  static const infoValue = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: AppColors.accentGreen
  );

  static const button = TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.w600,
      color: Colors.white
  );

  static const label = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

}

class AppPadding{
  static const screen = EdgeInsets.all(16);
  static const section = EdgeInsets.symmetric(vertical: 12);
  static const card = EdgeInsets.all(16);
}