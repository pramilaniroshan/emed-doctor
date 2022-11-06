import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

import '../config/constants.dart';
import '../controller/doctorController.dart';

late SharedPreferences prefs;
final DoctorController doctorController = Get.put(DoctorController());
var image;

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

        getDoctorProfilePic(token,res.data['Data']['Id']);
      }
    });
  } on DioError catch (e) {
    print(e.response!.data);
  }
}

getDoctorProfilePic(String token, String id) async {
  var dio = Dio();
  dio.options.headers["authorization"] = "Bearer " + token;

  try {
    await dio
        .get(
            Constants().getBaseUrl() +
                '/Doctor/' + id + '/ProfilePicture',
            options: Options(responseType: ResponseType.bytes))
        .then((res) {
      print(res);
      image = Image.memory(
        res.data,
        // width: MediaQuery.of(context).size.width,
        // height: MediaQuery.of(context).size.height * 0.44,
        scale: 0.5,
      ).image;
      doctorController.setprofilePicture(image);
    });
  } on DioError catch (e) {
    print(e.response!.data);
  }
}
