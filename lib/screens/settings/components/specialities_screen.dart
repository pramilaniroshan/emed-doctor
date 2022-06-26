import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

import 'package:emedassistantmobile/config/app_colors.dart';
import '../../../widgets/custom_button.dart';
import '../../profile_setup/components/speciality_box.dart';

class SpecialitiesScreen extends StatefulWidget {
  const SpecialitiesScreen({Key? key}) : super(key: key);

  @override
  State<SpecialitiesScreen> createState() => _SpecialitiesScreenState();
}

class _SpecialitiesScreenState extends State<SpecialitiesScreen> {

  List<String> items = [
    'Allergists/Immunologists',
    'Anesthesiologists',
    'Cardiologists',
    'Colon and Rectal Surgeons',
    'Critical Care Medicine Spec.',
    'Dermatologists',
    'Endocrinologists',
    'Preventive Medicine Spec.',
    'Psychiatrists',
    'Pulmonologists',
    'Radiologists',
    'Rhenumatologists',
    'Medicine Spec.',
    'Sports Medicine Spec.',
    'General Surgeons',
    'Urologists',
  ];

  List<String> doctor_sp = [
    'Allergists/Immunologists',
    'Psychiatrists'
  ];

  bool selected = false;

  late SharedPreferences prefs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //doctorUpdateSpecialization();
  }

  void doctorUpdateSpecialization() async {
    print('Doctor DoctorUpdateSpecialization');
    prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token") ?? '';
    try {
      var dio = Dio();
      dio.options.headers["authorization"] = "Bearer " + token;
      await dio
          .post
        ('https://localhost:5001/api/v1/Doctor/UpdateSpecialization',data : {
          "DoctorSpecializations": doctor_sp
        }
      )
          .then((res) {
        setState(() {
          
        });
        //print(Appointments[3]['Patient']['LastName']);
      });
    } on DioError catch (e) {
      print(e.response!.data);
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Container(
        width: width,
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 24.0),
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text('Your professional specialities',
              style: TextStyle(
                fontSize: 18.0,
                color: AppColors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            // Wrap(
            //   children: items
            //       .map((item) {
            //     var index = items.indexOf(item);

            //     return FilterChip(
            //   label: Text(items[index]),
            //   selected: items.contains('Urologists'),
            //   onSelected: (bool value) {},
            // );
            //     // return SpecialityBox(
            //     //   onTap: () {},
            //     //   text: items[index],
            //     // );
            //   }).toList(),
            // ),
            const SizedBox(height: 20.0),
            ChipsChoice<String>.multiple(
            value: doctor_sp,
            onChanged: (val) => setState(() => doctor_sp = val),
            choiceItems: C2Choice.listFrom<String, String>(
              source: items,
              value: (i, v) => v,
              label: (i, v) => v,
            ),
            choiceStyle: C2ChoiceStyle(
              borderColor: AppColors.primary,
              color: AppColors.black,
              labelPadding: EdgeInsets.all(5),
            ),
            choiceActiveStyle: C2ChoiceStyle(
              borderColor: Color.fromRGBO(56, 158, 13, 1),
              color: AppColors.black,
              labelStyle: TextStyle(
                fontWeight: FontWeight.bold
              )
            ),
            spacing: 30,
            runSpacing: 10,
            wrapped: true,
            ),
            
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomButton(
                  onTap: (){},
                  btnText: 'Back',
                  width: 80.0,
                  height: 36.0,
                  btnColor: AppColors.white,
                  fontColor: AppColors.black,
                  borderColor: AppColors.primary,
                  radius: 3.0,
                ),
                const SizedBox(width: 16.0),
                CustomButton(
                  onTap: (){
                    //Get.to(const ProfileSetupTwoScreen());
                    print(doctor_sp);
                  },
                  btnText: 'Submit',
                  width: 80.0,
                  height: 36.0,
                  btnColor: AppColors.secondary,
                  fontColor: AppColors.white,
                  borderColor: AppColors.secondary,
                  radius: 3.0,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
