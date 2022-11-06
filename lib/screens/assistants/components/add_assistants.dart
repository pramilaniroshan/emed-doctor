import 'package:dio/dio.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:emedDoctor/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'package:emedDoctor/config/app_colors.dart';

import 'package:form_validator/form_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../config/constants.dart';

class AddAssistantsDialog extends StatefulWidget {
  const AddAssistantsDialog({Key? key}) : super(key: key);

  @override
  State<AddAssistantsDialog> createState() => _AddAssistantsDialog();
}

class _AddAssistantsDialog extends State<AddAssistantsDialog> {
  TextEditingController customMessageController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController countryCodeController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();

  List<String> items = [
    'Mr',
    'Ms',
    'Miss',
  ];
  String? selectedValue = 'Mr';

  List<String> countryCodes = [
    '+94',
    '+95',
    '+96',
  ];
String? selectedCountryCode = '+94';

final _assistnentFormKey = GlobalKey<FormState>();

final validate = ValidationBuilder().minLength(10).maxLength(50).build();

late SharedPreferences prefs;


void addAss() async {
  EasyLoading.show();
    print('Doctor Availability');
    prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token") ?? '';
    try {
      var dio = Dio();
      dio.options.headers["authorization"] = "Bearer " + token;
      await dio
          .post(
        Constants().getBaseUrl() + '/Doctor/CreateAssistant',data: {
  "Title": selectedValue ?? '',
  "FirstName": firstNameController.text,
  "LastName": lastNameController.text,
  "Email": emailController.text,
  "PhoneNumber": selectedCountryCode,
  "Permissions": [
    "PERMISSION.DRASSISTANT.*"
  ]
}
        
      )
          .then((res) {
            EasyLoading.dismiss();
             EasyLoading.showSuccess('Done');
             Get.back();
      });
    } on DioError catch (e) {
      print(e.response!.data['Data'][0]);
      EasyLoading.dismiss();
      //EasyLoading.showError("Something went wrong!");
      EasyLoading.showError(e.response!.data['Data'][0] ?? 'Error');
    }
  }

  @override
  Widget build(BuildContext context) {
    //double height = MediaQuery.of(context).size.height;
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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      'Add assistant',
                      style: TextStyle(
                        fontSize: 17.0,
                        color: AppColors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Form(
                  key: _assistnentFormKey,
                  child: Container(
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
                          /// Title
                          const SizedBox(height: 24.0),
                          const Text(
                            'Title',
                            style: TextStyle(
                              fontSize: 15.0,
                              color: AppColors.lightBlack,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          Container(
                            width: width / 4,
                            height: 30.00,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2.0),
                              color: AppColors.white,
                              border: Border.all(
                                color: AppColors.primary,
                                width: 1.0,
                              ),
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
                
                          /// or create a custom message
                          const SizedBox(height: 24.0),
                          const Text(
                            'Name',
                            style: TextStyle(
                              fontSize: 15.0,
                              color: AppColors.lightBlack,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                
                          const SizedBox(height: 10.0),
                          Container(
                            width: width,
                            height: 40.00,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2.0),
                              color: AppColors.white,
                              border: Border.all(
                                color: AppColors.primary,
                                width: 1.0,
                              ),
                            ),
                            child: TextFormField(
                              controller: firstNameController,
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(
                                  left: 16.0,
                                  top: 5.0,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24.0),
                          const Text(
                            'Last name',
                            style: TextStyle(
                              fontSize: 15.0,
                              color: AppColors.lightBlack,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                
                          const SizedBox(height: 10.0),
                          Container(
                            width: width,
                            height: 40.00,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2.0),
                              color: AppColors.white,
                              border: Border.all(
                                color: AppColors.primary,
                                width: 1.0,
                              ),
                            ),
                            child: TextFormField(
                              controller: lastNameController,
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(
                                  left: 16.0,
                                  top: 5.0,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24.0),
                          const Text(
                            'Email',
                            style: TextStyle(
                              fontSize: 15.0,
                              color: AppColors.lightBlack,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                
                          const SizedBox(height: 10.0),
                          Container(
                            width: width,
                            height: 40.00,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2.0),
                              color: AppColors.white,
                              border: Border.all(
                                color: AppColors.primary,
                                width: 1.0,
                              ),
                            ),
                            child: TextFormField(
                              controller: emailController,
                              validator: ValidationBuilder()
                                    .email()
                                    .maxLength(50)
                                    .build(),
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                prefixIcon: Padding(
                                  padding: EdgeInsets.only(
                                      top: 0), // add padding to adjust icon
                                  child: Icon(Icons.email_outlined),
                                ),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(
                                  left: 16.0,
                                  top: 5.0,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24.0),
                          const Text(
                            'Country code',
                            style: TextStyle(
                              fontSize: 15.0,
                              color: AppColors.lightBlack,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                
                          const SizedBox(height: 10.0),
                          Container(
                            width: width / 4,
                            height: 40.00,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2.0),
                              color: AppColors.white,
                              border: Border.all(
                                color: AppColors.primary,
                                width: 1.0,
                              ),
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
                          const SizedBox(height: 24.0),
                          const Text(
                            'Mobile number',
                            style: TextStyle(
                              fontSize: 15.0,
                              color: AppColors.lightBlack,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                
                          const SizedBox(height: 10.0),
                          Container(
                            width: width,
                            height: 40.00,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2.0),
                              color: AppColors.white,
                              border: Border.all(
                                color: AppColors.primary,
                                width: 1.0,
                              ),
                            ),
                            child: TextFormField(
                              controller: mobileNumberController,
                              validator: validate,
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(
                                  left: 16.0,
                                  top: 5.0,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24.0),
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
                          //Get.to(const SettingsScreen());
                          // _assistnentFormKey.currentState!.validate(){

                          // }
                          addAss();
                        },
                        btnText: 'Publish',
                        width: 80.0,
                      ),
                    ),
                    const SizedBox(width: 16.0),
                  ],
                )
                        ],
                      ),
                      
                    ),
                    
                  ),
                  
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget delayBox(borderColor, minText, textColor) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: borderColor,
            width: 1.0,
          ),
        ),
        child: Text(
          minText,
          style: TextStyle(
            fontSize: 14.0,
            color: textColor,
          ),
        ),
      );
}
