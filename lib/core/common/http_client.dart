import 'package:dio/dio.dart';
import 'package:insys_books/core/consts/app_consts.dart';

class HttpClient {
  final Dio dio;
  HttpClient() : dio = Dio(BaseOptions(baseUrl: AppConsts.apiURL));
}
