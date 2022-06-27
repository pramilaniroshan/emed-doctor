import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:emedassistantmobile/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

import 'package:emedassistantmobile/config/app_colors.dart';
import 'package:emedassistantmobile/config/app_images.dart';
import '../../widgets/custom_button.dart';
import 'component/appoinment_dialog.dart';

class DoctorAppointmentScreen extends StatefulWidget {
  const DoctorAppointmentScreen({Key? key}) : super(key: key);

  @override
  State<DoctorAppointmentScreen> createState() =>
      _DoctorAppointmentScreenState();
}

class _DoctorAppointmentScreenState extends State<DoctorAppointmentScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  DatePickerController controller = DatePickerController();

  DateTime selectedValue = DateTime.now();

  late SharedPreferences prefs;

  List Appointments = [];
  String DoctorFirstName = '';

  void GetDoctorProfile() async {
    print('Doctor Profile');
    prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token") ?? '';
    try {
      var dio = Dio();
      dio.options.headers["authorization"] = "Bearer " + token;
      await dio
          .get(
        'https://localhost:5001/api/v1/Doctor',
      )
          .then((res) {
        setState(() {
          DoctorFirstName = res.data['Data']['FirstName'];
        });
        prefs.setString('FirstName', res.data['Data']['FirstName']);
        prefs.setString('Id', res.data['Data']['Id']);
        prefs.setString('Title', res.data['Data']['Title']);
        prefs.setString('LastName', res.data['Data']['LastName']);
        prefs.setString('NationalIdentificationNumber', res.data['Data']['NationalIdentificationNumber']);
        prefs.setString('Address', res.data['Data']['Address']);
        prefs.setString('GovDoctorRegNo', res.data['Data']['GovDoctorRegNo']);
        prefs.setString('NicFrontPicUrl', res.data['Data']['NicFrontPicUrl']);
        prefs.setString('NicBackPicUrl', res.data['Data']['NicBackPicUrl']);
        prefs.setString('GovDoctorIdentityPicFrontUrl', res.data['Data']['GovDoctorIdentityPicFrontUrl']);
        prefs.setString('GovDoctorIdentityPicBackUrl', res.data['Data']['GovDoctorIdentityPicBackUrl']);
        prefs.setString('VerifiedDate', res.data['Data']['VerifiedDate']);
        prefs.setString('VerifiedById', res.data['Data']['VerifiedById']);
        prefs.setString('PhoneNumber', res.data['Data']['PhoneNumber']);
        prefs.setString('Email', res.data['Data']['Email']);
        prefs.setString('Description', res.data['Data']['Description']);
        //prefs.setString('DoctorSpecializations', res.data['Data']['DoctorSpecializations']);
        prefs.setBool('IsVerified', res.data['Data']['IsVerified']);
        prefs.setBool('IsActive', res.data['Data']['IsActive']);
        prefs.setBool('IsPhoneNumberVerified', res.data['Data']['IsPhoneNumberVerified']);
        prefs.setBool('IsEmailVerified', res.data['Data']['IsEmailVerified']);
        prefs.setBool('PhoneNumberVisibleToPatient', res.data['Data']['PhoneNumberVisibleToPatient']);
        prefs.setInt('CityId', res.data['Data']['CityId'] ?? 0);
        print(prefs.getString('token'));
      });
    } on DioError catch (e) {
      print(e.response!.data);
    }
  }

  void getApp() async {
    print('Doctor Appointments');
    prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token") ?? '';
    try {
      var dio = Dio();
      dio.options.headers["authorization"] = "Bearer " + token;
      await dio
          .get(
        'https://localhost:5001/api/v1/Doctor/Appointment',
      )
          .then((res) {
        setState(() {
          Appointments = res.data['Data']['Data'];
        });
        //print(Appointments[3]['Patient']['LastName']);
      });
    } on DioError catch (e) {
      print(e.response!.data);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GetDoctorProfile();
    getApp();
    print(selectedValue);
  }

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
          Center(
            child: Text(
              DoctorFirstName,
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
      endDrawer: DoctorDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Text(
              'Appointments',
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
                Expanded(
                  child: Text(
                    DateFormat.yMMMMd('en_US').format((DateTime.now())),
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
                    onTap: () {},
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
                    onTap: () {
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
                        print(selectedValue);
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
                            children: [
                              CircleAvatar(
                                radius: 10.0,
                                backgroundImage:
                                    AssetImage(AppImages.doctorImage),
                              ),
                              SizedBox(width: 8.0),
                              Text(
                                DoctorFirstName,
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
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 16.0),
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
                                //Name row
                                Appointments.isEmpty
                                    ? Center(child: CircularProgressIndicator())
                                    : Column(
                                        children: List.generate(
                                            Appointments.length,
                                            (index) => SignleApp(
                                                Appointments[index]
                                                    ['Patient']['LastName'] ?? '',
                                                Appointments[index]
                                                    ['PatientNotes'] ?? '',
                                                    Appointments[index]
                                                    ['Patient']['PhoneNumber'] ?? '',
                                                    Appointments[index]
                                                    ['Patient']['Email'] ?? '',
                                                    ))),
                                const SizedBox(height: 16.0),
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
        onPressed: () {
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
          Text(
            text,
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
                Text(
                  '13:15',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: AppColors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  '16:15',
                  style: TextStyle(
                    fontSize: 17.0,
                    color: AppColors.primary,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          //SvgPicture.asset(AppImages.deleteDisableIcon),
          Image.asset(AppImages.deleteDisableIcon,
          width: 40,
          height: 40,
          ),
          const SizedBox(width: 16.0),
          //SvgPicture.asset(AppImages.editButtonIcon),
          Image.asset(AppImages.editButtonIcon,
          width: 40,
          height: 40,
          ),
        ],
      );

  Widget SignleApp(String name, String des, String phoneNumber, String email) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: AppColors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 12.0),
                Text(
                  des,
                  style: TextStyle(
                    fontSize: 13.0,
                    color: AppColors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 12.0),
                const Text(
                  'M567854',
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
                  children:  [
                    Text(
                      'tel. ',
                      style: TextStyle(
                        fontSize: 15.0,
                        color: AppColors.lightBlack,
                      ),
                    ),
                    Text(
                      phoneNumber,
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
                  children: [
                    Text(
                      'email ',
                      style: TextStyle(
                        fontSize: 15.0,
                        color: AppColors.lightBlack,
                      ),
                    ),
                    Text(
                      email,
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
