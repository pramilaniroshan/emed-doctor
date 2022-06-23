import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:emedassistantmobile/screens/scan_qr/scan_qr_screen.dart';
import 'package:emedassistantmobile/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

import 'package:emedassistantmobile/config/app_colors.dart';
import 'package:emedassistantmobile/config/app_images.dart';
import '../../widgets/custom_field.dart';
import 'components/doctor_availability_dialog.dart';
import 'components/search_doctor_box.dart';

class BookAnAppointmentScreen extends StatefulWidget {
  const BookAnAppointmentScreen({Key? key}) : super(key: key);

  @override
  State<BookAnAppointmentScreen> createState() =>
      _BookAnAppointmentScreenState();
}

class _BookAnAppointmentScreenState extends State<BookAnAppointmentScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late SharedPreferences prefs;

  List doctorlist= [];

  String? selectedValue;
  List<String> items = [
    '15 minutes',
    '1 hour',
    '4 hours',
    '24 hours',
  ];

  final Set<Marker> _markers = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void searchDoctor() async {
    doctorlist.clear();
    print('Search Doctor');
    prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token") ?? '';
    print(token);
    try {
      var dio = Dio();
      dio.options.headers["authorization"] = "Bearer " + token;
      await dio.get(
          'https://localhost:5001/api/v1/Patient/SearchDoctorAvailability',
          queryParameters: {"DoctorName": nameController.text}).then((res) {

            var rdata = res.data['Data']['Data'];
            for (var i in rdata) {
              doctorlist.add(i);
            }
        setState(() {
          
        });
        print(res.data);
      });
    } on DioError catch (e) {
      // The request was made and the
      // server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      print(e.response!.statusCode);
      // if (e.response != null) {
      //  // print(e);
      // } else {
      //   // Something happened in setting up or sending the request that triggered an Error
      //   //print(e);
      //   //print(e);
      // }
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _markers.add(
        const Marker(
          markerId: MarkerId('id-1'),
          position: LatLng(30.587968, 60.814708),
        ),
      );
    });
  }

  final myFormat = DateFormat('yyyy-MM-dd');
  var date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    Future<void> selectDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: date,
          firstDate: DateTime(2015, 8),
          lastDate: DateTime(2101));
      setState(() {
        date = picked ?? date;
      });
    }

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
          menuButton(),
        ],
      ),
      endDrawer: Drawer(
        backgroundColor: AppColors.white,
        elevation: 0.0,
        child: endDrawerData(height),
      ),
      body: SingleChildScrollView(

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 24.0),
            const Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Text(
                'Book and appointment',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w600,
                  color: AppColors.black,
                ),
              ),
            ),
            const SizedBox(height: 24.0),

            /// Search Box
            Container(
              width: width,
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              decoration: BoxDecoration(
                color: AppColors.white,
                border: Border(
                  top: BorderSide(
                    color: AppColors.lightBlack.withOpacity(0.5),
                    width: 1.0,
                  ),
                  bottom: BorderSide(
                    color: AppColors.lightBlack.withOpacity(0.5),
                    width: 1.0,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: Text(
                      'Define one or more search criteria',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        color: AppColors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12.0),

                  /// Doctor name field
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: CustomField(
                      height: 40.0,
                      controller: nameController,
                      keyboardType: TextInputType.name,
                      padding: const EdgeInsets.only(bottom: 12.0, left: 16.0),
                      hintText: 'Doctor Name',
                    ),
                  ),
                  // const Padding(
                  //   padding: EdgeInsets.only(left: 20.0, top: 8.0),
                  //   child: Text(

                  //     '',
                  //     style: TextStyle(
                  //       fontSize: 16.0,
                  //       fontWeight: FontWeight.w500,
                  //       color: AppColors.secondary,

                  //     ),
                  //   ),
                  // ),

                  /// doctor medical speciality dropdown
                  const SizedBox(height: 16.0),
                  const Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: Text(
                      'Doctor\'s medical specialty',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        color: AppColors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  Container(
                    height: 40.0,
                    width: width,
                    margin: const EdgeInsets.symmetric(horizontal: 16.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.primary,
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2(
                        icon: const Icon(Icons.keyboard_arrow_down),
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
                                    color: Colors.white,
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
                        buttonPadding:
                            const EdgeInsets.symmetric(horizontal: 8.0),
                        dropdownDecoration: const BoxDecoration(
                          color: AppColors.lightBlack,
                        ),
                      ),
                    ),
                  ),

                  /// Appointment Location
                  const SizedBox(height: 24.0),
                  const Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: Text(
                      'Appointment Location',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        color: AppColors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: CustomField(
                      height: 40.0,
                      controller: locationController,
                      keyboardType: TextInputType.name,
                      padding: const EdgeInsets.only(bottom: 12.0, left: 16.0),
                      hintText: '',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, top: 8.0, right: 20.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Text(
                          'Colombo',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                            color: AppColors.secondary,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        SizedBox(width: 12.0),
                        Text(
                          'Kandy',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                            color: AppColors.secondary,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// Date Picker
                  const SizedBox(height: 16.0),
                  const Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: Text(
                      'Date',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        color: AppColors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  Container(
                    height: 40.0,
                    width: width,
                    margin: const EdgeInsets.symmetric(horizontal: 16.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.primary,
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            myFormat.format(date),
                            style: const TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w500,
                              color: AppColors.black,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              selectDate(context);
                            },
                            child: const Icon(Icons.calendar_today,
                                color: AppColors.primary, size: 20.0),
                          ),
                        ],
                      ),
                    ),
                  ),

                  /// Search Button
                  const SizedBox(height: 32.0),
                  Center(
                    child: CustomButton(
                      onTap: () {
                        searchDoctor();
                        /*Get.dialog(
                          const ScheduleSlotDialog(),
                        );*/
                        // Get.dialog(
                        //   const DoctorAvailabilityDialog(),
                        // );
                      },
                      btnText: 'Search',
                      width: 90.0,
                      height: 36.0,
                    ),
                  ),
                ],
              ),
            ),

            /// Search Result List
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.25,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: GoogleMap(
                    onMapCreated: _onMapCreated,
                    markers: _markers,
                    initialCameraPosition: const CameraPosition(
                      target: LatLng(30.587968, 60.814708),
                      //zoom: 5,
                    ),
                  ),
                ),
              ),
            ),
            doctorlist.isEmpty ? Center(child: CircularProgressIndicator()) :Column(
              children: List.generate(doctorlist.length, (index) => SearchDoctorBox(doctorlist[index]["IanaTimeZoneId"],doctorlist[index]["Id"],doctorlist[index]["DoctorFullName"],doctorlist[index]["FreeSlots"],doctorlist[index]["ConsultationFee"]))
            )
            
            /// List of search items
            //getDoctorList(doctorlist),
            // ListView.builder(
            //     padding: const EdgeInsets.all(8),
            //     itemCount: doctorlist.length,
            //     itemBuilder: (BuildContext context, int index) {
            //       return Container(
            //         height: 50,
            //         color: Colors.amber,
            //         child: Center(child: Text('Entry ${[index]}')),
            //       );
            //     }),
            ///const SizedBox(height: 40.0),
            
          ],
        ),
      ),
    );
  }

  // Widget getDoctorList(List<String> strings)
  // {
  //   return new Row(children: children: list);
  // }

  Widget endDrawerData(height) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 40.0),
          Align(
            alignment: Alignment.bottomRight,
            child: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: SvgPicture.asset(
                AppImages.closeIcon,
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          ListTile(
            onTap: () {
              Get.to(const ScanQrScreen());
            },
            leading: Padding(
              padding: const EdgeInsets.only(top: 6.0, left: 12.0),
              child: SvgPicture.asset(
                AppImages.supportIcon,
                height: 13.0,
                width: 13.0,
                fit: BoxFit.scaleDown,
                color: AppColors.secondary,
              ),
            ),
            title: const Align(
              alignment: Alignment(-1.3, 0),
              child: Text(
                'Support',
                style: TextStyle(
                  fontSize: 21.0,
                  color: AppColors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          ListTile(
            onTap: () {},
            leading: Padding(
              padding: const EdgeInsets.only(top: 6.0, left: 12.0),
              child: SvgPicture.asset(
                AppImages.contactIcon,
                height: 13.0,
                width: 13.0,
                fit: BoxFit.scaleDown,
                color: AppColors.secondary,
              ),
            ),
            title: const Align(
              alignment: Alignment(-1.3, 0),
              child: Text(
                'Contact',
                style: TextStyle(
                  fontSize: 21.0,
                  color: AppColors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          ListTile(
            onTap: () {},
            leading: Padding(
              padding: const EdgeInsets.only(top: 6.0, left: 12.0),
              child: SvgPicture.asset(
                AppImages.termsIcon,
                height: 13.0,
                width: 13.0,
                fit: BoxFit.scaleDown,
                color: AppColors.secondary,
              ),
            ),
            title: const Align(
              alignment: Alignment(-1.3, 0),
              child: Text(
                'Terms',
                style: TextStyle(
                  fontSize: 21.0,
                  color: AppColors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          ListTile(
            onTap: () {},
            leading: Padding(
              padding: const EdgeInsets.only(top: 6.0, left: 12.0),
              child: SvgPicture.asset(
                AppImages.linkIcon,
                height: 13.0,
                width: 13.0,
                fit: BoxFit.scaleDown,
                color: AppColors.secondary,
              ),
            ),
            title: const Align(
              alignment: Alignment(-1.3, 0),
              child: Text(
                'eMed.com',
                style: TextStyle(
                  fontSize: 21.0,
                  color: AppColors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          SizedBox(height: height * 0.06),
          ListTile(
            onTap: () {},
            leading: Padding(
              padding: const EdgeInsets.only(top: 6.0, left: 12.0),
              child: SvgPicture.asset(
                AppImages.globeIcon,
                height: 13.0,
                width: 13.0,
                fit: BoxFit.scaleDown,
                color: AppColors.secondary,
              ),
            ),
            title: const Align(
              alignment: Alignment(-1.1, 0),
              child: Text(
                'English',
                style: TextStyle(
                  fontSize: 16.0,
                  color: AppColors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            trailing: const Icon(Icons.keyboard_arrow_down_outlined,
                color: AppColors.black),
          ),
        ],
      );

  Widget menuButton() => TextButton(
        onPressed: () {
          _scaffoldKey.currentState!.openEndDrawer();
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            Text(
              'Mr. Abcdjajd',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
                color: AppColors.black,
              ),
            ),
            SizedBox(width: 12.0),
            Icon(Icons.menu, color: AppColors.black, size: 28.0),
            SizedBox(width: 12.0),
          ],
        ),
      );
}
