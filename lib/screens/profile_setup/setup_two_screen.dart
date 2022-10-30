import 'package:chips_choice/chips_choice.dart';
import 'package:dio/dio.dart';
import 'package:emedDoctor/screens/doctor_appointment/doctor_appointment_screen.dart';
import 'package:emedDoctor/screens/profile/create_profile_screen.dart';
import 'package:emedDoctor/screens/profile_setup/components/speciality_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:io';
import 'package:get/get.dart' hide FormData, MultipartFile;

import 'package:emedDoctor/config/app_colors.dart';
import 'package:emedDoctor/config/app_images.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../config/constants.dart';
import '../../widgets/custom_button.dart';

class ProfileSetupTwoScreen extends StatefulWidget {

  String? firstName;
  String? lastName;
  String? countryCode;
  String? phoneNumber;
  String? email;
  File? backFile;
  File? frontFile;
  num ? regNo;
  String? nID;
  
  ProfileSetupTwoScreen(this.firstName,this.lastName,this.email ,this.countryCode, this.phoneNumber ,this.frontFile, this.backFile, this.regNo ,this.nID ,{Key? key}) : super(key: key);

  @override
  State<ProfileSetupTwoScreen> createState() => _ProfileSetupTwoScreenState();
}

class _ProfileSetupTwoScreenState extends State<ProfileSetupTwoScreen> {

  late SharedPreferences prefs;
   TextEditingController codeController = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController profileDescController = TextEditingController();
   List<String> doctor_sp = [''];

  List<String> items = [
    'Allergists/Immunologists',
    'Anesthesiologists',
    'Cardiologists',
    'Colon and Rectal Surgeons',
    'Critical Care Medicine Spec.',
    'Dermatologists',
    'Endocrinologists',
    'Preventive Medicine Spec.',
    'Psychiatrists',
    'Pulmonologists',
    'Radiologists',
    'Rhenumatologists',
    'Medicine Spec.',
    'Sports Medicine Spec.',
    'General Surgeons',
    'Urologists',
  ];

  void createDoctorProfile(width) async {
    print('Doctor Register');

      var formData = FormData.fromMap({
 'LastName': widget.lastName,
 'CountryCode': 210,
 'GovDoctorIdentityPicBack': await MultipartFile.fromFile(widget.backFile!.path,filename: widget.backFile!.path.split('/').last),
 'CityId': null,
 'GovDoctorRegNo': widget.regNo,
 'NationalIdentificationNumber': widget.nID,
 'NicFrontPic': await MultipartFile.fromFile(widget.frontFile!.path,filename: widget.backFile!.path.split('/').last),
 'DoctorSpecializations': 'wendux',
 'GovDoctorIdentityPicFront': await MultipartFile.fromFile(widget.backFile!.path,filename: widget.backFile!.path.split('/').last),
 'Address': 'wendux',
 'PhoneNumber': widget.countryCode! + widget.phoneNumber!,
 'Title': 'wendux',
 'NicBackPic': await MultipartFile.fromFile(widget.backFile!.path,filename: widget.backFile!.path.split('/').last),
 'FirstName': widget.firstName,
 'Email': widget.email,
 'Description': profileDescController.text,
 'RegisterType': '0',
});

    prefs = await SharedPreferences.getInstance();
    //String token = prefs.getString("token") ?? '';
    try {
      EasyLoading.show();
      var dio = Dio();
      //dio.options.headers["authorization"] = "Bearer " + token;
      await dio
          .post(
        Constants().getBaseUrl() + '/Registration/Doctor',data: formData
      )
          .then((res) {
            EasyLoading.dismiss();
            print(res.data);
        Get.defaultDialog(
            backgroundColor: AppColors.lightBackground,
            radius: 2.0,
            title: '',
            content: bottomSheetColumn(width),
          );
      });
    } on DioError catch (e) {
       EasyLoading.showError(
         e.response!.data["Error"] ?? 'Something went wrong');
      print(e.response!.data);
    }
  }

