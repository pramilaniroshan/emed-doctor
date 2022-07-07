import 'package:emedassistantmobile/config/app_colors.dart';
import 'package:emedassistantmobile/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'package:emedassistantmobile/screens/doctor_appointment/component/appoinment_dialog.dart';

import '../../config/app_images.dart';

class CalendarScreen extends StatelessWidget {
  CalendarScreen({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
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
            child: Text(
              'Name',
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w700,
                color: AppColors.lightBlack,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              _scaffoldKey.currentState!.openEndDrawer();
            },
            child: const Icon(Icons.menu, color: AppColors.black, size: 28.0),
          ),
        ],
      ),
      endDrawer: DoctorDrawer(),
      body: Row(children: [
        SfCalendar(
          //backgroundColor: AppColors.lightBackground,
          view: CalendarView.week,
          timeSlotViewSettings:
              const TimeSlotViewSettings(allDayPanelColor: AppColors.redColor),
          allowedViews: const <CalendarView>[
            CalendarView.day,
            CalendarView.week,
            CalendarView.workWeek,
            CalendarView.month,
            CalendarView.schedule
          ],
          onTap: (CalendarTapDetails details) {
            DateTime date = details.date!;
            if (details.appointments != null) {
              Get.dialog(const AppointmentDialog());
            }
            print(date);
          },
          dataSource: MeetingDataSource(getAppointments()),
        ),
      ]),
    );
  }
}

List<Appointment> getAppointments() {
  List<Appointment> meetings = <Appointment>[];
  final DateTime today = DateTime.now();
  final DateTime startTime =
      DateTime(today.year, today.month, today.day, 9, 0, 0);
  final DateTime endTime = startTime.add(const Duration(days: 2));

  print(DateTime.now());

  meetings.add(Appointment(
      startTime: startTime,
      endTime: endTime,
      subject: 'Conference',
      color: Colors.blue));
  meetings.add(Appointment(
      startTime: DateTime(2022, 7, 10),
      endTime: DateTime(2022, 7, 11),
      subject: 'Night Out',
      color: Colors.red));

  return meetings;
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }
}
