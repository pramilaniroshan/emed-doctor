
import 'package:emedDoctor/config/app_colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final double? width;
  final double? height;
  final double? radius;
  final double? fontSize;
  final Color? fontColor;
  final String? btnText;
  final Color? btnColor;
  final Color? borderColor;
  final VoidCallback? onTap;

  const CustomButton({Key? key,
    this.width,
    this.height = 40.0,
    this.radius = 6.0,
    this.fontSize = 15.0,
    this.btnText = '',
    this.btnColor = AppColors.secondary,
    this.fontColor = AppColors.white,
    this.borderColor = AppColors.secondary,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(width ?? MediaQuery.of(context).size.width, height!),
        primary: btnColor,
        side: BorderSide(color: borderColor!),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius!),
        ),
      ),
      onPressed: onTap,
      child: Text(btnText!,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w600,
          color: fontColor,
        ),
      ),
    );
  }
}