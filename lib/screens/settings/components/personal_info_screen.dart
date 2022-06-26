import 'package:country_code_picker/country_code.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:emedassistantmobile/screens/book_an_appointment/book_an_appointment_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';

import 'package:emedassistantmobile/config/app_colors.dart';
import 'package:emedassistantmobile/config/app_images.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_field.dart';

class PersonalInfoScreen extends StatefulWidget {

  String? id;
  String? title;
  String? firstName;
  String? lastName;
  String? nationalIdentificationNumber;
  String? address;
  String? email;
  String? phoneNumber;
  bool? phoneNumberVisibleToPatient;

   PersonalInfoScreen(
    this.id,
    this.title,
    this.firstName,
    this.lastName,
    this.nationalIdentificationNumber,
    this.address,
    this.email,
    this.phoneNumber,
    this.phoneNumberVisibleToPatient,
    {Key? key}) : super(key: key);

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {


  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController nicNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController slmcNumberController = TextEditingController();


  String? selectedValue;
  List<String> items = [
	''
  ];
  List<String> Title = [
    'MR',
    'MRS'
  ];

  bool status = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      physics: const ScrollPhysics(),
      child: Container(
        width: width,
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 24.0),
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text('Title',
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
              width: 120.0,
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
                  hint: Text(
                    widget.title ?? '', style: TextStyle(
                    fontSize: 13.0,
                    color: AppColors.lightBlack,
                    fontWeight: FontWeight.w500,
                  ),
                  ),
                  items: Title.map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 15.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),)
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
                  buttonPadding: const EdgeInsets.symmetric(horizontal: 8.0) ,
                  dropdownDecoration: const BoxDecoration(
                    color: AppColors.lightBlack,
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
                Text('* ',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.red,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text('Name',
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
              hintText: widget.firstName,
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
                Text('* ',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.red,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text('Last Name',
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
              hintText: widget.lastName,
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
                Text('* ',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.red,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text('Email',
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
              readOnly: true,
              hintText : widget.email,
              height: 40.0,
              keyboardType: TextInputType.emailAddress,
              width: width,
              isPrefixIcon: true,
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 0.0, top: 10.0, bottom: 10.0),
                child: SvgPicture.asset(AppImages.contactIcon),
              ),
              padding: const EdgeInsets.only(top: 4.0),
            ),

            /// Country
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
                        children: [
                          Text('* ',
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.red,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text('Country Code',
                            style: TextStyle(
                              fontSize: 15.0,
                              color: AppColors.lightBlack,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          // CountryCodePicker(
                          //   initialSelection: 'IT',
                          // ),
                        ],
                      ),
                      Container(
                        height: 40.0,
                        margin: const EdgeInsets.only(top: 8.0),
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                              '+94', style: TextStyle(
                              fontSize: 13.0,
                              color: AppColors.lightBlack,
                              fontWeight: FontWeight.w500,
                            ),
                            ),
                            items: items.map((item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),)
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
                            dropdownDecoration: const BoxDecoration(
                              color: AppColors.lightBlack,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8.0),
              ],
            ),

            /// Mobile Number
            const SizedBox(height: 16.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Text('* ',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.red,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text('Mobile Number',
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
                  readOnly: true,
                  hintText: widget.phoneNumber,
                  height: 40.0,
                  keyboardType: TextInputType.number,
                  width: width,
                ),
              ],
            ),

            /// Visible to Patients
            const SizedBox(height: 16.0),
            const Text('Visible to patients',
              style: TextStyle(
                fontSize: 15.0,
                color: AppColors.lightBlack,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                FlutterSwitch(
                  height: 30.0,
                  width: 60.0,
                  inactiveColor: AppColors.primary,
                  inactiveToggleColor: AppColors.lightBackground,
                  activeColor: AppColors.secondary,
                  padding: 3.0,
                  value: widget.phoneNumberVisibleToPatient ?? false,
                  onToggle: (val) {
                    setState(() {
                      status = val;
                    });
                  },
                ),
              ],
            ),

            /// NIC Number
            const SizedBox(height: 24.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Text('* ',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.red,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text('NIC number',
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
              readOnly: true,
              hintText: widget.nationalIdentificationNumber,
              height: 40.0,
              keyboardType: TextInputType.number,
              width: width,
              isPrefixIcon: true,
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 0.0, top: 10.0, bottom: 10.0),
                child: SvgPicture.asset(AppImages.doctorIcon, color: AppColors.black),
              ),
              padding: const EdgeInsets.only(top: 4.0),
            ),

            /// Address
            const SizedBox(height: 24.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Text('* ',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.red,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text('Your home location: City, Street name...',
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
              hintText: widget.address,
              height: 40.0,
              keyboardType: TextInputType.streetAddress,
              width: width,
              isPrefixIcon: true,
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 0.0, top: 10.0, bottom: 10.0),
                child: SvgPicture.asset(AppImages.locationIcon, color: AppColors.black),
              ),
              padding: const EdgeInsets.only(top: 4.0),
            ),

            /// SLMC Number
            const SizedBox(height: 24.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Text('* ',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.red,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text('SLMC number',
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
                padding: const EdgeInsets.only(left: 0.0, top: 10.0, bottom: 10.0),
                child: SvgPicture.asset(AppImages.doctorIcon, color: AppColors.black),
              ),
              padding: const EdgeInsets.only(top: 4.0),
            ),


            const SizedBox(height: 24.0),
            const Text('SLMC Identity Card details \n(.jpg .png .pdf - max 5mb)',
              style: TextStyle(
                fontSize: 15.0,
                color: AppColors.lightBlack,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 12.0),
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

            /// front.png image
            const SizedBox(height: 12.0),
            Container(
              width: width,
              padding: const EdgeInsets.only(left: 8.0, bottom: 16.0, top: 16.0),
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
                    child: Text('front.png',
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

            /// back.png image
            const SizedBox(height: 12.0),
            Container(
              width: width,
              padding: const EdgeInsets.only(left: 8.0, bottom: 16.0, top: 16.0),
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
                    child: Text('back.png',
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
                  onTap: (){},
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
                  onTap: (){
                    //Get.to(const ProfileSetupTwoScreen());
                    Get.to(const BookAnAppointmentScreen());
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
    );
  }
}
