import 'package:dev_quiz/core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NextButtonWidget extends StatelessWidget {
  final String label;
  final Color backgroundColor;
  final Color fontColor;
  final Color borderColor;
  final Color overlayColor;
  final VoidCallback onTap;

  const NextButtonWidget({
    Key? key,
    required this.label,
    required this.backgroundColor,
    required this.fontColor,
    required this.borderColor,
    required this.overlayColor,
    required this.onTap,
  }) : super(key: key);

  NextButtonWidget.gree({required String label, required this.onTap})
      : this.label = label,
        this.fontColor = AppColors.white,
        this.backgroundColor = AppColors.darkGreen,
        this.borderColor = AppColors.green,
        this.overlayColor = AppColors.darkGreen;

  NextButtonWidget.white({required String label, required this.onTap})
      : this.label = label,
        this.fontColor = AppColors.grey,
        this.backgroundColor = AppColors.white,
        this.borderColor = AppColors.border,
        this.overlayColor = AppColors.green;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      child: TextButton(
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(overlayColor),
          backgroundColor: MaterialStateProperty.all(backgroundColor),
          side: MaterialStateProperty.all(BorderSide(color: AppColors.border)),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        onPressed: onTap,
        child: Text(
          label,
          style: GoogleFonts.notoSans(
            fontWeight: FontWeight.w600,
            fontSize: 15,
            color: fontColor,
          ),
        ),
      ),
    );
  }
}
