import 'package:flutter/material.dart';

import 'package:emedDoctor/config/app_colors.dart';

class SpecialityBox extends StatefulWidget {
  final String? text;
  final VoidCallback? onTap;

  const SpecialityBox({Key? key,
    this.text = 'Allergists/Immunologists',
    required this.onTap,
}) : super(key: key);

  @override
  State<SpecialityBox> createState() => _SpecialityBoxState();
}

class _SpecialityBoxState extends State<SpecialityBox> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 12.0, right: 12.0),
        child: Material(
          color: AppColors.white,
          child: InkWell(
            onTap: widget.onTap,
            borderRadius: BorderRadius.circular(40.0),
            child: Ink(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.primary,
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(40.0),
              ),
              child: Text(widget.text!,
                style: const TextStyle(
                  fontSize: 15.0,
                  color: AppColors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ),
    );

  }
}
