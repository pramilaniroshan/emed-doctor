import 'package:emedassistantmobile/screens/doctor_appointment/doctor_appointment_screen.dart';
import 'package:emedassistantmobile/screens/profile/create_profile_screen.dart';
import 'package:emedassistantmobile/screens/profile_setup/components/speciality_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:emedassistantmobile/config/app_colors.dart';
import 'package:emedassistantmobile/config/app_images.dart';
import '../../widgets/custom_button.dart';

class ProfileSetupTwoScreen extends StatefulWidget {
  const ProfileSetupTwoScreen({Key? key}) : super(key: key);

  @override
  State<ProfileSetupTwoScreen> createState() => _ProfileSetupTwoScreenState();
}

class _ProfileSetupTwoScreenState extends State<ProfileSetupTwoScreen> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController profileDescController = TextEditingController();

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
                  Wrap(
                    children: items
                        .map((item) {
                          var index = items.indexOf(item);
                          return SpecialityBox(
                            onTap: () {},
                            text: items[index],
                          );
                    }).toList(),
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
                  const SizedBox(height: 24.0),
                  const Text(
                    'Profile picture',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: AppColors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Text('(.jpg .png .pdf - max 5mb)',
                    style: TextStyle(
                      fontSize: 15.0,
                      color: AppColors.lightBlack,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  /// click to upload button
                  const SizedBox(height: 16.0),
                  Material(
                    child: InkWell(
                      onTap: (){},
                      borderRadius: BorderRadius.circular(4.0),
                      child: Ink(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(4.0),
                          border: Border.all(
                            color: AppColors.primary,
                            width: 1.5,
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(Icons.upload_outlined, color: AppColors.black, size: 20.0),
                            SizedBox(width: 8.0),
                            Text('Click to Upload',
                              style: TextStyle(
                                fontSize: 14.0,
                                color: AppColors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  /// me.png image
                  const SizedBox(height: 12.0),
                  Container(
                    width: width,
                    padding: const EdgeInsets.only(left: 8.0, bottom: 10.0, top: 10.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.primary,
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(AppImages.frontSideImage,
                          height: 40.0,
                          width: 60.0,
                          fit: BoxFit.fill,
                        ),
                        const SizedBox(width: 8.0),
                        const Expanded(
                          child: Text('me.png',
                            style: TextStyle(
                              fontSize: 14.0,
                              color: AppColors.secondary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: (){},
                          icon: const Icon(Icons.delete_outline, color: AppColors.primary),
                        ),
                      ],
                    ),
                  ),

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
                          Get.to(const DoctorAppointmentScreen());
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
}
