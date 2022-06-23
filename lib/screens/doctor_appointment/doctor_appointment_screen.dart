import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:emedassistantmobile/config/app_colors.dart';
import 'package:emedassistantmobile/config/app_images.dart';
import '../../widgets/custom_button.dart';
import 'component/appoinment_dialog.dart';

class DoctorAppointmentScreen extends StatefulWidget {
  const DoctorAppointmentScreen({Key? key}) : super(key: key);

  @override
  State<DoctorAppointmentScreen> createState() => _DoctorAppointmentScreenState();
}

class _DoctorAppointmentScreenState extends State<DoctorAppointmentScreen> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  DatePickerController controller = DatePickerController();

  DateTime selectedValue = DateTime.now();

  @override
  Widget build(BuildContext context) {
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
        actions: [
          const CircleAvatar(
            radius: 14.0,
            backgroundImage: AssetImage(AppImages.doctorImage),
          ),
          const SizedBox(width: 8.0),
          const Center(
            child: Text('Lorem Arsh',
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w700,
              color: AppColors.lightBlack,
            ),
            ),
          ),
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
                onPressed: (){
                  Get.back();
                },
                icon: SvgPicture.asset(
                  AppImages.closeIcon,
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            ListTile(
              onTap: (){},
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
                child: Text('Support',
                  style: TextStyle(
                    fontSize: 21.0,
                    color: AppColors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            ListTile(
              onTap: (){},
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
                child: Text('Contact',
                  style: TextStyle(
                    fontSize: 21.0,
                    color: AppColors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            ListTile(
              onTap: (){},
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
                child: Text('Terms',
                  style: TextStyle(
                    fontSize: 21.0,
                    color: AppColors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            ListTile(
              onTap: (){},
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
                child: Text('eMed.com',
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
              onTap: (){},
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
                child: Text('English',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: AppColors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              trailing: const Icon(Icons.keyboard_arrow_down_outlined, color: AppColors.black),
            ),
          ],
        ),
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Text('Appointments',
            style: TextStyle(
              fontSize: 25.0,
              color: AppColors.black,
              fontWeight: FontWeight.w600,
            ),
            ),
          ),
          /// date text and today late button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Expanded(
                  child: Text('Wed 26 Jan 2022',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: AppColors.black,
                    fontWeight: FontWeight.w600,
                  ),
                  ),
                  flex: 2,
                ),
                Expanded(
                  child: CustomButton(
                    onTap: (){},
                    btnText: 'Today',
                    btnColor: AppColors.white,
                    borderColor: AppColors.primary,
                    width: 40.0,
                    fontColor: AppColors.primary,
                  ),
                ),
                const SizedBox(width: 24.0),
                Expanded(
                  child: CustomButton(
                    onTap: (){
                      Get.dialog(
                        const AppointmentDialog(),
                      );
                    },
                    btnText: 'Late',
                    width: 50.0,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: Container(
              color: AppColors.white,
              width: width,
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 40.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [

                    /// date picker timeline
                    DatePicker(
                      DateTime.now(),
                      width: 45,
                      height: 80,
                      controller: controller,
                      initialSelectedDate: DateTime.now(),
                      selectionColor: AppColors.redColor,
                      selectedTextColor: Colors.white,
                      inactiveDates: [
                        DateTime.now().add(const Duration(days: 3)),
                        //DateTime.now().add(Duration(days: 4)),
                        //DateTime.now().add(Duration(days: 7))
                      ],
                      onDateChange: (date) {
                        // New date selected
                        setState(() {
                          selectedValue = date;
                        });
                      },
                    ),
                    const SizedBox(height: 16.0),

                    Container(
                      width: width,
                      padding: const EdgeInsets.all(12.0),
                      margin: const EdgeInsets.symmetric(horizontal: 16.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        color: AppColors.lightBlue.withOpacity(0.1),
                        border: Border.all(
                          color: AppColors.lightBlue,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          timeNameRow(),
                          const SizedBox(height: 8.0),
                          const Divider(
                            color: AppColors.primary,
                            thickness: 0.5,
                          ),
                          const SizedBox(height: 16.0),
                          itemDetailRow(AppImages.calenderIcon, 'GT567ZX'),
                          const SizedBox(height: 10.0),
                          itemDetailRow(AppImages.calenderIcon, '4/7 booked'),
                          const SizedBox(height: 10.0),
                          itemDetailRow(AppImages.locationIcon, 'Room 6-205'),
                          const SizedBox(height: 10.0),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const [
                              CircleAvatar(
                                radius: 10.0,
                                backgroundImage: AssetImage(AppImages.doctorImage),
                              ),
                              SizedBox(width: 8.0),
                              Text('Lorem Ipsum Name',
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24.0),
                          Container(
                            width: width,
                            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(2.0),
                              border: Border.all(
                                color: AppColors.primary,
                                width: 0.5,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [

                                /// first Name Row
                                firstNameRow(),
                                const SizedBox(height: 16.0),
                                const Divider(
                                  color: AppColors.primary,
                                  thickness: 0.7,
                                ),

                                /// second Name Row
                                const SizedBox(height: 8.0),
                                firstNameRow(),
                                const SizedBox(height: 16.0),
                                const Divider(
                                  color: AppColors.primary,
                                  thickness: 0.7,
                                ),

                                /// available Row
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('Available',
                                      style: TextStyle(
                                        fontSize: 24.0,
                                        color: AppColors.primary,
                                      ),
                                      ),
                                      SvgPicture.asset(AppImages.editButtonIcon),
                                    ],
                                  ),
                                ),
                                const Divider(
                                  color: AppColors.primary,
                                  thickness: 0.7,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('Available',
                                        style: TextStyle(
                                          fontSize: 24.0,
                                          color: AppColors.primary,
                                        ),
                                      ),
                                      SvgPicture.asset(AppImages.editButtonIcon),
                                    ],
                                  ),
                                ),
                                const Divider(
                                  color: AppColors.primary,
                                  thickness: 0.7,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('Available',
                                        style: TextStyle(
                                          fontSize: 24.0,
                                          color: AppColors.primary,
                                        ),
                                      ),
                                      SvgPicture.asset(AppImages.editButtonIcon),
                                    ],
                                  ),
                                ),
                                const Divider(
                                  color: AppColors.primary,
                                  thickness: 0.7,
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
            ),
          ),
        ],
      ),
    );
  }

  Widget menuButton() => TextButton(
    onPressed: (){
      _scaffoldKey.currentState!.openEndDrawer();
    },
    child: const Icon(Icons.menu, color: AppColors.black, size: 28.0),
  );

  Widget itemDetailRow(iconPath, text) => Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      SvgPicture.asset(iconPath, color: AppColors.primary),
      const SizedBox(width: 12.0),
      Text(text,
        style: const TextStyle(
          fontSize: 15.0,
          color: AppColors.black,
          fontWeight: FontWeight.w700,
        ),
      ),
    ],
  );

  Widget timeNameRow() => Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            Text('13:15',
              style: TextStyle(
                fontSize: 20.0,
                color: AppColors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8.0),
            Text('16:15',
              style: TextStyle(
                fontSize: 17.0,
                color: AppColors.primary,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
      SvgPicture.asset(AppImages.deleteDisableIcon),
      const SizedBox(width: 16.0),
      SvgPicture.asset(AppImages.editButtonIcon),
    ],
  );

  Widget firstNameRow() => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text('Mr. Pramila Niroshan',
              style: TextStyle(
                fontSize: 20.0,
                color: AppColors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12.0),
            const Text('Brief description of the purpose of the visit',
              style: TextStyle(
                fontSize: 13.0,
                color: AppColors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 12.0),
            const Text('M567854',
              style: TextStyle(
                fontSize: 18.0,
                color: AppColors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Text('tel. ',
                  style: TextStyle(
                    fontSize: 15.0,
                    color: AppColors.lightBlack,
                  ),
                ),
                Text('+86527362837',
                  style: TextStyle(
                    fontSize: 15.0,
                    color: AppColors.secondary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Text('email ',
                  style: TextStyle(
                    fontSize: 15.0,
                    color: AppColors.lightBlack,
                  ),
                ),
                Text('abcd@gamil.com',
                  style: TextStyle(
                    fontSize: 15.0,
                    color: AppColors.secondary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SvgPicture.asset(AppImages.arrivedIcon),
          const SizedBox(height: 12.0),
          SvgPicture.asset(AppImages.deleteDisableIcon),
        ],
      ),
    ],
  );
}
