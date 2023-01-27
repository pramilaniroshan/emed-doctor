import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:universal_html/html.dart' as html;

import 'package:emedDoctor/config/app_colors.dart';
import 'package:emedDoctor/config/app_images.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/constants.dart';
import '../../controller/doctorController.dart';
import '../../widgets/drawer.dart';
import '../../widgets/user_avatar.dart';

class ScanQrScreen extends StatefulWidget {
  const ScanQrScreen({Key? key}) : super(key: key);

  @override
  State<ScanQrScreen> createState() => _ScanQrScreenState();
}

class _ScanQrScreenState extends State<ScanQrScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final DoctorController doctorController = Get.put(DoctorController());
  Uint8List? qrData;
  //Bitmap? bitmap;
  String? profile;

  html.Blob? blob;
  List<int>? list;
  var image;

  List Availability = [];
  late SharedPreferences prefs;

  void getQrCode(String id) async {
    print('Qr code');
    var prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token") ?? '';
    try {
      var dio = Dio();
      dio.options.headers["authorization"] = "Bearer " + token;

      await dio
          .get(
              Constants().getBaseUrl() +
                  '/Doctor/Availability/Qr?AvailabilityId=' +
                  id,
              options: Options(responseType: ResponseType.bytes))
          .then((res) {
        print(res);
        image = Image.memory(
          res.data,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.44,
          scale: 0.5,
        );
        setState(() {});
      });
    } on DioError catch (e) {
      print(e.response!.data);
    }
  }

  void checkAvai() async {
    print('Doctor Availability');
    prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token") ?? '';
    try {
      var dio = Dio();
      dio.options.headers["authorization"] = "Bearer " + token;
      await dio
          .get(Constants().getBaseUrl() + '/Doctor/Availability')
          .then((res) {
        Availability = res.data['Data']['Data'];

        if (Availability.isNotEmpty) {
          getQrCode(Availability[0]['Id']);
        }
      });
    } on DioError catch (e) {
      print(e.response!.data);
    }
  }

  @override
  void initState() {
    checkAvai();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
      statusBarIconBrightness: Brightness.light,
    ));
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
      body: SafeArea(
        child: Stack(
          children: [
            Image.asset(AppImages.backTopImage),
            //Text(blob. ?? 'QR code'),

            //Image.memory(image),
            Padding(
              padding:
                  const EdgeInsets.only(left: 40.0, right: 20.0, top: 12.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          AppImages.eMedLogo,
                          color: AppColors.white,
                          width: width * 0.3,
                        ),
                        const SizedBox(width: 16.0),
                        const Text(
                          'Your medical assistant solution',
                          style: TextStyle(
                            fontSize: 12.0,
                            color: AppColors.white,
                          ),
                        ),
                      ],
                    ),

                    /// doctor name
                    const SizedBox(height: 20.0),
                    //Image.memory(qrData!),
                    Text(
                      'Dr ' +
                          doctorController.firstName +
                          ' ' +
                          doctorController.lastName!,
                      style: const TextStyle(
                        fontSize: 28.0,
                        color: AppColors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 3.0),
                    Text(
                      doctorController.description!,
                      style: const TextStyle(
                        fontSize: 10.0,
                        color: AppColors.white,
                      ),
                    ),

                    /// specialist
                    const SizedBox(height: 10.0),
                    Text(
                      doctorController.address!,
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: AppColors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 3.0),
                    Text(
                      doctorController.address!,
                      style: const TextStyle(
                        fontSize: 10.0,
                        color: AppColors.white,
                      ),
                    ),

                    /// qr code image
                    image == null
                        ? SizedBox(height: height / 4)
                        : SizedBox(height: height / 6.5),
                    // Image.asset(
                    //   AppImages.qrCodeImage,
                    //   width: width,
                    //   height: height * 0.44,
                    //   fit: BoxFit.fill,
                    // ),
                    image == null
                        ? SizedBox(
                            height: MediaQuery.of(context).size.height / 5,
                            child: Center(
                              child: CircularProgressIndicator(
                                color: AppColors.secondary,
                                semanticsLabel: 'Loading...',
                                semanticsValue: 'Loading...',
                              ),
                            ),
                          )
                        : image,

                    /// use camera text
                    const SizedBox(height: 20.0),
                    const Text(
                      'Use the camera of your mobile phone to scan the QRcode above '
                      'to easily book an appointment.',
                      style: TextStyle(
                        fontSize: 13.0,
                        color: AppColors.lightBlack,
                      ),
                    ),

                    /// powered by text
                    const SizedBox(height: 20.0),
                    const Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Powered by emedassistant.com',
                        style: TextStyle(
                          fontSize: 10.0,
                          color: AppColors.lightBlack,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
