import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:frontend_test/api_constrain.dart';

class ApiService {
  final Dio _dio = Dio();
  Future<Response?> getAllTemplateApi() async {
    try {
      final Response response = await _dio.get(
        'https://us-central1-prashil-template-maker.cloudfunctions.net/template?token=${API_TOKEN}',
      );
      log(response.statusCode.toString());
      return response;
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<Response?> getSpecificTemplateApi(String id) async {
    try {
      final Response response = await _dio.get(
        'https://us-central1-prashil-template-maker.cloudfunctions.net/template/${id}?token=${API_TOKEN}',
      );
      log(response.statusCode.toString());
      return response;
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<Response?> postAddTemplateApi(dynamic data) async {
    try {
      final Response response = await _dio.post(
        'https://us-central1-prashil-template-maker.cloudfunctions.net/template?token=${API_TOKEN}',
        data: data,
      );
      log(response.statusCode.toString());
      return response;
    } catch (e) {
      print(e);
    }
    return null;
  }
}
