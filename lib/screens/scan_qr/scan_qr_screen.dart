import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:emedassistantmobile/config/app_colors.dart';
import 'package:emedassistantmobile/config/app_images.dart';

class ScanQrScreen extends StatefulWidget {
  const ScanQrScreen({Key? key}) : super(key: key);

  @override
  State<ScanQrScreen> createState() => _ScanQrScreenState();
}

class _ScanQrScreenState extends State<ScanQrScreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: Colors.black,
          statusBarIconBrightness: Brightness.light,
        )
    );
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      body: SafeArea(
        child: Stack(
          children: [
            Image.asset(AppImages.backTopImage),
            Padding(
              padding: const EdgeInsets.only(left: 40.0, right: 20.0, top: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(AppImages.eMedLogo, color: AppColors.white,
                      width: width * 0.3,
                      ),
                      const SizedBox(width: 16.0),
                      const Text('Your medical assistant solution',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: AppColors.white,
                      ),
                      ),
                    ],
                  ),

                  /// doctor name
                  const SizedBox(height: 20.0),
                  const Text('Dr. Imesha Basnayaka',
                    style: TextStyle(
                      fontSize: 28.0,
                      color: AppColors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 3.0),
                  const Text('Dermatologists - Pediatricians',
                    style: TextStyle(
                      fontSize: 10.0,
                      color: AppColors.white,
                    ),
                  ),

                  /// specialist
                  const SizedBox(height: 10.0),
                  const Text('Lady Ridgway',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: AppColors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 3.0),
                  const Text('Dr Mawatha, Colombo 0800, Sri Lanka',
                    style: TextStyle(
                      fontSize: 10.0,
                      color: AppColors.white,
                    ),
                  ),

                  /// qr code image
                  const SizedBox(height: 20.0),
                  Image.asset(AppImages.qrCodeImage,
                    width: width,
                    height: height * 0.44,
                    fit: BoxFit.fill,
                  ),

                  /// use camera text
                  const SizedBox(height: 20.0),
                  const Text('Use the camera of your mobile phone to scan the QRcode above '
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
                    child: Text('Powered by emedassistant.com',
                      style: TextStyle(
                        fontSize: 10.0,
                        color: AppColors.lightBlack,
                      ),
                    ),
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