  void otp() async {
    try {
      EasyLoading.show();
      var dio = Dio();
      await dio.post(Constants().getBaseUrl() + '/Authentication/Login', data: {
        "UserName": widget.email,
        "Otp": codeController.text,
        "DeviceId": "210"
      }).then((res) async {
        EasyLoading.dismiss();
        //showErrorToast(fToast: fToast, isError: false, msg: 'Done');
        EasyLoading.showSuccess('Done');
        final body = res.data["Data"];
        prefs = await SharedPreferences.getInstance();
        prefs.setString('token', body["AccessToken"]);
        prefs.setString('refresh_token', "yes");
        prefs.setBool('login', true);
        Get.offAll(const DoctorAppointmentScreen());
      });
    } on DioError catch (e) {
      EasyLoading.dismiss();
      String error = e.response!.data['Error'] +
          'Remaining' +
          '${e.response!.data['Data']}' +
          'Attempts';
      EasyLoading.showError(
         e.response!.data["Error"] ?? 'Something went wrong');
      // showErrorToast(
      //     fToast: fToast, isError: true, msg: e.response!.data['Error']);
    }
  }

  void loginResend() async {
    try {
       EasyLoading.show();
      var dio = Dio();
      await dio
          .post(Constants().getBaseUrl() + '/Authentication/Login-init', data: {
        "Username": widget.email,
        "UserLoginType": 0,
        "CountryCode": 210,
        "Application": 1
      }).then((res) {
        if (res.statusCode == 200) {
          EasyLoading.dismiss();
          // showErrorToast(fToast: fToast, isError: false, msg: 'Code sent');
          EasyLoading.showSuccess('Code Sent');
        }
      });
    } on DioError catch (e) {
      EasyLoading.dismiss();
      if (e.response != null) {
        var t = e.response!.data["Error"];
        // showErrorToast(
        //     fToast: fToast, isError: true, msg: e.response!.data["Error"]);
        EasyLoading.showError(
            e.response!.data["Error"] ?? 'Something went wrong');
        setState(() {});
      } else {
        EasyLoading.showError(
            e.response!.data["Error"] ?? 'Something went wrong');
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //createDoctorProfile();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.lightBackground,

      bottomNavigationBar: bottomBar(width),

      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: AppColors.white,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: SvgPicture.asset(AppImages.eMedLogo),
        ),
        leadingWidth: 110.0,
        actions: [
          menuButton(),
        ],
      ),

      endDrawer: Drawer(
        backgroundColor: AppColors.white,
        elevation: 0.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 40.0),
            Align(
              alignment: Alignment.bottomRight,
              child: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: SvgPicture.asset(
                  AppImages.closeIcon,
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            ListTile(
              onTap: () {},
              leading: Padding(
                padding: const EdgeInsets.only(top: 6.0, left: 12.0),
                child: SvgPicture.asset(
                  AppImages.supportIcon,
                  height: 13.0,
                  width: 13.0,
                  fit: BoxFit.scaleDown,
                  color: AppColors.secondary,
                ),
              ),
              title: const Align(
                alignment: Alignment(-1.3, 0),
                child: Text(
                  'Support',
                  style: TextStyle(
                    fontSize: 21.0,
                    color: AppColors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            ListTile(
              onTap: () {},
              leading: Padding(
                padding: const EdgeInsets.only(top: 6.0, left: 12.0),
                child: SvgPicture.asset(
                  AppImages.contactIcon,
                  height: 13.0,
                  width: 13.0,
                  fit: BoxFit.scaleDown,
                  color: AppColors.secondary,
                ),
              ),
              title: const Align(
                alignment: Alignment(-1.3, 0),
                child: Text(
                  'Contact',
                  style: TextStyle(
                    fontSize: 21.0,
                    color: AppColors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            ListTile(
              onTap: () {},
              leading: Padding(
                padding: const EdgeInsets.only(top: 6.0, left: 12.0),
                child: SvgPicture.asset(
                  AppImages.termsIcon,
                  height: 13.0,
                  width: 13.0,
                  fit: BoxFit.scaleDown,
                  color: AppColors.secondary,
                ),
              ),
              title: const Align(
                alignment: Alignment(-1.3, 0),
                child: Text(
                  'Terms',
                  style: TextStyle(
                    fontSize: 21.0,
                    color: AppColors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            ListTile(
              onTap: () {},
              leading: Padding(
                padding: const EdgeInsets.only(top: 6.0, left: 12.0),
                child: SvgPicture.asset(
                  AppImages.linkIcon,
                  height: 13.0,
                  width: 13.0,
                  fit: BoxFit.scaleDown,
                  color: AppColors.secondary,
                ),
              ),
              title: const Align(
                alignment: Alignment(-1.3, 0),
                child: Text(
                  'eMed.com',
                  style: TextStyle(
                    fontSize: 21.0,
                    color: AppColors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            SizedBox(height: height * 0.06),
            ListTile(
              onTap: () {},
              leading: Padding(
                padding: const EdgeInsets.only(top: 6.0, left: 12.0),
                child: SvgPicture.asset(
                  AppImages.globeIcon,
                  height: 13.0,
                  width: 13.0,
                  fit: BoxFit.scaleDown,
                  color: AppColors.secondary,
                ),
              ),
              title: const Align(
                alignment: Alignment(-1.1, 0),
                child: Text(
                  'English',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: AppColors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              trailing: const Icon(Icons.keyboard_arrow_down_outlined,
                  color: AppColors.black),
            ),
          ],
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 32.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Text(
                    'Profile setup',
                    style: TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.w600,
                      color: AppColors.black,
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Text(
                    '2/2',
                    style: TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24.0),
            Container(
              width: width,
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    'Your professional specialities',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: AppColors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8.0),

                  /// speciality list
                  // Wrap(
                  //   children: items
                  //       .map((item) {
                  //         var index = items.indexOf(item);
                  //         return SpecialityBox(
                  //           onTap: () {},
                  //           text: items[index],
                  //         );
                  //   }).toList(),
                  // ),

                  ChipsChoice<String>.multiple(
              value: doctor_sp,
              onChanged: (val) => setState(() => doctor_sp = val),
              choiceItems: C2Choice.listFrom<String, String>(
                source: items,
                value: (i, v) => v,
                label: (i, v) => v,
              ),
              choiceStyle: C2ChoiceStyle(
                borderColor: AppColors.primary,
                color: AppColors.black,
                labelPadding: EdgeInsets.all(5),
              ),
              choiceActiveStyle: C2ChoiceStyle(
                  borderColor: Color.fromRGBO(56, 158, 13, 1),
                  color: AppColors.black,
                  labelStyle: TextStyle(fontWeight: FontWeight.bold)),
              spacing: 30,
              runSpacing: 10,
              wrapped: true,
            ),

                  /// profile description heading text
                  const SizedBox(height: 32.0),
                  const Text(
                    'Profile description',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: AppColors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  /// profile description text
                  const SizedBox(height: 12.0),
                  const Text(
                    'Please add a brief presentation of your competences and your professional career.',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: AppColors.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  /// description field text
                  const SizedBox(height: 12.0),
                  Container(
                    width: width,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.primary,
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: TextFormField(
                      maxLines: 6,
                      controller: profileDescController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 16.0, top: 12.0),
                      ),
                    ),
                  ),

                  /// profile picture heading text
                  // const SizedBox(height: 24.0),
                  // const Text(
                  //   'Profile picture',
                  //   style: TextStyle(
                  //     fontSize: 18.0,
                  //     color: AppColors.black,
                  //     fontWeight: FontWeight.w700,
                  //   ),
                  // ),
                  // const Text('(.jpg .png .pdf - max 5mb)',
                  //   style: TextStyle(
                  //     fontSize: 15.0,
                  //     color: AppColors.lightBlack,
                  //     fontWeight: FontWeight.w500,
                  //   ),
                  // ),

                  // /// click to upload button
                  // const SizedBox(height: 16.0),
                  // Material(
                  //   child: InkWell(
                  //     onTap: (){},
                  //     borderRadius: BorderRadius.circular(4.0),
                  //     child: Ink(
                  //       padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                  //       decoration: BoxDecoration(
                  //         color: AppColors.white,
                  //         borderRadius: BorderRadius.circular(4.0),
                  //         border: Border.all(
                  //           color: AppColors.primary,
                  //           width: 1.5,
                  //         ),
                  //       ),
                  //       child: Row(
                  //         crossAxisAlignment: CrossAxisAlignment.center,
                  //         mainAxisAlignment: MainAxisAlignment.start,
                  //         mainAxisSize: MainAxisSize.min,
                  //         children: const [
                  //           Icon(Icons.upload_outlined, color: AppColors.black, size: 20.0),
                  //           SizedBox(width: 8.0),
                  //           Text('Click to Upload',
                  //             style: TextStyle(
                  //               fontSize: 14.0,
                  //               color: AppColors.black,
                  //               fontWeight: FontWeight.w500,
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),

                  // /// me.png image
                  // const SizedBox(height: 12.0),
                  // Container(
                  //   width: width,
                  //   padding: const EdgeInsets.only(left: 8.0, bottom: 10.0, top: 10.0),
                  //   decoration: BoxDecoration(
                  //     border: Border.all(
                  //       color: AppColors.primary,
                  //       width: 1.5,
                  //     ),
                  //     borderRadius: BorderRadius.circular(4.0),
                  //   ),
                  //   child: Row(
                  //     crossAxisAlignment: CrossAxisAlignment.center,
                  //     mainAxisAlignment: MainAxisAlignment.start,
                  //     children: [
                  //       Image.asset(AppImages.frontSideImage,
                  //         height: 40.0,
                  //         width: 60.0,
                  //         fit: BoxFit.fill,
                  //       ),
                  //       const SizedBox(width: 8.0),
                  //       const Expanded(
                  //         child: Text('me.png',
                  //           style: TextStyle(
                  //             fontSize: 14.0,
                  //             color: AppColors.secondary,
                  //             fontWeight: FontWeight.w500,
                  //           ),
                  //         ),
                  //       ),
                  //       IconButton(
                  //         onPressed: (){},
                  //         icon: const Icon(Icons.delete_outline, color: AppColors.primary),
                  //       ),
                  //     ],
                  //   ),
                  // ),

                   const SizedBox(height: 24.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomButton(
                        onTap: (){
                          Get.back();
                        },
                        btnText: 'Back',
                        width: 80.0,
                        height: 36.0,
                        btnColor: AppColors.white,
                        fontColor: AppColors.black,
                        borderColor: AppColors.primary,
                        radius: 3.0,
                      ),
                      const SizedBox(width: 16.0),
                      CustomButton(
                        onTap: (){
                          createDoctorProfile(width);
                        },
                        btnText: 'Submit',
                        width: 80.0,
                        height: 36.0,
                        btnColor: AppColors.secondary,
                        fontColor: AppColors.white,
                        borderColor: AppColors.secondary,
                        radius: 3.0,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget menuButton() => TextButton(
        onPressed: () {
          _scaffoldKey.currentState!.openEndDrawer();
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            Text(
              'Menu',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
                color: AppColors.primary,
              ),
            ),
            SizedBox(width: 5.0),
            Icon(Icons.menu, color: AppColors.black, size: 28.0),
            SizedBox(width: 12.0),
          ],
        ),
      );

  Widget bottomBar(width) => Container(
        height: 50.0,
        width: width,
        color: AppColors.white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '@2022 EMED Limited - Company number 123456789',
              style: TextStyle(
                fontSize: 12.0,
                color: AppColors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 8.0),
            SvgPicture.asset(AppImages.eMedIcon, height: 20.0, width: 20.0),
          ],
        ),
      );

      Widget bottomSheetColumn(width) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(width: 10.0),
              //SvgPicture.asset(AppImages.termsIcon, height: 20.0, width: 20.0),
              //const SizedBox(width: 10.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      'Thanks for your \nregistration.',
                      style: TextStyle(
                        fontSize: 30.0,
                        color: AppColors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 14.0),
                    const Text(
                      'We have just sent you via email and SMS the temporary code to access.Please check your inbox or mobile phone and sign in.',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: AppColors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 18.0),
                    const Text(
                      'Attention, the code will expire in 5',
                      style: TextStyle(
                        fontSize: 13.0,
                        color: AppColors.black,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Container(
                      height: 35.0,
                      width: width,
                      margin: const EdgeInsets.only(right: 16.0, top: 8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3.0),
                        border: Border.all(
                          color: AppColors.primary,
                          width: 1.5,
                        ),
                      ),
                      child: TextFormField(
                        controller: codeController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'code',
                          contentPadding:
                              EdgeInsets.only(left: 16.0, bottom: 16.0),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CustomButton(
                            onTap: () {
                              otp();
                            },
                            btnText: 'Submit',
                            width: 80.0,
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        loginResend();
                      },
                      child: const Text(
                        'Send me again the verification code',
                        style: TextStyle(
                          fontSize: 13.0,
                          color: AppColors.secondary,
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.normal,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      );
}
