import 'package:dio/dio.dart';
import 'package:emedassistantmobile/config/app_colors.dart';
import 'package:emedassistantmobile/screens/calendar/component/plannerAdd.dart';
import 'package:emedassistantmobile/widgets/drawer.dart';
import 'package:emedassistantmobile/widgets/user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../config/app_images.dart';
import '../../config/constants.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late SharedPreferences prefs;
  List<Appointment> appointmentList = [];
  List doctorAvailabilities = [];

  void getAvailability() async {
    print('Doctor Availabilities');
    prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token") ?? '';
    try {
      var dio = Dio();
      dio.options.headers["authorization"] = "Bearer " + token;
      await dio
          .get(
        Constants().getBaseUrl() + '/Doctor/Availability',
      )
          .then((res) {
        setState(() {
          doctorAvailabilities = res.data['Data']['Data'];
          appointmentList = getAppointments();
        });
        //print(doctorAvailabilities[0]['StartTime']);
      });
    } on DioError catch (e) {
      print(e.response!.data);
    }
  }

  List<Appointment> getAppointments() {
    List<Appointment> meetings = <Appointment>[];
    List<CalendarResource> resources = <CalendarResource>[];

    var dateFormat = DateFormat('EEE, MMM d ,y,h:mm a');

    for (var i = 0; i < doctorAvailabilities.length; i++) {
      var utcStartDate = dateFormat
          .format(DateTime.parse(doctorAvailabilities[i]['StartTime']));
      var utcEndtDate =
          dateFormat.format(DateTime.parse(doctorAvailabilities[i]['EndTime']));
      meetings.add(Appointment(
          notes: doctorAvailabilities[i]['Location']['LocationAddress'] +
              " " +
              " $i",
          location: doctorAvailabilities[i]['Location']['LocationName'],
          //recurreceId: <Object>['0001'],
          startTime: dateFormat.parse(utcStartDate, true).toLocal(),
          endTime: dateFormat.parse(utcEndtDate, true).toLocal(),
          subject: doctorAvailabilities[i]['Location']['LocationAddress'] +
              " " +
              " $i",
          color: Colors.blue.withOpacity(0.1)));
    }

    resources.add(
        CalendarResource(displayName: 'John', id: '0001', color: Colors.red));

    return meetings;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAvailability();
  }

  @override
  Widget build(BuildContext context) {
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
          DoctorDrawerAction(),
        ],
      ),
      endDrawer: DoctorDrawer(),
      body: Row(children: [
        SfCalendar(
          view: CalendarView.day,
          showDatePickerButton: true,
          allowViewNavigation: true,
          timeSlotViewSettings: const TimeSlotViewSettings(),
          scheduleViewSettings: const ScheduleViewSettings(
            monthHeaderSettings:
                MonthHeaderSettings(backgroundColor: AppColors.redColor),
          ),
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
          dataSource: MeetingDataSource(appointmentList),
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

// class DataSource extends CalendarDataSource {
//   DataSource(List<Appointment> source, List<CalendarResource> resourceColl) {
//     appointments = source;
//     resources = resourceColl;
//   }
// }

// DataSource _getCalendarDataSource() {
//   List<Appointment> appointments = <Appointment>[];
//   List<CalendarResource> resources = <CalendarResource>[];
//   appointments.add(Appointment(
//       startTime: DateTime.now().add(Duration(hours: 2)),
//       endTime: DateTime.now().add(Duration(hours: 5)),
//       isAllDay: false,
//       subject: 'Meeting',
//       notes: 'This is a sample note',
//       location: 'Rathnapura',
//       color: AppColors.lightBlue.withOpacity(0.1),
//       resourceIds: <Object>['0001'],
//       startTimeZone: '',
//       endTimeZone: ''));

//   appointments.add(Appointment(
//       startTime: DateTime.now(),
//       endTime: DateTime.now().add(Duration(hours: 2)),
//       isAllDay: false,
//       subject: 'Meeting',
//       color: Colors.blue,
//       //resourceIds: <Object>['0002'],
//       startTimeZone: '',
//       endTimeZone: ''));

//   appointments.add(Appointment(
//       startTime: DateTime.now().add(Duration(hours: 5)),
//       endTime: DateTime.now().add(Duration(hours: 10)),
//       isAllDay: false,
//       subject: 'Meeting',
//       color: Colors.green,
//       //resourceIds: <Object>['0003'],
//       startTimeZone: '',
//       endTimeZone: ''));

//   appointments.add(Appointment(
//       startTime: DateTime.now().add(Duration(hours: 6)),
//       endTime: DateTime.now().add(Duration(hours: 11)),
//       isAllDay: false,
//       subject: 'Meeting',
//       color: Colors.blueAccent,
//       //resourceIds: <Object>['0004'],
//       startTimeZone: '',
//       endTimeZone: ''));

//   resources.add(CalendarResource(
//     //displayName: 'Pramila',
//     id: '0001',
//     color: Colors.red,
//     //image: const ExactAssetImage(AppImages.peopleCircle_1)
//   ));

//   resources.add(CalendarResource(
//       displayName: 'Niroshan',
//       id: '0002',
//       color: Colors.blue,
//       image: const ExactAssetImage(AppImages.peopleCircle_2)));

//   resources.add(CalendarResource(
//       displayName: 'Madara',
//       id: '0003',
//       color: Colors.green,
//       image: const ExactAssetImage(AppImages.peopleCircle_3)));

//   resources.add(CalendarResource(
//       displayName: 'Bagya',
//       id: '0004',
//       color: Colors.cyanAccent,
//       image: const ExactAssetImage(AppImages.peopleCircle_4)));

//   return DataSource(appointments, resources);
// }
