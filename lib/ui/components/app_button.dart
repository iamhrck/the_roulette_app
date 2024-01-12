import 'package:flutter/material.dart';
import 'package:the_roulette_app/shared/constants/app_colors.dart';
import 'package:the_roulette_app/shared/constants/app_text_style.dart';

class AppButton extends StatelessWidget {
  final String text;
  final TextStyle style;
  final Color textColor;
  final Color buttonColor;
  final Function onPressed;

  const AppButton(
      {super.key,
      required this.text,
      this.style = AppTextStyle.headline4,
      this.textColor = AppColors.white,
      this.buttonColor = AppColors.blue,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: textColor,
          backgroundColor: buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () {
          onPressed();
        },
        child: Text(text, style: style));
  }
}
