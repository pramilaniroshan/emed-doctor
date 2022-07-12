import 'package:emedassistantmobile/config/app_colors.dart';
import 'package:emedassistantmobile/screens/calendar/component/plannerAdd.dart';
import 'package:emedassistantmobile/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

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
          view: CalendarView.timelineWorkWeek,
          showDatePickerButton: true,
          timeSlotViewSettings: const TimeSlotViewSettings(),
          allowedViews: const <CalendarView>[
            CalendarView.day,
            CalendarView.week,
            CalendarView.month,
            CalendarView.timelineWorkWeek,
            CalendarView.timelineDay,
            CalendarView.timelineMonth,
            CalendarView.schedule,
          ],
          onTap: (CalendarTapDetails details) {
            DateTime date = details.date!;
            if (details.appointments == null) {
              Get.dialog(PlannerAddDialog(date));
            }
            print(date);
          },
          dataSource: MeetingDataSource(getAppointments()),
          appointmentBuilder: appointmentBuilder,
        ),
      ]),
    );
  }

  Widget appointmentBuilder(BuildContext context,
      CalendarAppointmentDetails calendarAppointmentDetails) {
    final Appointment appointment =
        calendarAppointmentDetails.appointments.first;
    return Column(
      children: [
        Container(
          width: calendarAppointmentDetails.bounds.width,
          height: calendarAppointmentDetails.bounds.height / 2,
          color: appointment.color,
          child: const Icon(
            Icons.group,
            color: Colors.black,
          ),
        ),
        Container(
          width: calendarAppointmentDetails.bounds.width,
          height: calendarAppointmentDetails.bounds.height / 2,
          color: appointment.color,
          child: Text(
            appointment.subject +
                DateFormat(' (hh:mm a').format(appointment.startTime) +
                '-' +
                DateFormat('hh:mm a)').format(appointment.endTime),
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 10),
          ),
        )
      ],
    );
  }
}

List<Appointment> getAppointments() {
  List<Appointment> meetings = <Appointment>[];
  List<CalendarResource> resources = <CalendarResource>[];

  final DateTime today = DateTime.now();
  final DateTime startTime = DateTime.now();
  final DateTime endTime = DateTime.now().add(Duration(hours: 2));

  meetings.add(Appointment(
      notes: "This is a note",
      location: "Rathnapura",
      //recurrenceId: <Object>['0001'],
      startTime: startTime,
      endTime: endTime,
      subject: 'Conference',
      color: Colors.blue.withOpacity(0.1)));

  meetings.add(Appointment(
      startTime: DateTime.now(),
      endTime: DateTime.now().add(const Duration(hours: 4)),
      subject: 'Night Out',
      color: Colors.red));

  resources.add(
      CalendarResource(displayName: 'John', id: '0001', color: Colors.red));

  return meetings;
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }
}

// class DataSource extends CalendarDataSource {
//   DataSource(List<Appointment> source, List<CalendarResource> resourceColl) {
//     appointments = source;
//     resources = resourceColl;
//   }
// }

class DataSource extends CalendarDataSource {
  DataSource(List<Appointment> source, List<CalendarResource> resourceColl) {
    appointments = source;
    resources = resourceColl;
  }
}

DataSource _getCalendarDataSource() {
  List<Appointment> appointments = <Appointment>[];
  List<CalendarResource> resources = <CalendarResource>[];
  appointments.add(Appointment(
      startTime: DateTime.now().add(Duration(hours: 2)),
      endTime: DateTime.now().add(Duration(hours: 5)),
      isAllDay: false,
      subject: 'Meeting',
      notes: 'This is a sample note',
      location: 'Rathnapura',
      color: AppColors.lightBlue.withOpacity(0.1),
      resourceIds: <Object>['0001'],
      startTimeZone: '',
      endTimeZone: ''));

  appointments.add(Appointment(
      startTime: DateTime.now(),
      endTime: DateTime.now().add(Duration(hours: 2)),
      isAllDay: false,
      subject: 'Meeting',
      color: Colors.blue,
      //resourceIds: <Object>['0002'],
      startTimeZone: '',
      endTimeZone: ''));

  appointments.add(Appointment(
      startTime: DateTime.now().add(Duration(hours: 5)),
      endTime: DateTime.now().add(Duration(hours: 10)),
      isAllDay: false,
      subject: 'Meeting',
      color: Colors.green,
      //resourceIds: <Object>['0003'],
      startTimeZone: '',
      endTimeZone: ''));

  appointments.add(Appointment(
      startTime: DateTime.now().add(Duration(hours: 6)),
      endTime: DateTime.now().add(Duration(hours: 11)),
      isAllDay: false,
      subject: 'Meeting',
      color: Colors.blueAccent,
      //resourceIds: <Object>['0004'],
      startTimeZone: '',
      endTimeZone: ''));

  resources.add(CalendarResource(
    //displayName: 'Pramila',
    id: '0001',
    color: Colors.red,
    //image: const ExactAssetImage(AppImages.peopleCircle_1)
  ));

  resources.add(CalendarResource(
      displayName: 'Niroshan',
      id: '0002',
      color: Colors.blue,
      image: const ExactAssetImage(AppImages.peopleCircle_2)));

  resources.add(CalendarResource(
      displayName: 'Madara',
      id: '0003',
      color: Colors.green,
      image: const ExactAssetImage(AppImages.peopleCircle_3)));

  resources.add(CalendarResource(
      displayName: 'Bagya',
      id: '0004',
      color: Colors.cyanAccent,
      image: const ExactAssetImage(AppImages.peopleCircle_4)));

  return DataSource(appointments, resources);
}
