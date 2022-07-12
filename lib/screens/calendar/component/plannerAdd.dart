import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:emedassistantmobile/config/app_colors.dart';
import 'package:emedassistantmobile/widgets/custom_button.dart';
import 'package:intl/intl.dart';

class PlannerAddDialog extends StatefulWidget {
  final DateTime? date;
  const PlannerAddDialog(this.date, {Key? key}) : super(key: key);

  @override
  State<PlannerAddDialog> createState() => _PlannerAddDialogState();
}

class _PlannerAddDialogState extends State<PlannerAddDialog> {
  String? selectedValue;
  List<String> items = [
    '09:00 AM',
    '10:00 AM',
    '11:00 AM',
    '12:00 AM',
  ];
  String? selectedValueOne;
  List<String> itemsOne = [
    '09:00 PM',
    '10:00 PM',
    '11:00 PM',
    '12:00 PM',
  ];

  TextEditingController appointmentNumberController = TextEditingController();
  TextEditingController eachTimeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          width: width,
          margin: const EdgeInsets.symmetric(horizontal: 20.0),
          decoration: const BoxDecoration(
            color: AppColors.lightBackground,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              /// schedule new slot text
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    'Schedule a new slot on ${DateFormat('EEE MMM d y  h:mm a').format(widget.date!)}',
                    style: const TextStyle(
                      fontSize: 15.0,
                      color: AppColors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              /// times box
              Container(
                width: width,
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                decoration: const BoxDecoration(
                  color: AppColors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      /// select time for slot
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text(
                                  'Start Time',
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: AppColors.lightBlack,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 10.0),
                                Container(
                                  width: width,
                                  height: 40.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2.0),
                                    color: AppColors.white,
                                    border: Border.all(
                                      color: AppColors.primary,
                                      width: 1.0,
                                    ),
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton2(
                                      icon:
                                          const Icon(Icons.keyboard_arrow_down),
                                      hint: const Text(
                                        '',
                                        style: TextStyle(
                                          fontSize: 13.0,
                                          color: AppColors.lightBlack,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      items: items
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
                                      value: selectedValue,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedValue = value as String;
                                        });
                                      },
                                      buttonHeight: 40,
                                      buttonWidth: 140,
                                      itemHeight: 36.0,
                                      dropdownWidth: 150,
                                      buttonPadding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      dropdownDecoration: const BoxDecoration(
                                        color: AppColors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text(
                                  'End Time',
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: AppColors.lightBlack,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 10.0),
                                Container(
                                  width: width,
                                  height: 40.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2.0),
                                    color: AppColors.white,
                                    border: Border.all(
                                      color: AppColors.primary,
                                      width: 1.0,
                                    ),
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton2(
                                      icon:
                                          const Icon(Icons.keyboard_arrow_down),
                                      hint: const Text(
                                        '',
                                        style: TextStyle(
                                          fontSize: 13.0,
                                          color: AppColors.lightBlack,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      items: itemsOne
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
                                      value: selectedValueOne,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedValueOne = value as String;
                                        });
                                      },
                                      buttonHeight: 40,
                                      buttonWidth: 140,
                                      itemHeight: 36.0,
                                      dropdownWidth: 150,
                                      buttonPadding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      dropdownDecoration: const BoxDecoration(
                                        color: AppColors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      /// no appointment and time for each
                      const SizedBox(height: 24.0),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'No appointments',
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: AppColors.lightBlack,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 10.0),
                                Container(
                                  width: width,
                                  height: 40.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2.0),
                                    color: AppColors.white,
                                    border: Border.all(
                                      color: AppColors.primary,
                                      width: 1.0,
                                    ),
                                  ),
                                  child: TextFormField(
                                    controller: appointmentNumberController,
                                    keyboardType: TextInputType.number,
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                      color: AppColors.lightBlack,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.only(
                                          left: 12.0, bottom: 10.0),
                                      hintText: '1',
                                      hintStyle: TextStyle(
                                        fontSize: 15.0,
                                        color: AppColors.lightBlack,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Time for each',
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: AppColors.lightBlack,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 10.0),
                                Container(
                                  width: width,
                                  height: 40.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2.0),
                                    color: AppColors.white,
                                    border: Border.all(
                                      color: AppColors.primary,
                                      width: 1.0,
                                    ),
                                  ),
                                  child: TextFormField(
                                    controller: eachTimeController,
                                    keyboardType: TextInputType.number,
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                      color: AppColors.lightBlack,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.only(
                                          left: 12.0, bottom: 10.0),
                                      hintText: '1',
                                      hintStyle: TextStyle(
                                        fontSize: 15.0,
                                        color: AppColors.lightBlack,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: height * 0.2),

                      /// not a repetitive slot button with dialog
                      TextButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                elevation: 0.0,
                                backgroundColor: AppColors.white,
                                contentPadding: const EdgeInsets.all(0.0),
                                content: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 24.0),
                                  decoration: BoxDecoration(
                                    color: AppColors.lightBlue.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: const [
                                      Text(
                                        'It is not a repetitive slot',
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          color: AppColors.black,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(height: 16.0),
                                      Text(
                                        'It repeats everyday',
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          color: AppColors.lightBlack,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      SizedBox(height: 16.0),
                                      Text(
                                        'It is repeated every working day of the week',
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          color: AppColors.lightBlack,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      SizedBox(height: 16.0),
                                      Text(
                                        'It repeats every week on Wednesday',
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          color: AppColors.lightBlack,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      SizedBox(height: 16.0),
                                      Text(
                                        'It repeats every month on the third Wednesday',
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          color: AppColors.lightBlack,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: const Text(
                          'It\'s not a repetitive slot',
                          style: TextStyle(
                            fontSize: 15.0,
                            color: AppColors.secondary,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              /// cancel and publish button
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: CustomButton(
                      onTap: () {
                        Get.back();
                      },
                      btnText: 'Cancel',
                      borderColor: AppColors.primary,
                      btnColor: AppColors.white,
                      width: 60.0,
                      fontColor: AppColors.black,
                    ),
                  ),
                  const SizedBox(width: 12.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: CustomButton(
                      onTap: () {},
                      btnText: 'Publish',
                      width: 80.0,
                    ),
                  ),
                  const SizedBox(width: 16.0),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
