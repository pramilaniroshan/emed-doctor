import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:emedassistantmobile/screens/profile_setup/setup_two_screen.dart';
import 'package:emedassistantmobile/screens/settings/setting_screen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:emedassistantmobile/config/app_colors.dart';
import 'package:emedassistantmobile/config/app_images.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_field.dart';

class ProfileSetupOneScreen extends StatefulWidget {
  const ProfileSetupOneScreen({Key? key}) : super(key: key);

  @override
  State<ProfileSetupOneScreen> createState() => _ProfileSetupOneScreenState();
}

class _ProfileSetupOneScreenState extends State<ProfileSetupOneScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController nicNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController slmcNumberController = TextEditingController();

  String? selectedValue;
  String? selectedCountryCode;
  List<String> items = [
    'Mr',
    'Ms',
    'Miss',
  ];

  List<String> countryCodes = [
    '+94',
    '+95',
    '+96',
  ];

  PlatformFile? file;
  File? frontFile;
  String? frontFileName;
  File? backFile;
  String? backFileName;
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
              onTap: () {
                Get.to(SettingsScreen());
              },
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
                    '1/2',
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
                    'Title',
                    style: TextStyle(
                      fontSize: 15.0,
                      color: AppColors.lightBlack,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8.0),

                  /// Title
                  Container(
                    height: 40.0,
                    width: 110.0,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.lightBackground,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2(
                        icon: const Icon(Icons.keyboard_arrow_down),
                        hint: const Text(
                          'Mr',
                          style: TextStyle(
                            fontSize: 13.0,
                            color: AppColors.lightBlack,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        items: items
                            .map(
                              (item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    fontSize: 15.0,
                                    color: AppColors.lightBlack,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                        value: selectedValue,
                        onChanged: (value) {
                          setState(() {
                            selectedValue = value as String;
                          });
                        },
                        buttonHeight: 40,
                        buttonWidth: 140,
                        itemHeight: 36.0,
                        dropdownWidth: 150,
                        buttonPadding:
                            const EdgeInsets.symmetric(horizontal: 8.0),
                        dropdownDecoration: const BoxDecoration(
                          color: AppColors.lightBackground,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),

                  /// Name
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text(
                        '* ',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.red,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'Name',
                        style: TextStyle(
                          fontSize: 15.0,
                          color: AppColors.lightBlack,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  CustomField(
                    controller: nameController,
                    height: 40.0,
                    keyboardType: TextInputType.name,
                    width: width,
                  ),
                  const SizedBox(height: 24.0),

                  /// Last Name
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text(
                        '* ',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.red,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'Last Name',
                        style: TextStyle(
                          fontSize: 15.0,
                          color: AppColors.lightBlack,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  CustomField(
                    controller: lastNameController,
                    height: 40.0,
                    keyboardType: TextInputType.name,
                    width: width,
                  ),

                  /// Email
                  const SizedBox(height: 24.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text(
                        '* ',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.red,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'Email',
                        style: TextStyle(
                          fontSize: 15.0,
                          color: AppColors.lightBlack,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  CustomField(
                    controller: emailController,
                    height: 40.0,
                    keyboardType: TextInputType.emailAddress,
                    width: width,
                    isPrefixIcon: true,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(
                          left: 0.0, top: 10.0, bottom: 10.0),
                      child: SvgPicture.asset(AppImages.contactIcon),
                    ),
                    padding: const EdgeInsets.only(top: 4.0),
                  ),

                  /// country and Mobile Number
                  const SizedBox(height: 24.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: const [
                                Text(
                                  '* ',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.red,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  'Country Code',
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: AppColors.lightBlack,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              height: 40.0,
                              margin: const EdgeInsets.only(top: 8.0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColors.lightBackground,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton2(
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  hint: const Text(
                                    '+94',
                                    style: TextStyle(
                                      fontSize: 13.0,
                                      color: AppColors.lightBlack,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  items: countryCodes
                                      .map(
                                        (item) => DropdownMenuItem<String>(
                                          value: item,
                                          child: Text(
                                            item,
                                            style: const TextStyle(
                                              fontSize: 15.0,
                                              color: AppColors.lightBlack,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                  value: selectedCountryCode,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedCountryCode = value as String;
                                    });
                                  },
                                  buttonHeight: 40,
                                  buttonWidth: 140,
                                  itemHeight: 36.0,
                                  dropdownWidth: 150,
                                  dropdownDecoration: const BoxDecoration(
                                    color: AppColors.lightBackground,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: const [
                                Text(
                                  '* ',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.red,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  'Mobile Number',
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: AppColors.lightBlack,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            CustomField(
                              controller: mobileNumberController,
                              height: 40.0,
                              keyboardType: TextInputType.number,
                              width: width,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  /// NIC Number
                  const SizedBox(height: 24.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text(
                        '* ',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.red,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'NIC number',
                        style: TextStyle(
                          fontSize: 15.0,
                          color: AppColors.lightBlack,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  CustomField(
                    controller: nicNumberController,
                    height: 40.0,
                    keyboardType: TextInputType.number,
                    width: width,
                    isPrefixIcon: true,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(
                          left: 0.0, top: 10.0, bottom: 10.0),
                      child: SvgPicture.asset(AppImages.doctorIcon,
                          color: AppColors.black),
                    ),
                    padding: const EdgeInsets.only(top: 4.0),
                  ),

                  /// Address
                  const SizedBox(height: 24.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text(
                        '* ',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.red,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'Your home location: City, Street name...',
                        style: TextStyle(
                          fontSize: 15.0,
                          color: AppColors.lightBlack,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  CustomField(
                    controller: addressController,
                    height: 40.0,
                    keyboardType: TextInputType.streetAddress,
                    width: width,
                    isPrefixIcon: true,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(
                          left: 0.0, top: 10.0, bottom: 10.0),
                      child: SvgPicture.asset(AppImages.locationIcon,
                          color: AppColors.black),
                    ),
                    padding: const EdgeInsets.only(top: 4.0),
                  ),

                  /// SLMC Number
                  const SizedBox(height: 24.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text(
                        '* ',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.red,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'SLMC number',
                        style: TextStyle(
                          fontSize: 15.0,
                          color: AppColors.lightBlack,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  CustomField(
                    controller: slmcNumberController,
                    height: 40.0,
                    keyboardType: TextInputType.number,
                    width: width,
                    isPrefixIcon: true,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(
                          left: 0.0, top: 10.0, bottom: 10.0),
                      child: SvgPicture.asset(AppImages.doctorIcon,
                          color: AppColors.black),
                    ),
                    padding: const EdgeInsets.only(top: 4.0),
                  ),

                  const SizedBox(height: 24.0),
                  const Text(
                    'SLMC Identity Card details \n(.jpg .png .pdf - max 5mb)',
                    style: TextStyle(
                      fontSize: 15.0,
                      color: AppColors.lightBlack,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 12.0),

                  /// front.png image
                  Container(
                    width: width,
                    padding: const EdgeInsets.only(
                        left: 8.0, bottom: 16.0, top: 16.0),
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
                        Image.asset(
                          AppImages.frontSideImage,
                          height: 40.0,
                          width: 60.0,
                          fit: BoxFit.fill,
                        ),
                        const SizedBox(width: 8.0),
                        Expanded(
                          child: Text(
                            frontFileName ?? 'filename',
                            style: const TextStyle(
                              fontSize: 14.0,
                              color: AppColors.secondary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.delete_outline,
                              color: AppColors.primary),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  //Front file picker
                  Material(
                    child: InkWell(
                      onTap: () async {
                        try {
                          FilePickerResult? result =
                              await FilePicker.platform.pickFiles(
                            type: FileType.custom,
                            allowedExtensions: ['jpg', 'png'],
                          );
                          if (result != null) {
                            setState(() {
                              file = result.files.first;
                              frontFileName = file!.name;
                              //frontFile = File(file!.path.toString());
                            });
                            print(file!.name);
                            //print(file!.path);
                          } else {
                            // User canceled the picker
                          }
                        } catch (e) {
                          print(e);
                        }
                      },
                      borderRadius: BorderRadius.circular(4.0),
                      child: Ink(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 8.0),
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
                            Icon(Icons.upload_outlined,
                                color: AppColors.black, size: 20.0),
                            SizedBox(width: 8.0),
                            Text(
                              'Click to Upload',
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

                  /// back.png image
                  const SizedBox(height: 12.0),
                  Container(
                    width: width,
                    padding: const EdgeInsets.only(
                        left: 8.0, bottom: 16.0, top: 16.0),
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
                        // Image.file(
                        //   frontFile ?? File(AppImages.frontSideImage),
                        //   height: 40.0,
                        //   width: 60.0,
                        //   fit: BoxFit.fill,
                        // ),
                        const SizedBox(width: 8.0),
                        const Expanded(
                          child: Text(
                            'back.png',
                            style: TextStyle(
                              fontSize: 14.0,
                              color: AppColors.secondary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.delete_outline,
                              color: AppColors.primary),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  //Back file picker
                  Material(
                    child: InkWell(
                      onTap: () async {
                        try {
                          FilePickerResult? result =
                              await FilePicker.platform.pickFiles(
                            type: FileType.custom,
                            allowedExtensions: ['jpg', 'png'],
                          );
                          if (result != null) {
                            setState(() {
                              file = result.files.first;
                              frontFileName = file!.name;
                              //frontFile = File(file!.path.toString());
                            });
                            print(file!.name);
                            //print(file!.path);
                          } else {
                            // User canceled the picker
                          }
                        } catch (e) {
                          print(e);
                        }
                      },
                      borderRadius: BorderRadius.circular(4.0),
                      child: Ink(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 8.0),
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
                            Icon(Icons.upload_outlined,
                                color: AppColors.black, size: 20.0),
                            SizedBox(width: 8.0),
                            Text(
                              'Click to Upload',
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
                  const SizedBox(height: 24.0),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomButton(
                        onTap: () {},
                        btnText: 'Cancel',
                        width: 80.0,
                        height: 36.0,
                        btnColor: AppColors.white,
                        fontColor: AppColors.black,
                        borderColor: AppColors.primary,
                        radius: 3.0,
                      ),
                      const SizedBox(width: 16.0),
                      CustomButton(
                        onTap: () {
                          Get.to(const ProfileSetupTwoScreen());
                        },
                        btnText: 'Next',
                        width: 80.0,
                        height: 36.0,
                        btnColor: AppColors.secondary,
                        fontColor: AppColors.white,
                        borderColor: AppColors.secondary,
                        radius: 3.0,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12.0),
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
