import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

import 'package:emedDoctor/config/app_colors.dart';
import 'date_row.dart';

class ExpandDates extends StatefulWidget {

  final String id;
  final List FreeSlots;
  final String doctorFullName;
  final int consultationFee;

  const ExpandDates(
  //this.id,
  this.FreeSlots,
  this.doctorFullName,
  this.id,
  this.consultationFee,
  {Key? key}
  ) : super(key: key);

  @override
  State<ExpandDates> createState() => _ExpandDatesState();
}



class _ExpandDatesState extends State<ExpandDates> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return ExpandablePanel(
      theme: const ExpandableThemeData(
        useInkWell: true,
        hasIcon: false,
      ),
      header: const Padding(
        padding: EdgeInsets.symmetric(vertical: 12.0),
        child: Align(
          alignment: Alignment.centerRight,
          child: Text('Show available dates',
            style: TextStyle(
              fontSize: 14.0,
              color: AppColors.secondary,
              fontWeight: FontWeight.w600,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ),
      collapsed: const SizedBox(),
      expanded: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children:  [
          widget.FreeSlots.isEmpty ? Center(child: CircularProgressIndicator()) :Column(
              children: List.generate(widget.FreeSlots.length, (index) => DateRow(
          
            dayText: 'Monday, ',
            dateText: '11 Apr ',
            timeSlotText: widget.FreeSlots[index],
            id : widget.id,
            doctorFullName : widget.doctorFullName,
            consultationFee : widget.consultationFee

          ))
            ),
            /*DateRow(
          
            dayText: 'Monday, ',
            dateText: '11 Apr ',
            timeSlotText: '2022 - 9-11am 3°slot',
            id : '123',

          ),*/
          SizedBox(height: 16.0),
          // Align(
          //   alignment: Alignment.centerRight,
          //   child: Text('Show more dates',
          //     style: TextStyle(
          //       fontSize: 14.0,
          //       color: AppColors.secondary,
          //       fontWeight: FontWeight.w600,
          //       decoration: TextDecoration.underline,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

}