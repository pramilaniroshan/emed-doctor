import 'package:emedassistantmobile/screens/settings/components/widgets/map_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';

import 'package:emedassistantmobile/config/app_colors.dart';
import 'package:emedassistantmobile/config/app_images.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_field.dart';
import 'widgets/pro_location_widget.dart';

class LocationsScreen extends StatefulWidget {
  const LocationsScreen({Key? key}) : super(key: key);

  @override
  State<LocationsScreen> createState() => _LocationsScreenState();
}

class _LocationsScreenState extends State<LocationsScreen> {

  TextEditingController locationNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  bool isEdit = false;
  bool status = true;

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
        child: isEdit == false ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text('Your Professional Locations',
              style: TextStyle(
                fontSize: 18.0,
                color: AppColors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 32.0),
            ProLocationWidget(
              onTap: (){
                setState(() {
                  isEdit = true;
                });
              },
              locationNameText: 'Colombo center',
              addressText: 'Hospital St, Colombo 00100, Sri Lanka',
            ),

            const SizedBox(height: 20.0),
            ProLocationWidget(
              onTap: (){
                setState(() {
                  isEdit = true;
                });
              },
              locationNameText: 'Lady Ridgeway',
              addressText: 'Dr Mawatha, Colombo 00800, Sri Lanka',
            ),

            const SizedBox(height: 32.0),
            Align(
              alignment: Alignment.centerRight,
              child: CustomButton(
                onTap: (){},
                btnText: 'Add new location',
                height: 40.0,
                width: width * 0.4,
                btnColor: AppColors.secondary,
                fontColor: AppColors.white,
                borderColor: AppColors.secondary,
                radius: 6.0,
              ),
            ),

          ],
        ) : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text('Manage Location',
              style: TextStyle(
                fontSize: 18.0,
                color: AppColors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 32.0),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: AppColors.primary.withOpacity(0.1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  /// Location Name
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
                      Text('Location name',
                        style: TextStyle(
                          fontSize: 15.0,
                          color: AppColors.lightBlack,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  CustomField(
                    controller: locationNameController,
                    height: 40.0,
                    keyboardType: TextInputType.name,
                    width: width,
                    hintText: 'Colombo Center',
                    isPrefixIcon: true,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(left: 0.0, top: 10.0, bottom: 10.0),
                      child: SvgPicture.asset(AppImages.doctorIcon, color: AppColors.black),
                    ),
                    padding: const EdgeInsets.only(top: 4.0),
                  ),
                  const SizedBox(height: 24.0),

                  /// Address text
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
                      Text('Address',
                        style: TextStyle(
                          fontSize: 15.0,
                          color: AppColors.lightBlack,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  CustomField(
                    controller: locationNameController,
                    height: 40.0,
                    keyboardType: TextInputType.name,
                    width: width,
                    hintText: 'Hospital St, Colombo 00100, Sri Lanka',
                    isPrefixIcon: true,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(left: 0.0, top: 10.0, bottom: 10.0),
                      child: SvgPicture.asset(AppImages.locationIcon, color: AppColors.black),
                    ),
                    padding: const EdgeInsets.only(top: 4.0),
                  ),
                  const SizedBox(height: 24.0),

                  /// make it public
                  const SizedBox(height: 16.0),
                  const Text('Make it public',
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
                        height: 24.0,
                        width: 50.0,
                        inactiveColor: AppColors.primary,
                        inactiveToggleColor: AppColors.lightBackground,
                        activeColor: AppColors.secondary,
                        padding: 1.5,
                        value: status,
                        onToggle: (val) {
                          setState(() {
                            status = val;
                          });
                        },
                      ),
                    ],
                  ),

                  /// delete this loaction button
                  const SizedBox(height: 24.0),
                  Align(
                    alignment: Alignment.centerRight,
                    child: CustomButton(
                      onTap: (){},
                      btnText: 'Delete this location',
                      borderColor: AppColors.primary,
                      fontColor: AppColors.primary,
                      btnColor: AppColors.primary.withOpacity(0.1),
                      width: width * 0.4,
                    ),
                  ),

                  /// map box
                  const SizedBox(height: 16.0),
                  const MapBox(),

                  /// update and cancel button
                  const SizedBox(height: 24.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomButton(
                        onTap: (){
                          setState(() {
                            isEdit = false;
                          });
                        },
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
                          setState(() {
                            isEdit = false;
                          });
                        },
                        btnText: 'Update',
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
}
