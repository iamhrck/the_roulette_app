import 'package:flutter/material.dart';
import 'package:the_roulette_app/shared/constants/app_colors.dart';

class AppTextStyle {
  AppTextStyle._();

  static TextStyle headline3 = TextStyle(
      fontSize: 24.0,
      fontWeight: FontWeight.w700,
      color: AppColors.black.withOpacity(0.7));
  static const TextStyle headline4 =
      TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500);
  static const TextStyle bodyText = TextStyle(fontSize: 18.0);
}
