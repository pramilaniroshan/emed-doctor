import 'package:flutter/material.dart';

import 'package:emedassistantmobile/config/app_colors.dart';
import 'date_row.dart';

class DoctorAvailabilityDialog extends StatefulWidget {
  const DoctorAvailabilityDialog({Key? key}) : super(key: key);

  @override
  State<DoctorAvailabilityDialog> createState() => _DoctorAvailabilityDialogState();
}

class _DoctorAvailabilityDialogState extends State<DoctorAvailabilityDialog>
    with SingleTickerProviderStateMixin {

  TabController? tabController;

  @override
  void initState() {
    tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    tabController!.dispose();
  }


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
              const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    'Dr. Ashey askajsdh planned availability',
                    style: TextStyle(
                      fontSize: 17.0,
                      color: AppColors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              /// times slot tab bar
              Container(
                width: width,
                padding: const EdgeInsets.only(top: 20.0),
                decoration: const BoxDecoration(
                  color: AppColors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TabBar(
                        controller: tabController,
                        labelColor: AppColors.black,
                        isScrollable: true,
                        unselectedLabelColor: AppColors.secondary,
                        tabs: const [

                          Tab(
                            text: 'April',
                          ),


                          Tab(
                            text: 'May',
                          ),

                          Tab(
                            text: 'June',
                          ),

                          Tab(
                            text: 'July',
                          ),
                        ],
                      ),
                      const SizedBox(height: 16.0),
                      SizedBox(
                        height: height * 0.36,
                        width: width,
                        child: RawScrollbar(
                          radius: const Radius.circular(8.0),
                          thumbColor: AppColors.secondary,
                          thumbVisibility: true,
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  DateRow(
                                    dayText: 'Monday, ',
                                    dateText: '11 Apr ',
                                    timeSlotText: '2022\n9-11am - 3°slot',
                                  ),
                                  DateRow(
                                    dayText: 'Monday, ',
                                    dateText: '11 Apr ',
                                    timeSlotText: '2022\n9-11am - 3°slot',
                                  ),
                                  DateRow(
                                    dayText: 'Monday, ',
                                    dateText: '11 Apr ',
                                    timeSlotText: '2022\n9-11am - 3°slot',
                                  ),
                                  DateRow(
                                    dayText: 'Monday, ',
                                    dateText: '11 Apr ',
                                    timeSlotText: '2022\n9-11am - 3°slot',
                                  ),
                                  DateRow(
                                    dayText: 'Monday, ',
                                    dateText: '11 Apr ',
                                    timeSlotText: '2022\n9-11am - 3°slot',
                                  ),
                                  DateRow(
                                    dayText: 'Monday, ',
                                    dateText: '11 Apr ',
                                    timeSlotText: '2022\n9-11am - 3°slot',
                                  ),
                                  DateRow(
                                    dayText: 'Monday, ',
                                    dateText: '11 Apr ',
                                    timeSlotText: '2022\n9-11am - 3°slot',
                                  ),
                                  DateRow(
                                    dayText: 'Monday, ',
                                    dateText: '11 Apr ',
                                    timeSlotText: '2022\n9-11am - 3°slot',
                                  ),
                                  DateRow(
                                    dayText: 'Monday, ',
                                    dateText: '11 Apr ',
                                    timeSlotText: '2022\n9-11am - 3°slot',
                                  ),
                                  DateRow(
                                    dayText: 'Monday, ',
                                    dateText: '11 Apr ',
                                    timeSlotText: '2022\n9-11am - 3°slot',
                                  ),
                                  DateRow(
                                    dayText: 'Monday, ',
                                    dateText: '11 Apr ',
                                    timeSlotText: '2022\n9-11am - 3°slot',
                                  ),
                                  DateRow(
                                    dayText: 'Monday, ',
                                    dateText: '11 Apr ',
                                    timeSlotText: '2022\n9-11am - 3°slot',
                                  ),
                                  DateRow(
                                    dayText: 'Monday, ',
                                    dateText: '11 Apr ',
                                    timeSlotText: '2022\n9-11am - 3°slot',
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
