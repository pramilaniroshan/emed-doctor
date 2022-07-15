import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

import '../config/constants.dart';
import '../controller/doctorController.dart';

late SharedPreferences prefs;
final DoctorController doctorController = Get.put(DoctorController());

void getDoctorProfile() async {
  prefs = await SharedPreferences.getInstance();
  String token = prefs.getString("token") ?? '';
  try {
    var dio = Dio();
    dio.options.headers["authorization"] = "Bearer " + token;
    await dio
        .get(
      Constants().getBaseUrl() + '/Doctor',
    )
        .then((res) {
      if (prefs.getString("token") != null) {
        //prefs.setString('FirstName', res.data['Data']['FirstName']);
        doctorController.setFirstname(res.data['Data']['FirstName']);
        doctorController.setDescription(res.data['Data']['Description']);
        doctorController.setEmail(res.data['Data']['Email']);
        doctorController.setLastName('Niroshan');
        doctorController.setId(res.data['Data']['Id']);
        doctorController.setTitle(res.data['Data']['Title']);
        doctorController.setNationalIdentificationNumber(
            res.data['Data']['NationalIdentificationNumber']);

        doctorController.setAddress(res.data['Data']['Address']);
        doctorController.setGovDoctorRegNo(res.data['Data']['GovDoctorRegNo']);
        doctorController.setPhoneNumber(res.data['Data']['PhoneNumber']);
        // prefs.setString('Id', res.data['Data']['Id']);
        // prefs.setString('Title', res.data['Data']['Title']);
        // prefs.setString('LastName', res.data['Data']['LastName']);
        // prefs.setString('NationalIdentificationNumber',
        //     res.data['Data']['NationalIdentificationNumber']);
        // prefs.setString('Address', res.data['Data']['Address']);
        // prefs.setString('GovDoctorRegNo', res.data['Data']['GovDoctorRegNo']);
        // prefs.setString('NicFrontPicUrl', res.data['Data']['NicFrontPicUrl']);
        // prefs.setString('NicBackPicUrl', res.data['Data']['NicBackPicUrl']);
        // prefs.setString('GovDoctorIdentityPicFrontUrl',
        //     res.data['Data']['GovDoctorIdentityPicFrontUrl']);
        // prefs.setString('GovDoctorIdentityPicBackUrl',
        //     res.data['Data']['GovDoctorIdentityPicBackUrl']);
        // prefs.setString('VerifiedDate', res.data['Data']['VerifiedDate']);
        // prefs.setString('VerifiedById', res.data['Data']['VerifiedById']);
        // prefs.setString('PhoneNumber', res.data['Data']['PhoneNumber']);
        // prefs.setString('Email', res.data['Data']['Email']);
        // prefs.setString('Description', res.data['Data']['Description']);
        // //prefs.setString('DoctorSpecializations', res.data['Data']['DoctorSpecializations']);
        // prefs.setBool('IsVerified', res.data['Data']['IsVerified']);
        // prefs.setBool('IsActive', res.data['Data']['IsActive']);
        // prefs.setBool(
        //     'IsPhoneNumberVerified', res.data['Data']['IsPhoneNumberVerified']);
        // prefs.setBool('IsEmailVerified', res.data['Data']['IsEmailVerified']);
        // prefs.setBool('PhoneNumberVisibleToPatient',
        //     res.data['Data']['PhoneNumberVisibleToPatient']);
        // prefs.setInt('CityId', res.data['Data']['CityId'] ?? 0);
        // prefs.setString('user', jsonEncode(res.data['Data']).toString());
        //print(jsonEncode(res.data['Data']));
        print(res.data['Data']);
      }
    });
  } on DioError catch (e) {
    print(e.response!.data);
  }
}
