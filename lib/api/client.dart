import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

Logger logger = Logger();

Dio client() {
  Dio dio = Dio();

  dio.options.headers["Authorization"] = "some auth key";

  dio.options.baseUrl =
      "https://localhost:5001/api/v1";
  dio.options.connectTimeout = 10000;
  // dio.interceptors.add(
  //   InterceptorsWrapper(
  //       onRequest: (RequestOptions options) => requestInterceptor(options),
  //       onResponse: (Response response) => responseInterceptor(response),
  //       onError: (DioError error) => errorInterceptor(error)),
  // );

  return dio;
}

requestInterceptor(RequestOptions options) {
  logger.d(options);
  return options;
}

responseInterceptor(Response response) {
  logger.d(response.data);
  return response;
}

errorInterceptor(DioError error) {
  logger.d(error.error);
  logger.d(error.message);
  return error;
}
