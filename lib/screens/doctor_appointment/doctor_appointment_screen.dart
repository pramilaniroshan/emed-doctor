import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:emedDoctor/controller/doctorController.dart';
import 'package:emedDoctor/screens/calendar/component/plannerAdd.dart';
import 'package:emedDoctor/widgets/drawer.dart';
import 'package:emedDoctor/widgets/user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

import 'package:emedDoctor/config/app_colors.dart';
import 'package:emedDoctor/config/app_images.dart';
import '../../config/constants.dart';
import '../../services/get_doctor_profile.dart';
import '../../widgets/custom_button.dart';
import '../auth/home/home_screen.dart';
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
  final DoctorController doctorController = Get.put(DoctorController());

  List Availability = [];
  num TotalSlotsCount = 0;
  num TotalBookedSlotsCount = 0;

  List<String> status = [
    'Active',
    'UnPaid',
    'Paid',
    'Cancelled',
    'Over',
    'InProgress',
  ];

  String selectedState = 'Active';

  Future<String> waitTask() async {
    await Future.delayed(const Duration(seconds: 10));
    return 'completed';
  }

  void getApp() async {
    print('Doctor Appointments');
    print(Constants().getBaseUrl() +
            '/Doctor/Appointment?Statuses=' +
            status.indexOf(selectedState).toString());

    prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token") ?? '';
    print(token);
    try {
      var dio = Dio();
      dio.options.headers["authorization"] = "Bearer " + token;
      await dio
          .get(
        Constants().getBaseUrl() +
            '/Doctor/Appointment?Statuses=' +
            status.indexOf(selectedState).toString(),
      )
          .then((res) {
        setState(() {
          EasyLoading.dismiss();
          Appointments = res.data['Data']['Data'];
        });
        // print(res.data);
      });
    } on DioError catch (e) {
      print(e.response!.data);
      print('login error');
      if (e.response!.statusCode == 401) {
        prefs = await SharedPreferences.getInstance();
        prefs.clear();
        EasyLoading.showInfo('Auto sign out');
        Get.off(const HomeScreen());
      }
      if (e.response!.statusCode == 403) {
        EasyLoading.showInfo('Doctor not verifed yet. Auto sign off in 5s');
        var result =
            await waitTask().timeout(const Duration(seconds: 5), onTimeout: () {
          prefs.clear();
          EasyLoading.showInfo('Auto sign out');
          Get.off(const HomeScreen());
          return 'login out';
        });
        print(result);
      }
    }
  }

  cancelApp(String id) async {
    prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token") ?? '';
    try {
      var dio = Dio();
      dio.options.headers["authorization"] = "Bearer " + token;
      await dio
          .post(Constants().getBaseUrl() + '/Doctor/CancelAppointment', data: {
        "AppointmentId": id,
      }).then((res) {
        setState(() {});
        EasyLoading.showSuccess(' Appointment canceled');
      });
    } on DioError catch (e) {
      EasyLoading.showError('Something went wrong');
      print(e.response!.data);
    }
  }

  markAppointmentInProgress(String id) async {
    String token = prefs.getString("token") ?? '';
    try {
      var dio = Dio();
      dio.options.headers["authorization"] = "Bearer " + token;
      await dio
          .post(Constants().getBaseUrl() + '/Doctor/MarkAppointmentInProgress', data: {
        "AppointmentId": id,
      }).then((res) {
        setState(() {});
        EasyLoading.showSuccess(' Appointment In Progress');
      });
    } on DioError catch (e) {
      EasyLoading.showError('Something went wrong');
      print(e.response!.data);
    }
  }

    markAppointmentComplete(String id) async {
    String token = prefs.getString("token") ?? '';
    try {
      var dio = Dio();
      dio.options.headers["authorization"] = "Bearer " + token;
      await dio
          .post(Constants().getBaseUrl() + '/Doctor/MarkAppointmentComplete', data: {
        "AppointmentId": id,
      }).then((res) {
        setState(() {});
        EasyLoading.showSuccess(' Appointment Complete');
      });
    } on DioError catch (e) {
      EasyLoading.showError('Something went wrong');
      print(e.response!.data);
    }
  }

  void checkAvai(String date) async {
    print('Doctor Availability');
    prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token") ?? '';
    try {
      var dio = Dio();
      dio.options.headers["authorization"] = "Bearer " + token;
      await dio
          .get(
        Constants().getBaseUrl() + '/Doctor/Availability?StartTime=' + date,
      )
          .then((res) {
        Availability = res.data['Data']['Data'];
        calcBookedSlots();
      });
    } on DioError catch (e) {
      print(e.response!.data);
    }
  }

  void calcBookedSlots() {
    Availability!.forEach((element) => {
          //print(element['TotalBookedSlotsCount'])

          setState(() {
            TotalBookedSlotsCount =
                TotalBookedSlotsCount + element['TotalBookedSlotsCount'];
            TotalSlotsCount = TotalSlotsCount + element['TotalSlotsCount'];
          })
        });
  }

  // @override
  // void didChangeDependencies() {
  //   //super.didChangeDependencies();
  //   getApp();
  //   print('change');
  // }

  @override
  void initState() {
    super.initState();
    getDoctorProfile();
    getApp();
    checkAvai(selectedValue.toString());
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
          DoctorDrawerAction(),
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
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: AppColors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  flex: 2,
                ),
                Expanded(
                  // child: CustomButton(
                  //   onTap: () {
                  //     //Get.dialog(PlannerAddDialog(DateTime.now()));
                  //     //doctorController.setFirstname('Niroshan');
                  //   },
                  //   btnText: 'Today',
                  //   btnColor: AppColors.white,
                  //   borderColor: AppColors.primary,
                  //   width: 40.0,
                  //   fontColor: AppColors.primary,
                  // ),
                  child: DropdownButton2(
                    icon: const Icon(Icons.keyboard_arrow_down),
                    hint: const Text(
                      'Active',
                      style: TextStyle(
                        fontSize: 13.0,
                        color: AppColors.lightBlack,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    items: status
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
                    value: selectedState,
                    onChanged: (value) {
                      EasyLoading.show();
                      setState(() {
                        selectedState = value as String;
                      });
                      getApp();
                    },
                    buttonHeight: 40,
                    buttonWidth: 100,
                    itemHeight: 36.0,
                    dropdownWidth: 115,
                    buttonPadding: const EdgeInsets.symmetric(horizontal: 1.0),
                    dropdownDecoration: const BoxDecoration(
                      color: AppColors.lightBackground,
                    ),
                  ),
                ),
                const SizedBox(width: 40.0),
                Expanded(
                  child: CustomButton(
                    onTap: () {
                      Get.dialog(
                        AppointmentDialog(Appointments),
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
                padding: const EdgeInsets.only(bottom: 60.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    /// date picker timeline
                    DatePicker(
                      DateTime.now(),
                      width: 50,
                      height: 100,
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
                          TotalBookedSlotsCount = 0;
                          TotalSlotsCount = 0;
                        });
                        checkAvai(selectedValue.toString());
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
                          const SizedBox(height: 15.0),
                          const Divider(
                            color: AppColors.primary,
                            thickness: 0.5,
                          ),
                          const SizedBox(height: 16.0),
                          itemDetailRow(AppImages.calenderIcon, 'GT567ZX'),
                          const SizedBox(height: 10.0),
                          itemDetailRow(
                              AppImages.calenderIcon,
                              TotalBookedSlotsCount.toString().split('.')[0] +
                                  '/' +
                                  TotalSlotsCount.toString().split('.')[0] +
                                  ' booked'),
                          const SizedBox(height: 10.0),
                          itemDetailRow(AppImages.locationIcon, 'Room 6-205'),
                          const SizedBox(height: 10.0),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              // const CircleAvatar(
                              //   radius: 10.0,
                              //   backgroundImage:
                              //       AssetImage(AppImages.doctorImage),
                              // ),
                              // const SizedBox(width: 8.0),
                              // GetBuilder<DoctorController>(
                              //   builder: (s) => Text(
                              //     s.firstName,
                              //     style: const TextStyle(
                              //       fontSize: 15.0,
                              //       color: AppColors.black,
                              //       fontWeight: FontWeight.w700,
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                          const SizedBox(height: 24.0),
                          Container(
                            // width: width,
                            // padding: const EdgeInsets.symmetric(
                            //     horizontal: 8.0, vertical: 16.0),
                            // decoration: BoxDecoration(
                            //   color: AppColors.white,
                            //   borderRadius: BorderRadius.circular(2.0),
                            //   border: Border.all(
                            //     color: AppColors.primary,
                            //     width: 0.5,
                            //   ),
                            // ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                //Name row
                                Appointments.isEmpty
                                    ? Center(child: Lottie.network('https://assets3.lottiefiles.com/private_files/lf30_mb1rkenn.json'))
                                    : Column(
                                        children: List.generate(
                                        Appointments.length,
                                        (index) => signleApp(
                                          Appointments[index]['Id'],
                                          Appointments[index]['Patient']
                                                      ['FirstName'] +
                                                  ' ' +
                                                  Appointments[index]['Patient']
                                                      ['LastName'] ??
                                              '',
                                          Appointments[index]['PatientNotes'] ??
                                              '',
                                          Appointments[index]['Patient']
                                                  ['PhoneNumber'] ??
                                              '',
                                          Appointments[index]['Patient']
                                                  ['Email'] ??
                                              '',
                                        ),
                                      )),
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
          Image.asset(
            AppImages.deleteDisableIcon,
            width: 40,
            height: 40,
          ),
          const SizedBox(width: 16.0),
          //SvgPicture.asset(AppImages.editButtonIcon),
          Image.asset(
            AppImages.editButtonIcon,
            width: 40,
            height: 40,
          ),
        ],
      );

  Widget signleApp(String id, String name, String des, String phoneNumber,
          String email) =>
      Container(
        margin: const EdgeInsets.only(bottom: 5.0),
        //padding: const EdgeInsets.only(bottom: 40.0),

        // width: width,
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(
            color: AppColors.primary,
            width: 0.5,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 20.0,
                      color: AppColors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  Text(
                    des,
                    style: const TextStyle(
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        'tel. ',
                        style: TextStyle(
                          fontSize: 15.0,
                          color: AppColors.lightBlack,
                        ),
                      ),
                      Text(
                        phoneNumber,
                        style: const TextStyle(
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
                      const Text(
                        'email ',
                        style: TextStyle(
                          fontSize: 15.0,
                          color: AppColors.lightBlack,
                        ),
                      ),
                      Text(
                        email,
                        style: const TextStyle(
                          fontSize: 15.0,
                          color: AppColors.secondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    child: SvgPicture.asset(AppImages.arrivedIcon),
                    onTap: () => {Get.defaultDialog(
                          title: "Are you sure?",
                          textConfirm: "Confirm",
                          textCancel: "Cancel",
                          radius: 16,
                          middleText: 'Complete Appointment',
                          buttonColor: AppColors.secondary,
                          onConfirm: () => {markAppointmentComplete(id), Get.back()}),},
                  ),
                  SizedBox(height: 12.0),
                  InkWell(
                    child: Image(image: AssetImage(AppImages.userGreen)),
                    onTap: () => {
                      Get.defaultDialog(
                          title: "Are you sure?",
                          textConfirm: "Confirm",
                          textCancel: "Cancel",
                          radius: 16,
                          middleText: 'Start Appointment',
                          buttonColor: AppColors.secondary,
                          onConfirm: () => {markAppointmentInProgress(id), Get.back()}),
                    },
                  ),
                  SizedBox(height: 12.0),
                  InkWell(
                    child: Image(image: AssetImage(AppImages.deleteBlue)),
                    onTap: () => {
                      Get.defaultDialog(
                          title: "Are you sure?",
                          textConfirm: "Confirm",
                          textCancel: "Cancel",
                          radius: 16,
                          middleText: 'Cancel Appointment',
                          buttonColor: AppColors.secondary,
                          onConfirm: () => {cancelApp(id), Get.back()}),
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
