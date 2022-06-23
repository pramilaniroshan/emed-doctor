import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:emedassistantmobile/config/app_colors.dart';
import 'package:emedassistantmobile/screens/book_an_appointment/patient_booking_screen.dart';

class DateRow extends StatelessWidget {
  final String? dayText;
  final String? dateText;
  final String? timeSlotText;
  final String id;
  final int? consultationFee;
  final String? doctorFullName;

  const DateRow({Key? key,
    this.dayText = 'Monday, ',
    this.dateText = '11 Apr ',
    this.timeSlotText = '2022 - 9-11am - 3\'slot ',
    this.consultationFee = 0,
    this.doctorFullName = 'name',
    this.id = ''
    
}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
       onTap: () { Get.to( PatientBookingScreen(timeSlotText,consultationFee,doctorFullName,id)); },
      child: Container(
        
        width: width,
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: AppColors.primary,
              width: 0.5,
            ),
            top: BorderSide(
              color: AppColors.primary,
              width: 0.5,
            ),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                        text: dayText,
                        style: const TextStyle(
                          fontSize: 13.0,
                          color: AppColors.black,
                          fontWeight: FontWeight.w400,
                        )
                    ),
                    TextSpan(
                        text: dateText,
                        style: const TextStyle(
                          fontSize: 13.0,
                          color: AppColors.black,
                          fontWeight: FontWeight.bold,
                        )
                    ),
                    TextSpan(
                        text: timeSlotText,
                        style: const TextStyle(
                          fontSize: 13.0,
                          color: AppColors.black,
                          fontWeight: FontWeight.w400,
                          height: 1.3,
                        )
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 42.0,
              width: 42.0,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.secondary,
              ),
              child: const Center(
                child: Icon(Icons.calendar_today, color: AppColors.white, size: 18.0),
                
              ),
            ),
          ],
        ),
      ),
    );
  }
}
