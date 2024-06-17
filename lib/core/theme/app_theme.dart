import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_style/core/theme/colors.dart';

class AppTheme {
  static _border([Color color = AppColors.primaryText]) => OutlineInputBorder(
        borderSide: BorderSide(
          color: color,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(5.r),
      );
  static final whiteThemeMode = ThemeData.light().copyWith(
    scaffoldBackgroundColor: AppColors.primaryBackground,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primaryBackground,
    ),
    chipTheme: const ChipThemeData(
      color: WidgetStatePropertyAll(
        AppColors.primaryBackground,
      ),
      side: BorderSide.none,
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(27),
      border: _border(),
      enabledBorder: _border(AppColors.primaryEnabledBorder),
      focusedBorder: _border(AppColors.primaryFocusBorder),
      errorBorder: _border(AppColors.primaryStatusError),
    ),
    splashColor: AppColors.containerBorder.withOpacity(0.1),
    highlightColor: AppColors.containerBorder.withOpacity(0.1),
  );
}
