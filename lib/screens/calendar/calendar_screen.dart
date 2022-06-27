import 'package:emedassistantmobile/config/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'package:emedassistantmobile/screens/doctor_appointment/component/appoinment_dialog.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
     body: SfCalendar(
      view: CalendarView.week,
      timeSlotViewSettings:
              TimeSlotViewSettings(allDayPanelColor: AppColors.redColor),
      allowedViews: <CalendarView>
        [
          CalendarView.day,
          CalendarView.week,
          CalendarView.workWeek,
          CalendarView.month,
          CalendarView.schedule
        ],
         onTap: (CalendarTapDetails details) {
            dynamic appointment = details.appointments;
            DateTime date = details.date!;
            CalendarElement element = details.targetElement;
            if(details.appointments != null) {

              Get.dialog(AppointmentDialog());

              }
            
            print(date);
          },
        
      dataSource: MeetingDataSource(getAppointments()),
     ),
      
    );
  }
}

List<Appointment> getAppointments() {
  List<Appointment> meetings = <Appointment>[];
  final DateTime today = DateTime.now();
  final DateTime startTime = DateTime(today.year, today.month, today.day, 9, 0, 0);
  final DateTime endTime = startTime.add(const Duration(days: 2));

  print(DateTime.now());

  meetings.add(Appointment(startTime: startTime, endTime: endTime, subject: 'Conference', color: Colors.blue));
  meetings.add(Appointment(startTime: DateTime(2022, 7, 10), endTime: DateTime(2022, 7, 11), subject: 'Night Out', color: Colors.red));

  return meetings;
}

class MeetingDataSource extends CalendarDataSource {
      MeetingDataSource(List<Appointment> source) {
        appointments = source;

      }
}