import 'package:emedassistantmobile/widgets/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

import 'package:emedassistantmobile/config/app_colors.dart';
import 'package:emedassistantmobile/config/app_images.dart';

class PatientBookingScreen extends StatefulWidget {

   final String? timeSlotText;
  final String id;
  final int? consultationFee;
  final String? doctorFullName;

  const PatientBookingScreen(
    this.timeSlotText,
    this.consultationFee,
    this.doctorFullName,
    this.id,
    {Key? key}) : super(key: key);

  @override
  State<PatientBookingScreen> createState() => _PatientBookingScreenState();
}



class _PatientBookingScreenState extends State<PatientBookingScreen> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController descController = TextEditingController();
  late SharedPreferences prefs;


  void makeApp() async {
    print('Make App');
    prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token") ?? '';
    try {
      var dio = Dio();
      dio.options.headers["authorization"] = "Bearer " + token;
      await dio.post(
          'https://localhost:5001/api/v1/Patient/Appointment',data :
        {
  "DoctorAvailabilityId": widget.id,
  "Time": widget.timeSlotText,
  "PatientNotes": descController.text,
} ).then((res) {
            print(res.data);
        setState(() {
          
        });
        print(res.data);
      });
    } on DioError catch (e) {
      // The request was made and the
      // server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      print(e.response!.data);
      // if (e.response != null) {
      //  // print(e);
      // } else {
      //   // Something happened in setting up or sending the request that triggered an Error
      //   //print(e);
      //   //print(e);
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    //String doctorFullName = '';
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
        actions: [
          menuButton(),
        ],
      ),
      endDrawer: Drawer(
        backgroundColor: AppColors.white,
        elevation: 0.0,
        child: endDrawerData(height),
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 24.0),
            const Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Text(
                'Book and appointment',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w600,
                  color: AppColors.black,
                ),
              ),
            ),
            const SizedBox(height: 24.0),

            /// Back to search box
            Container(
              width: width,
              padding: const EdgeInsets.symmetric(vertical: 18.0),
              decoration: BoxDecoration(
                color: AppColors.white,
                border: Border(
                  top: BorderSide(
                    color: AppColors.lightBlack.withOpacity(0.5),
                    width: 1.0,
                  ),
                  bottom: BorderSide(
                    color: AppColors.lightBlack.withOpacity(0.5),
                    width: 1.0,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: Text(
                      'Back to search result',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w700,
                        color: AppColors.secondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /// Doctor Details
            const SizedBox(height: 16.0),
            Container(
              width: width,
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
              margin: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: AppColors.white,
                border: Border.all(
                  color: AppColors.lightBlue,
                  width: 1.0,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [

                  /// Doctor name and image
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(width: 8.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children:  [
                            Text(widget.doctorFullName ?? '',
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                                color: AppColors.secondary,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            SizedBox(height: 6.0),
                            Text('Lorem Ipsum - Lorem Ipsum',
                              style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.w500,
                                color: AppColors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const CircleAvatar(
                        radius: 20.0,
                        backgroundImage: AssetImage(AppImages.doctorImage),
                      ),
                    ],
                  ),

                  /// Divider
                  const SizedBox(height: 4.0),
                  const Divider(
                    color: AppColors.primary,
                    thickness: 0.5,
                  ),
                  const SizedBox(height: 12.0),

                  /// date time slot row
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(Icons.calendar_today, color: AppColors.primary, size: 20.0),
                        const SizedBox(width: 8.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              RichText(
                                text:  TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Tuesday, ',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        color: AppColors.black,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    TextSpan(
                                      text: '12 Apr ',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        color: AppColors.black,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    TextSpan(
                                      text: widget.timeSlotText,
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        color: AppColors.black,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Text('6° slot',
                                style: TextStyle(
                                  fontSize: 22.0,
                                  color: AppColors.secondary,
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// cost row
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 12.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(CupertinoIcons.money_dollar_circle, color: AppColors.primary, size: 20.0),
                        const SizedBox(width: 8.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              RichText(
                                text:  TextSpan(
                                  children: [
                                    TextSpan(
                                      text: '\$ ',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        color: AppColors.black,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    TextSpan(
                                      text: '${widget.consultationFee}',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        color: AppColors.black,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'total cost ',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        color: AppColors.black,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// location row
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 12.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(CupertinoIcons.location, color: AppColors.primary, size: 20.0),
                        const SizedBox(width: 8.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              RichText(
                                text: const TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Colombo Center ',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        color: AppColors.black,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    TextSpan(
                                      text: '- Hospital St, Colombo 00100, Sri Lanka',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        color: AppColors.black,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// add description field
                  const SizedBox(height: 32.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text('Please add a brief description about the reason for the visit',
                    style: TextStyle(
                      fontSize: 15.0,
                      color: AppColors.black.withOpacity(0.8),
                      fontWeight: FontWeight.w500,
                    ),
                    ),
                  ),
                  const SizedBox(height: 12.0),

                  /// text field
                  Container(
                    width: width,
                    margin: const EdgeInsets.symmetric(horizontal: 16.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.primary,
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(2.0),
                    ),
                    child: TextFormField(
                      maxLines: 6,
                      keyboardType: TextInputType.text,
                      controller: descController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 16.0, top: 12.0),
                      ),
                    ),
                  ),

                  const SizedBox(height: 32.0),

                  /// cancel confirm button

                  Container(
                    width: width,
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    decoration: BoxDecoration(
                      color: AppColors.secondary.withOpacity(0.4),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomButton(
                          onTap: (){},
                          btnColor: AppColors.white,
                          fontColor: AppColors.black,
                          btnText: 'Cancel',
                          width: 85.0,
                          height: 36.0,
                          borderColor: AppColors.lightBackground,
                        ),
                        const SizedBox(width: 12.0),
                        CustomButton(
                          onTap: (){
                            makeApp();
                          },
                          btnText: 'Confirm',
                          width: 85.0,
                        ),
                        const SizedBox(width: 16.0),
                      ],
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

  Widget endDrawerData(height) => Column(
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
  );

  Widget menuButton() => TextButton(
    onPressed: () {
      _scaffoldKey.currentState!.openEndDrawer();
    },
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: const [
        Text(
          'Mr. Abcdjajd',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
            color: AppColors.black,
          ),
        ),
        SizedBox(width: 12.0),
        Icon(Icons.menu, color: AppColors.black, size: 28.0),
        SizedBox(width: 12.0),
      ],
    ),
  );
}
