import 'package:dio/dio.dart';

Future<Response> existingUserNameCheck(Dio dio, Map<String, dynamic> data) {
  return dio.post("/Registration/ExistingUserNameCheck", data : data);
}

