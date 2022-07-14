import 'package:emedassistantmobile/controller/doctorController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../config/app_colors.dart';
import '../config/app_images.dart';

class DoctorDrawerAction extends StatelessWidget {
  DoctorDrawerAction({Key? key}) : super(key: key);

  final DoctorController doctorController = Get.put(DoctorController());

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Scaffold.of(context).openEndDrawer();
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const CircleAvatar(
            radius: 14.0,
            backgroundImage: AssetImage(AppImages.doctorImage),
          ),
          const SizedBox(width: 8.0),
          GetBuilder<DoctorController>(
            builder: (s) => Text(
              s.firstName,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
                color: AppColors.black,
              ),
            ),
          ),
          const SizedBox(width: 12.0),
          const Icon(Icons.menu, color: AppColors.black, size: 28.0),
          const SizedBox(width: 12.0),
        ],
      ),
    );
  }
}
