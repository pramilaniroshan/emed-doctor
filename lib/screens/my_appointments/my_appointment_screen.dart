
import 'package:emedassistantmobile/screens/auth/home/home_screen.dart';
import 'package:emedassistantmobile/screens/book_an_appointment/book_an_appointment_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

import 'package:emedassistantmobile/widgets/custom_button.dart';
import 'package:emedassistantmobile/config/app_colors.dart';
import 'package:emedassistantmobile/config/app_images.dart';

class MyAppointmentsScreen extends StatefulWidget {
  const MyAppointmentsScreen({Key? key}) : super(key: key);

  @override
  State<MyAppointmentsScreen> createState() => _MyAppointmentsScreenState();
}

class _MyAppointmentsScreenState extends State<MyAppointmentsScreen> {

  /// door rating dropdown items
  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(
          value: "All doctors", child: Text("All doctors"),),
      const DropdownMenuItem(value: "Imesha", child: Text("Imesha"),),
      const DropdownMenuItem(value: "Doctor 2", child: Text("Doctor 2"),),
      const DropdownMenuItem(value: "Doctor 3", child: Text("Doctor 3"),),
      const DropdownMenuItem(value: "Doctor 4", child: Text("Doctor 4")),
    ];
    return menuItems;
  }

  String selectedValue = "All doctors";

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool isPlanned = true;
  bool isPast = false;
  late SharedPreferences prefs;

  void planActive() {
    setState(() {
      isPlanned = true;
      isPast = false;
    });
  }

  void pastActive() {
    setState(() {
      isPlanned = false;
      isPast = true;
    });
  }

  void searchDoctor() async{
    print('Search Doctor');
    prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token") ?? '';
    print(token);
try {
  var dio = Dio();
  dio.options.headers["authorization"] = "Bearer " + token;
  await dio.get('https://localhost:5001/api/v1/Patient/SearchDoctor',
  
  ).then((res) {
    print(res.data);
  });
} on DioError catch (e) {
  // The request was made and the
  // server responded with a status code
  // that falls out of the range of 2xx and is also not 304.
  print(e.response!.statusCode);
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
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.lightBackground,

      /// app Bar
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

      /// end drawer
      endDrawer: Drawer(
        backgroundColor: AppColors.white,
        elevation: 0.0,
        child: endDrawerData(height),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [

            /// My Appointments texts
            const SizedBox(height: 24.0),
            const Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Text(
                'My appointment',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
                ),
              ),
            ),
            const SizedBox(height: 16.0),

            /// planned and past tab
            Padding(
              padding: const EdgeInsets.only(right: 16.0, left: 16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: planActive,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                      child: Text('Planned',
                        style: TextStyle(
                          fontSize: 15.0,
                          color: isPlanned == true ?  AppColors.black : AppColors.secondary,
                          fontWeight: isPlanned == true ? FontWeight.w600 : FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: pastActive,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                      child: Text('Past',
                        style: TextStyle(
                          fontSize: 15.0,
                          color: isPast == true ?  AppColors.black : AppColors.secondary,
                          fontWeight: isPast == true ? FontWeight.w600 : FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: Container(
                      height: 36.0,
                      padding: const EdgeInsets.only(left: 12.0, right: 6.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0),
                        color: AppColors.white,
                        border: Border.all(
                          width: 1.0,
                          color: AppColors.primary,
                        ),
                      ),
                      child: DropdownButton(
                        value: selectedValue,
                        items: dropdownItems,
                        hint: const Text(
                          'United Kingdom',
                          style: TextStyle(
                            color: AppColors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 14.0,
                          ),
                        ),
                        style: const TextStyle(
                          color: AppColors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 14.0,
                        ),
                        underline: const SizedBox(),
                        icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.primary, size: 20.0),
                        isExpanded: true,
                        onChanged: (String? value) {
                          setState(() {
                            selectedValue = value!;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /// planned texts and Book Button
            const SizedBox(height: 24.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Planned',
                    style: TextStyle(
                      fontSize: 24.0,
                      color: AppColors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Expanded(flex: 3,child: SizedBox(),),
                  Expanded(
                    flex: 2,
                    child: CustomButton(
                      onTap: (){
                        Get.to(const BookAnAppointmentScreen());
                      },
                      width: 80.0,
                      borderColor: AppColors.lightBlue,
                      btnText: "Book",
                      // child: Row(
                      //   crossAxisAlignment: CrossAxisAlignment.center,
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: const [
                      //     Icon(Icons.group_outlined, color: AppColors.white, size: 20.0),
                      //     SizedBox(width: 8.0),
                      //     Text('Book',
                      //       style: TextStyle(
                      //         fontSize: 15.0,
                      //         fontWeight: FontWeight.w500,
                      //         color: AppColors.white,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                    ),
                  ),
                ],
              ),
            ),

            /// detail Box
            const SizedBox(height: 16.0),
            // Container(
            //   width: width,
            //   padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            //   margin: const EdgeInsets.symmetric(horizontal: 16.0),
            //   decoration: BoxDecoration(
            //     border: Border.all(
            //       color: AppColors.lightBlue,
            //       width: 1.0,
            //     ),
            //     borderRadius: BorderRadius.circular(8.0),
            //     color: AppColors.white,
            //   ),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     mainAxisAlignment: MainAxisAlignment.start,
            //     children: [

            //       /// date and image row
            //       Row(
            //         crossAxisAlignment: CrossAxisAlignment.center,
            //         children: [
            //           Expanded(
            //             child: Column(
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               mainAxisAlignment: MainAxisAlignment.start,
            //               children: const [
            //                 Text('02 Jun 2022',
            //                   style: TextStyle(
            //                     fontSize: 14.0,
            //                     color: AppColors.black,
            //                     fontWeight: FontWeight.w500,
            //                   ),
            //                 ),
            //                 SizedBox(height: 4.0),
            //                 Text('13:15',
            //                   style: TextStyle(
            //                     fontSize: 24.0,
            //                     color: AppColors.black,
            //                     fontWeight: FontWeight.w600,
            //                   ),
            //                 ),
            //                 SizedBox(height: 4.0),
            //                 Text('16:15',
            //                   style: TextStyle(
            //                     fontSize: 20.0,
            //                     color: AppColors.primary,
            //                     fontWeight: FontWeight.w600,
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           ),
            //           const CircleAvatar(
            //             radius: 22.0,
            //             backgroundImage: AssetImage(AppImages.doctorImage),
            //           ),
            //         ],
            //       ),
            //       Divider(
            //         thickness: 1.0,
            //         color: AppColors.primary.withOpacity(0.4),
            //       ),

            //       /// name and specialists
            //       const SizedBox(height: 8.0),
            //       const Text('Doctor Name Doctor Name',
            //         style: TextStyle(
            //           fontSize: 24.0,
            //           color: AppColors.black,
            //           fontWeight: FontWeight.w500,
            //         ),
            //       ),
            //       const SizedBox(height: 4.0),
            //       const Text('Dermatologists - Pediatricians',
            //         style: TextStyle(
            //           fontSize: 12.0,
            //           color: AppColors.black,
            //           fontWeight: FontWeight.w500,
            //         ),
            //       ),

            //       /// location address center
            //       const SizedBox(height: 8.0),
            //       const Icon(Icons.location_on_outlined, color: AppColors.primary),
            //       const SizedBox(height: 2.0),
            //       RichText(
            //         text: const TextSpan(
            //           children: [
            //             TextSpan(
            //               text: 'Colombo Center - ',
            //               style: TextStyle(
            //                 fontSize: 16.0,
            //                 fontWeight: FontWeight.w600,
            //                 color: AppColors.black,
            //               ),
            //             ),
            //             TextSpan(
            //               text: 'Hospital St, Colombo 00100, Sri Lanka',
            //               style: TextStyle(
            //                 fontSize: 14.0,
            //                 fontWeight: FontWeight.w500,
            //                 color: AppColors.black,
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),

            //       /// brief description text
            //       const SizedBox(height: 16.0),
            //       const Text('Brief description of the purpose of the visit',
            //         style: TextStyle(
            //           fontSize: 12.0,
            //           color: AppColors.black,
            //           fontWeight: FontWeight.w500,
            //         ),
            //       ),
            //       const SizedBox(height: 10.0),
            //       Divider(
            //         thickness: 1.0,
            //         color: AppColors.primary.withOpacity(0.4),
            //       ),

            //       /// Calender and phone
            //       const SizedBox(height: 10.0),
            //       Row(
            //         crossAxisAlignment: CrossAxisAlignment.center,
            //         mainAxisAlignment: MainAxisAlignment.start,
            //         children: const [
            //           Icon(Icons.calendar_today_outlined, color: AppColors.primary, size: 20.0),
            //           SizedBox(width: 8.0),
            //           Text('M567854',
            //             style: TextStyle(
            //               fontSize: 20.0,
            //               color: AppColors.black,
            //               fontWeight: FontWeight.w600,
            //             ),
            //           ),
            //         ],
            //       ),
            //       Padding(
            //         padding: const EdgeInsets.symmetric(vertical: 2.0),
            //         child: CustomButton(
            //           onTap: (){},
            //           btnText: 'Add to my calender',
            //           height: 30.0,
            //           width: MediaQuery.of(context).size.width / 3,
            //           fontSize: 13.0,
            //         ),
            //       ),
            //       Row(
            //         crossAxisAlignment: CrossAxisAlignment.center,
            //         mainAxisAlignment: MainAxisAlignment.start,
            //         children: const [
            //           Icon(Icons.phone, color: AppColors.primary, size: 20.0),
            //           SizedBox(width: 8.0),
            //           Text('+94 779012345',
            //             style: TextStyle(
            //               fontSize: 16.0,
            //               color: AppColors.black,
            //               fontWeight: FontWeight.w500,
            //             ),
            //           ),
            //         ],
            //       ),
            //       const SizedBox(height: 10.0),
            //       Divider(
            //         thickness: 1.0,
            //         color: AppColors.primary.withOpacity(0.4),
            //       ),

            //       /// delete and edit button
            //       Row(
            //         crossAxisAlignment: CrossAxisAlignment.center,
            //         mainAxisAlignment: MainAxisAlignment.end,
            //         children: [
            //           Container(
            //             height: 42.0,
            //             width: 42.0,
            //             decoration: const BoxDecoration(
            //               shape: BoxShape.circle,
            //               color: AppColors.secondary,
            //             ),
            //             child: const Center(
            //               child: Icon(Icons.delete, color: AppColors.white, size: 18.0),
            //             ),
            //           ),
            //           const SizedBox(width: 16.0),
            //           Container(
            //             height: 42.0,
            //             width: 42.0,
            //             decoration: const BoxDecoration(
            //               shape: BoxShape.circle,
            //               color: AppColors.secondary,
            //             ),
            //             child: const Center(
            //               child: Icon(Icons.edit, color: AppColors.white, size: 18.0),
            //             ),
            //           ),
            //         ],
            //       ),
            //     ],
            //   ),
            // ),


            /// book and appointment button
            const SizedBox(height: 24.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: height * 0.1),
              child: CustomButton(
                onTap: (){
                  Get.to(const BookAnAppointmentScreen());
                },
                borderColor: AppColors.lightBlue,
                btnText: "Book an appointment",
                // child: Row(
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: const [
                //     Icon(Icons.group_outlined, color: AppColors.white, size: 20.0),
                //     SizedBox(width: 8.0),
                //     Text('Book an appointment',
                //       style: TextStyle(
                //         fontSize: 15.0,
                //         fontWeight: FontWeight.w500,
                //         color: AppColors.white,
                //       ),
                //     ),
                //   ],
                // ),
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
        onTap: () {
          searchDoctor();
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
        onTap: () async {
          prefs = await SharedPreferences.getInstance();
          print(prefs.getString("token"));
        },
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
        onTap: () async{
          prefs = await SharedPreferences.getInstance();
          prefs.clear();
          ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Logged out!'),
          backgroundColor: AppColors.lightBlue,
          ),
      );
          Get.to(const HomeScreen());
        },
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
            ' Log out',
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
          'Mrs.Imesha',
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
