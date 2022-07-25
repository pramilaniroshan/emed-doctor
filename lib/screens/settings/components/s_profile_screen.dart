import 'package:emedassistantmobile/services/get_doctor_profile.dart';
import 'package:emedassistantmobile/widgets/toast.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:emedassistantmobile/config/app_colors.dart';
import 'package:emedassistantmobile/config/app_images.dart';
import '../../../config/constants.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/toast.dart';

class SProfileScreen extends StatefulWidget {
  final String? des;
  final String? profPicUrl;

  const SProfileScreen({Key? key, this.des, required this.profPicUrl})
      : super(key: key);

  @override
  State<SProfileScreen> createState() => _SProfileScreenState();
}

class _SProfileScreenState extends State<SProfileScreen> {
  TextEditingController profileDescController = TextEditingController();
  late SharedPreferences prefs;
  FToast? fToast;

  void doctorUpdateProfileInfo() async {
    print('Search Doctor');
    prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token") ?? '';
    print(token);
    try {
      var dio = Dio();
      dio.options.headers["authorization"] = "Bearer " + token;
      await dio
          .post(Constants().getBaseUrl() + '/Doctor/UpdateProfileInfo', data: {
        "Description": profileDescController.text,
        "ProfilePicture": 'null',
      }).then((res) {
        getDoctorProfile();
        //showErrorToast(fToast: fToast, isError: false, msg: 'Done');
        print(res.data);
      });
    } on DioError catch (e) {
      //showErrorToast(
      // fToast: fToast, isError: true, msg: e.response!.data['Error']);
      print(e.response!.data['Error']);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fToast = FToast();
    fToast!.init(context);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      physics: const ScrollPhysics(),
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
            const Text(
              'Profile description',
              style: TextStyle(
                fontSize: 18.0,
                color: AppColors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Please add a brief description of your competences and your '
              'professional career.',
              style: TextStyle(
                fontSize: 16.0,
                color: AppColors.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 16.0),
            Container(
              width: width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2.0),
                color: AppColors.white,
                border: Border.all(
                  color: AppColors.primary,
                  width: 1.0,
                ),
              ),
              child: TextFormField(
                maxLines: 22,
                controller: profileDescController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(
                    left: 16.0,
                    top: 16.0,
                    right: 16.0,
                  ),
                  hintText: widget.des,
                  hintStyle: TextStyle(
                    fontSize: 15.0,
                    color: AppColors.black,
                    fontWeight: FontWeight.w500,
                    height: 1.5,
                    letterSpacing: 0.3,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 40.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Profile Picture \n(.jpg .png .pdf - max 5mb)',
                  style: TextStyle(
                    fontSize: 15.0,
                    color: AppColors.lightBlack,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Material(
                  child: InkWell(
                    onTap: () async {
                      try {
                        FilePickerResult? result =
                            await FilePicker.platform.pickFiles(
                          type: FileType.custom,
                          allowedExtensions: ['jpg', 'png'],
                        );
                        if (result != null) {
                          final file = result.files.first;

                          print(file.name);
                        } else {
                          // User canceled the picker
                        }
                      } catch (e) {
                        print(e);
                      }
                    },
                    borderRadius: BorderRadius.circular(4.0),
                    child: Ink(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 8.0),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(4.0),
                        border: Border.all(
                          color: AppColors.primary,
                          width: 1.5,
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(Icons.upload_outlined,
                              color: AppColors.black, size: 20.0),
                          SizedBox(width: 8.0),
                          Text(
                            'Click to Upload',
                            style: TextStyle(
                              fontSize: 14.0,
                              color: AppColors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            /// me.png image
            const SizedBox(height: 8.0),
            Container(
              width: width,
              padding:
                  const EdgeInsets.only(left: 8.0, bottom: 12.0, top: 12.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.primary,
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    AppImages.frontSideImage,
                    height: 40.0,
                    width: 60.0,
                    fit: BoxFit.fill,
                  ),
                  const SizedBox(width: 8.0),
                  const Expanded(
                    child: Text(
                      'me.png',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: AppColors.secondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.delete_outline,
                        color: AppColors.primary),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomButton(
                  onTap: () {},
                  btnText: 'Cancel',
                  width: 80.0,
                  height: 36.0,
                  btnColor: AppColors.white,
                  fontColor: AppColors.black,
                  borderColor: AppColors.primary,
                  radius: 3.0,
                ),
                const SizedBox(width: 16.0),
                CustomButton(
                  onTap: () {
                    doctorUpdateProfileInfo();
                  },
                  btnText: 'Update',
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
