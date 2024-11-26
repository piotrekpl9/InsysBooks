import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:insys_books/core/consts/app_consts.dart';

class HttpClient {
  final Dio dio;
  final String googleApiKey;
  HttpClient()
      : dio = Dio(BaseOptions(baseUrl: AppConsts.apiURL)),
        googleApiKey = dotenv.env['GOOGLE_API_KEY'] ?? '';
}
