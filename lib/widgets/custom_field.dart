import 'package:flutter/material.dart';

import 'package:emedassistantmobile/config/app_colors.dart';

class CustomField extends StatelessWidget {
  final TextEditingController? controller;
  final double? width;
  final double? height;
  final EdgeInsets? padding;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  final bool? isPrefixIcon;
  final String? hintText;
  final FormFieldValidator<String> ? validator;
  final bool ? readOnly;

  const CustomField({Key? key,
    this.controller,
    this.width,
    this.height = 40.0,
    this.keyboardType,
    this.prefixIcon,
    this.isPrefixIcon = false,
    this.padding,
    this.validator,
    this.hintText = '',
    this.readOnly = false,
}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8.0),
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.primary,
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: TextFormField(
        
        controller: controller,
        readOnly: readOnly ?? false,
        keyboardType: keyboardType,
        validator: validator,
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: isPrefixIcon! ? prefixIcon : null,
          contentPadding: padding ?? const EdgeInsets.only(left: 16.0, bottom: 12.0),
          hintText: hintText,
          hintStyle: const TextStyle(
            fontSize: 16.0,
            color: AppColors.lightBlack,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
