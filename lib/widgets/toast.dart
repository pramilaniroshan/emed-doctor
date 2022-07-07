import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../config/app_colors.dart';

void showErrorToast(
    {required FToast? fToast, required bool isError, required String msg}) {
  Widget error = Container(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      color: Color.fromARGB(255, 228, 73, 70),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.close,
          color: AppColors.white,
        ),
        SizedBox(
          width: 12.0,
        ),
        Text(msg, style: TextStyle(color: AppColors.white)),
      ],
    ),
  );

  Widget done = Container(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      color: Color.fromARGB(255, 75, 228, 70),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: const [
        Icon(
          Icons.check,
          color: AppColors.white,
        ),
        SizedBox(
          width: 12.0,
        ),
        Text("Done", style: TextStyle(color: AppColors.white)),
      ],
    ),
  );

  fToast!.showToast(
    child: isError ? error : done,
    gravity: ToastGravity.BOTTOM,
    toastDuration: Duration(seconds: 2),
  );
}
