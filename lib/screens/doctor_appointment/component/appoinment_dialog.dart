import 'package:dio/dio.dart';
import 'package:emedDoctor/screens/settings/setting_screen.dart';
import 'package:emedDoctor/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'package:emedDoctor/config/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../config/constants.dart';

class AppointmentDialog extends StatefulWidget {
  List? appoinstments;

  AppointmentDialog(this.appoinstments, {Key? key}) : super(key: key);

  @override
  State<AppointmentDialog> createState() => _AppointmentDialogState();
}

class _AppointmentDialogState extends State<AppointmentDialog> {
  TextEditingController customMessageController = TextEditingController();
  late SharedPreferences prefs;
  String lateBy = '00:00:00';

  void doctorDelayNotification(String id) async {
    prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token") ?? '';
    try {
      
      var dio = Dio();
      dio.options.headers["authorization"] = "Bearer " + token;

      print(id);
      await dio.post(
          Constants().getBaseUrl() + '/Doctor/AvailabilityDelayNotification/',
          data: {
            "AvailabilityId": id,
            "DelayedBy": lateBy,
            "Note": customMessageController.text,
          }).then((res) {
            print(res.data);
            EasyLoading.showSuccess('Done');
      });
    } on DioError catch (e) {
      EasyLoading.dismiss();
      print(e.response!.data);
      EasyLoading.showError('Something went wrong');
    }
  }

  void sendDelays() {
    Get.back();
    EasyLoading.show();
    widget.appoinstments!.forEach((element) => {
      //print(element['Id']);
      doctorDelayNotification(element['Id'])

      
      });
      EasyLoading.dismiss();
      
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          width: width,
          margin: const EdgeInsets.symmetric(horizontal: 20.0),
          decoration: const BoxDecoration(
            color: AppColors.lightBackground,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    'Late announcement',
                    style: TextStyle(
                      fontSize: 17.0,
                      color: AppColors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Container(
                width: width,
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                decoration: const BoxDecoration(
                  color: AppColors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      /// set the delay
                      const Text(
                        'Set the delay',
                        style: TextStyle(
                          fontSize: 15.0,
                          color: AppColors.lightBlack,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          delayBox(
                              lateBy == '00:00:10'
                                  ? AppColors.secondary
                                  : AppColors.primary,
                              '10 min',
                              lateBy == '00:00:45'
                                  ? AppColors.secondary
                                  : lateBy == '00:00:10'
                                      ? AppColors.secondary
                                      : AppColors.black,
                              () => {
                                    setState(() {
                                      lateBy = '00:00:10';
                                    })
                                  }),
                          delayBox(
                              lateBy == '00:00:20'
                                  ? AppColors.secondary
                                  : AppColors.primary,
                              '20 min',
                              lateBy == '00:00:20'
                                  ? AppColors.secondary
                                  : AppColors.black,
                              () => {
                                    setState(() {
                                      lateBy = '00:00:20';
                                    })
                                  }),
                          delayBox(
                              lateBy == '00:00:30'
                                  ? AppColors.secondary
                                  : AppColors.primary,
                              '30 min',
                              lateBy == '00:00:30'
                                  ? AppColors.secondary
                                  : AppColors.black,
                              () => {
                                    setState(() {
                                      lateBy = '00:00:30';
                                    })
                                  }),
                          delayBox(
                              lateBy == '00:00:45'
                                  ? AppColors.secondary
                                  : AppColors.primary,
                              '45 min',
                              lateBy == '00:00:45'
                                  ? AppColors.secondary
                                  : AppColors.black,
                              () => {
                                    setState(() {
                                      lateBy = '00:00:45';
                                    })
                                  }),
                          delayBox(
                              lateBy == '00:01:00'
                                  ? AppColors.secondary
                                  : AppColors.primary,
                              '60 min',
                              lateBy == '00:01:00'
                                  ? AppColors.secondary
                                  : AppColors.black,
                              () => {
                                    setState(() {
                                      lateBy = '00:01:00';
                                    })
                                  }),
                        ],
                      ),

                      /// select a preset message
                      const SizedBox(height: 24.0),
                      const Text(
                        'Select a preset message',
                        style: TextStyle(
                          fontSize: 15.0,
                          color: AppColors.lightBlack,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Container(
                        width: width,
                        height: 40.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2.0),
                          color: AppColors.white,
                          border: Border.all(
                            color: AppColors.primary,
                            width: 1.0,
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Text(''),
                            Spacer(),
                            Icon(Icons.keyboard_arrow_down_rounded,
                                color: AppColors.primary),
                            SizedBox(width: 8.0),
                          ],
                        ),
                      ),

                      /// or create a custom message
                      const SizedBox(height: 24.0),
                      const Text(
                        'or create a custom message',
                        style: TextStyle(
                          fontSize: 15.0,
                          color: AppColors.lightBlack,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      const SizedBox(height: 10.0),
                      Container(
                        width: width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2.0),
                          color: AppColors.white,
                          border: Border.all(
                            color: AppColors.primary,
                            width: 1.0,
                          ),
                        ),
                        child: TextFormField(
                          maxLines: 5,
                          controller: customMessageController,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                              left: 16.0,
                              top: 16.0,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 24.0),
                    ],
                  ),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: CustomButton(
                      onTap: () {
                        Get.back();
                      },
                      btnText: 'Cancel',
                      borderColor: AppColors.primary,
                      btnColor: AppColors.white,
                      width: 60.0,
                      fontColor: AppColors.black,
                    ),
                  ),
                  const SizedBox(width: 12.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: CustomButton(
                      onTap: () {
                        sendDelays();
                      },
                      btnText: 'Publish',
                      width: 80.0,
                    ),
                  ),
                  const SizedBox(width: 16.0),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget delayBox(borderColor, minText, textColor, OnTap) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: borderColor,
            width: 1.0,
          ),
        ),
        child: InkWell(
          onTap: OnTap,
          child: Text(
            minText,
            style: TextStyle(
              fontSize: 14.0,
              color: textColor,
            ),
          ),
        ),
      );
}
