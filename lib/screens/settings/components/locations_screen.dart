import 'package:dio/dio.dart';
import 'package:emedDoctor/screens/settings/components/widgets/location_edit.dart';
import 'package:emedDoctor/screens/settings/components/widgets/map_box.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';

import 'package:emedDoctor/config/app_colors.dart';
import 'package:emedDoctor/config/app_images.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../config/constants.dart';
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
  bool isAdd = false;

  List locations = [];

  double? lat;
  double? long;

  final Set<Marker> _markers = {};
  Set<Circle> circles = {};

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _markers.add(
        const Marker(
          markerId: MarkerId('id-1'),
          position: LatLng(6.9271, 79.8612),
        ),
      );
    });
  }

  void getLocations() async {
    var prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token") ?? '';

    try {
      var dio = Dio();
      dio.options.headers["authorization"] = "Bearer " + token;
      await dio
          .get(
        Constants().getBaseUrl() + '/Doctor/Location',
      )
          .then((res) {
        setState(() {
          locations = res.data['Data']['Data'];
        });
      });
    } on DioError catch (e) {
      print(e.response!.data['Error']);
    }
  }

  void addLocation() async {
    var prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token") ?? '';

    try {
      EasyLoading.show();
      var dio = Dio();
      dio.options.headers["authorization"] = "Bearer " + token;
      await dio.post(Constants().getBaseUrl() + '/Doctor/Location', data: {
        "LocationName": locationNameController.text,
        "LocationAddress": addressController.text,
        "Latitude": lat,
        "Longitude": long,
        "IsPublic": status
      }).then((res) {
        EasyLoading.dismiss();
        _markers.clear();
        circles.clear();
        setState(() {
          isAdd = false;
        });
        EasyLoading.showSuccess("New Location added");
        getLocations();
      });
    } on DioError catch (e) {
      print(e.response!.data['Error']);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocations();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: width,
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 24.0),
          margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(4.0),
          ),
          // child: isEdit == false ? Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   children: [
          //     const Text('Your Professional Locations',
          //       style: TextStyle(
          //         fontSize: 18.0,
          //         color: AppColors.black,
          //         fontWeight: FontWeight.bold,
          //       ),
          //     ),
          //     const SizedBox(height: 32.0),
          //     ProLocationWidget(
          //       onTap: (){
          //         setState(() {
          //           isEdit = true;
          //         });
          //       },
          //       locationNameText: 'Colombo center',
          //       addressText: 'Hospital St, Colombo 00100, Sri Lanka',
          //     ),

          //     const SizedBox(height: 20.0),
          //     Align(
          //       alignment: Alignment.centerRight,
          //       child: CustomButton(
          //         onTap: (){},
          //         btnText: 'Add new location',
          //         height: 40.0,
          //         width: width * 0.4,
          //         btnColor: AppColors.secondary,
          //         fontColor: AppColors.white,
          //         borderColor: AppColors.secondary,
          //         radius: 6.0,
          //       ),
          //     ),

          //   ],
          // ) :

          child: isAdd == false
              ? Column(
                  children: [
                    //Name row
                    const Text(
                      'Your Professional Locations',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: AppColors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    locations.isEmpty
                        ? const Center(child: Text('No locations'))
                        : Column(
                            children: List.generate(
                            locations.length,
                            (index) => ProLocationWidget(
                              onTap: () {
                                setState(() {
                                  isEdit = true;
                                });
                                Get.defaultDialog(
                                  
                                    title: "Edit " +
                                        locations[index]['LocationName'],
                                    content: Expanded(
                                      child: EditLocationWidget(
                                        locationNameText: locations[index]
                                            ['LocationName'],
                                        addressText: locations[index]
                                            ['LocationAddress'],
                                        latitude: locations[index]['Latitude'],
                                        longitude: locations[index]['Longitude'],
                                        status: locations[index]['IsPublic'],
                                      ),
                                    ));
                                //Get.to(EditLocationWidget());
                              },
                              locationNameText: locations[index]
                                  ['LocationName'],
                              addressText: locations[index]['LocationAddress'],
                              latitude: locations[index]['Latitude'],
                              longitude: locations[index]['Longitude'],
                            ),
                          )),
                    const SizedBox(height: 16.0),
                    const Divider(
                      color: AppColors.primary,
                      thickness: 0.7,
                    ),
                    Align(
                        alignment: Alignment.centerRight,
                        child: CustomButton(
                          onTap: () {
                            setState(() {
                              isAdd = true;
                            });
                          },
                          btnText: 'Add new location',
                          height: 40.0,
                          width: width * 0.4,
                          btnColor: AppColors.secondary,
                          fontColor: AppColors.white,
                          borderColor: AppColors.secondary,
                          radius: 6.0,
                        )),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      'Add Location',
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
                            hintText: 'Colombo Center',
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
                            hintText: 'Hospital St, Colombo 00100, Sri Lanka',
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
                                initialCameraPosition: const CameraPosition(
                                  target: LatLng(7.93, 80.8612),
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
                                    isAdd = false;
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
                                  addLocation();
                                },
                                btnText: 'Add',
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
      ),
    );
  }
}
