import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


import 'package:emedDoctor/config/app_colors.dart';
import 'package:emedDoctor/widgets/custom_button.dart';

import '../../../../config/app_images.dart';
import '../../../../widgets/custom_field.dart';

class EditLocationWidget extends StatefulWidget {
  final String? locationNameText;
  final String? addressText;
  final double? latitude;
  final double?  longitude;
  bool ? status;
  //final Function()? onTap;

   EditLocationWidget({Key? key,
    //required this.onTap,
    this.locationNameText = 'Colombo center',
    this.addressText = 'Address text',
    this.latitude = 0.0,
    this.longitude = 0.0,
    this.status = false
}) : super(key: key);

  @override
  State<EditLocationWidget> createState() => _EditLocationWidgetState();
}

class _EditLocationWidgetState extends State<EditLocationWidget> {

  TextEditingController locationNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  bool isEdit = false;
  
  bool isAdd = false;

  List locations = [];

  double? lat;
  double? long;

  final Set<Marker> _markers = {};
  Set<Circle> circles = {};


  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _markers.add(
         Marker(
          markerId: const MarkerId('id-1'),
          position: LatLng( widget.latitude ?? 0, widget.longitude ?? 0),
        ),
      );
    });
  }


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: AppColors.primary.withOpacity(0.1),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            /// map box
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
                              Text(
                                '* ',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.red,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                'Location name',
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
                            hintText: widget.locationNameText,
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

                          /// Address text
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
                                'Address',
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
                            keyboardType: TextInputType.name,
                            width: width,
                            hintText: widget.addressText,
                            isPrefixIcon: true,
                            prefixIcon: Padding(
                              padding: const EdgeInsets.only(
                                  left: 0.0, top: 10.0, bottom: 10.0),
                              child: SvgPicture.asset(AppImages.locationIcon,
                                  color: AppColors.black),
                            ),
                            padding: const EdgeInsets.only(top: 4.0),
                          ),
                          const SizedBox(height: 24.0),

                          /// make it public
                          const SizedBox(height: 16.0),
                          const Text(
                            'Make it public',
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
                                value: widget.status ?? false,
                                onToggle: (val) {
                                  setState(() {
                                    widget.status = val;
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
                              onTap: () {},
                              btnText: 'Delete this location',
                              borderColor: AppColors.primary,
                              fontColor: AppColors.primary,
                              btnColor: AppColors.primary.withOpacity(0.1),
                              width: width * 0.4,
                            ),
                          ),

                          /// map box
                          const SizedBox(height: 16.0),
                          //const MapBox(),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.3,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12.0),
                              child: GoogleMap(
                                onMapCreated: _onMapCreated,
                                liteModeEnabled: false,
                                myLocationEnabled: true,
                                myLocationButtonEnabled: true,
                                scrollGesturesEnabled: true,
                                rotateGesturesEnabled: true,
                                markers: _markers,
                                gestureRecognizers: Set()
                                  ..add(Factory<PanGestureRecognizer>(
                                      () => PanGestureRecognizer())),
                                circles: circles,
                                initialCameraPosition:  CameraPosition(
                                  target: LatLng(widget.latitude ?? 0, widget.longitude ?? 0),
                                  zoom: 7.5,
                                ),
                                onTap: (latlang) {
                                  setState(() {
                                    lat = latlang.latitude;
                                    long = latlang.longitude;
                                    _markers.add(
                                      Marker(
                                          markerId: MarkerId('id-1'),
                                          position: LatLng(latlang.latitude,
                                              latlang.longitude),
                                          infoWindow: InfoWindow(
                                              title: 'Title',
                                              snippet: "${latlang.latitude}" +
                                                  "${latlang.longitude}")),
                                    );
                                    circles.add(Circle(
                                      circleId: CircleId('id-1'),
                                      center: LatLng(
                                          latlang.latitude, latlang.longitude),
                                      radius: 3000,
                                      fillColor:
                                          AppColors.lightBlue.withOpacity(0.5),
                                      strokeWidth: 3,
                                      strokeColor: AppColors.lightBlue,
                                    ));
                                  });
                                },
                              ),
                            ),
                          ),

                          /// update and cancel button
                          const SizedBox(height: 24.0),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              CustomButton(
                                onTap: () {
                                  setState(() {
                                    Get.back();
                                  });
                                  _markers.clear();
                                  circles.clear();
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
                                onTap: () {
                                  Get.back();
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
