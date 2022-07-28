import 'package:dio/dio.dart';
import 'package:emedassistantmobile/screens/assistants/components/add_assistants.dart';
import 'package:emedassistantmobile/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';

import 'package:emedassistantmobile/config/app_colors.dart';
import 'package:emedassistantmobile/config/app_images.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../config/constants.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/user_avatar.dart';

class AssistantsScreen extends StatefulWidget {
  const AssistantsScreen({Key? key}) : super(key: key);

  @override
  State<AssistantsScreen> createState() => _AssistantsScreen();
}

class _AssistantsScreen extends State<AssistantsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List assistants = [];

  void getAssistants() async {
    print('Assistants');
    var prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token") ?? '';
    try {
      var dio = Dio();
      dio.options.headers["authorization"] = "Bearer " + token;
      await dio
          .get(
        Constants().getBaseUrl() + '/Doctor/GetAssistants',
      )
          .then((res) {
        setState(() {
          assistants = res.data['Data']['Data'];
        });
        //print(assistants[0]);
      });
    } on DioError catch (e) {
      print(e.response!.data);
    }
  }

  void enableAssistant(String id, bool isEnbled) async {
    EasyLoading.show();
    var prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token") ?? '';
    try {
      var dio = Dio();
      dio.options.headers["authorization"] = "Bearer " + token;
      await dio.post(
          Constants().getBaseUrl() + '/Doctor/DisableEnableAssistant',
          data: {"AssistantId": id, "IsEnabled": !isEnbled}).then((res) {
        getAssistants();
        EasyLoading.dismiss();
        EasyLoading.showSuccess('done');
      });
    } on DioError catch (e) {
      print(e.response!.data);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAssistants();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: AppColors.white,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: SvgPicture.asset(AppImages.eMedLogo),
        ),
        leadingWidth: 110.0,
        actions: [DoctorDrawerAction()],
      ),
      endDrawer: DoctorDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Text(
              'Assistants',
              style: TextStyle(
                fontSize: 25.0,
                color: AppColors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          /// date text and today late button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const SizedBox(width: 24.0),
                Column(children: [
                  CustomButton(
                    onTap: () {
                      Get.dialog(const AddAssistantsDialog());
                    },
                    btnText: 'Add New',
                    width: 5.0,
                  ),
                ]),
              ],
            ),
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: Container(
              color: AppColors.white,
              width: width,
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 40.0, top: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: width,
                      //padding: const EdgeInsets.all(12.0),
                      margin: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          assistants.isEmpty
                              ? const Center(child: CircularProgressIndicator())
                              : Column(
                                  children: List.generate(
                                  assistants.length,
                                  (index) => assistantsList(
                                    assistants[index]['Id'],
                                    assistants[index]['FirstName'],
                                    assistants[index]['LastName'],
                                    assistants[index]['IsActive'],
                                  ),
                                )),
                          const SizedBox(height: 16.0),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget assistantsList(
          String id, String firstName, String lastName, bool isActive) =>
      Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: AppColors.white,
          border: Border.all(
            color: AppColors.lightBlue.withOpacity(0.8),
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'ID',
                          style: TextStyle(
                            fontSize: 12.0,
                            color: AppColors.primary,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          id,
                          style: const TextStyle(
                            fontSize: 14.0,
                            color: AppColors.redColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    )),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        'First Name',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: AppColors.primary,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        firstName,
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: AppColors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                isActive
                    ? TextButton(
                        onPressed: () => {
                          Get.defaultDialog(
                              title: "Are you sure?",
                              textConfirm: "Confirm",
                              textCancel: "Cancel",
                              radius: 0,
                              middleText: '',
                              buttonColor: AppColors.secondary,
                              onConfirm: () => {
                                    enableAssistant(id, isActive),
                                    Get.back(),
                                  }),
                        },
                        child: Image.asset(
                          AppImages.eyeIcon,
                          width: 50,
                          height: 50,
                          scale: 0.10,
                        ),
                      )
                    : TextButton(
                        onPressed: () => {
                          Get.defaultDialog(
                              title: "Are you sure?",
                              textConfirm: "Confirm",
                              textCancel: "Cancel",
                              radius: 0,
                              middleText: '',
                              buttonColor: AppColors.secondary,
                              onConfirm: () =>
                                  {enableAssistant(id, isActive), Get.back()}),
                        },
                        child: Image.asset(
                          AppImages.eyeClose,
                          width: 50,
                          height: 50,
                          scale: 0.10,
                        ),
                      ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        'Last name',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: AppColors.primary,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        lastName,
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: AppColors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                //SvgPicture.asset(AppImages.deleteDisableIcon),
                TextButton(
                  onPressed: () => {
                    Get.defaultDialog(
                        title: "Are you sure?",
                        textConfirm: "Confirm",
                        textCancel: "Cancel",
                        barrierDismissible: false,
                        radius: 0,
                        middleText: '',
                        buttonColor: AppColors.secondary,
                        onConfirm: () => {print('delete')}),
                  },
                  child: Image.asset(
                    AppImages.deleteBlue,
                    width: 50,
                    height: 50,
                    scale: 0.10,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text(
                        'Email',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: AppColors.primary,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'pramila@dota2.com',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: AppColors.black,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                //SvgPicture.asset(AppImages.deleteDisableIcon),
                TextButton(
                  onPressed: () => {print('edit')},
                  child: Image.asset(
                    AppImages.editIcon,
                    width: 50,
                    height: 50,
                    scale: 0.10,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Mobile n°',
                          style: TextStyle(
                            fontSize: 12.0,
                            color: AppColors.primary,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          '0711844200',
                          style: TextStyle(
                            fontSize: 14.0,
                            color: AppColors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          ],
        ),
      );

  // Widget assistantsDisableList() => Container(
  //       padding: const EdgeInsets.all(12.0),
  //       //margin: const EdgeInsets.symmetric(horizontal: 16.0),
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(16.0),
  //         color: AppColors.white,
  //         border: Border.all(
  //           color: AppColors.lightBlue.withOpacity(0.8),
  //         ),
  //       ),
  //       child: Column(
  //         children: [
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.start,
  //             children: [
  //               Expanded(
  //                   flex: 1,
  //                   child: Column(
  //                     mainAxisAlignment: MainAxisAlignment.start,
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: const [
  //                       Text(
  //                         'ID',
  //                         style: TextStyle(
  //                           fontSize: 12.0,
  //                           color: AppColors.primary,
  //                           fontWeight: FontWeight.w400,
  //                         ),
  //                       ),
  //                       SizedBox(height: 8.0),
  //                       Text(
  //                         'AZ453D',
  //                         style: TextStyle(
  //                           fontSize: 14.0,
  //                           color: AppColors.redColor,
  //                           fontWeight: FontWeight.w500,
  //                         ),
  //                       ),
  //                     ],
  //                   )),
  //             ],
  //           ),
  //           const SizedBox(height: 10),
  //           Row(
  //             crossAxisAlignment: CrossAxisAlignment.center,
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               Expanded(
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   mainAxisAlignment: MainAxisAlignment.start,
  //                   children: const [
  //                     Text(
  //                       'Name',
  //                       style: TextStyle(
  //                         fontSize: 12.0,
  //                         color: AppColors.primary,
  //                         fontWeight: FontWeight.w400,
  //                       ),
  //                     ),
  //                     SizedBox(height: 8.0),
  //                     Text(
  //                       'Pramila',
  //                       style: TextStyle(
  //                         fontSize: 14.0,
  //                         color: AppColors.primary,
  //                         fontWeight: FontWeight.w600,
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //               Image.asset(
  //                 AppImages.eyeClose,
  //                 width: 50,
  //                 height: 50,
  //                 scale: 0.10,
  //               ),
  //             ],
  //           ),
  //           const SizedBox(height: 20),
  //           Row(
  //             crossAxisAlignment: CrossAxisAlignment.center,
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               Expanded(
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   mainAxisAlignment: MainAxisAlignment.start,
  //                   children: const [
  //                     Text(
  //                       'Last name',
  //                       style: TextStyle(
  //                         fontSize: 12.0,
  //                         color: AppColors.primary,
  //                         fontWeight: FontWeight.w400,
  //                       ),
  //                     ),
  //                     SizedBox(height: 8.0),
  //                     Text(
  //                       'Niroshan',
  //                       style: TextStyle(
  //                         fontSize: 14.0,
  //                         color: AppColors.primary,
  //                         fontWeight: FontWeight.w600,
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //               //SvgPicture.asset(AppImages.deleteDisableIcon),
  //               Image.asset(
  //                 AppImages.deleteBlue,
  //                 width: 50,
  //                 height: 50,
  //                 scale: 0.10,
  //               ),
  //             ],
  //           ),
  //           const SizedBox(height: 20),
  //           Row(
  //             crossAxisAlignment: CrossAxisAlignment.center,
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               Expanded(
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   mainAxisAlignment: MainAxisAlignment.start,
  //                   children: const [
  //                     Text(
  //                       'Email',
  //                       style: TextStyle(
  //                         fontSize: 12.0,
  //                         color: AppColors.primary,
  //                         fontWeight: FontWeight.w400,
  //                       ),
  //                     ),
  //                     SizedBox(height: 8.0),
  //                     Text(
  //                       'pramila@dota2.com',
  //                       style: TextStyle(
  //                         fontSize: 14.0,
  //                         color: AppColors.primary,
  //                         fontWeight: FontWeight.w400,
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //               //SvgPicture.asset(AppImages.deleteDisableIcon),
  //               Image.asset(
  //                 AppImages.editIcon,
  //                 width: 50,
  //                 height: 50,
  //                 scale: 0.10,
  //               ),
  //             ],
  //           ),
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.start,
  //             children: [
  //               Expanded(
  //                   flex: 1,
  //                   child: Column(
  //                     mainAxisAlignment: MainAxisAlignment.start,
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: const [
  //                       Text(
  //                         'Mobile n°',
  //                         style: TextStyle(
  //                           fontSize: 12.0,
  //                           color: AppColors.primary,
  //                           fontWeight: FontWeight.w400,
  //                         ),
  //                       ),
  //                       SizedBox(height: 8.0),
  //                       Text(
  //                         '0711844200',
  //                         style: TextStyle(
  //                           fontSize: 14.0,
  //                           color: AppColors.primary,
  //                           fontWeight: FontWeight.w400,
  //                         ),
  //                       ),
  //                     ],
  //                   )),
  //             ],
  //           ),
  //         ],
  //       ),
  //     );
}
