import 'dart:developer';

import 'package:frontend_test/helpers/api_service.dart';
import 'package:frontend_test/models/template.dart';

class ApiRepository {
  final ApiService apiService;
  const ApiRepository({required this.apiService});

  Future<List<Templates>?> getTemplateList() async {
    final response = await apiService.getAllTemplateApi();
    if (response != null) {
      final data = response.data as List;
      final templates =
          data.map((template) => Templates.fromJson(template)).toList();
      return templates;
    }
    return null;
  }

  Future<Templates?> getSpecificTemplate(String id) async {
    final response = await apiService.getSpecificTemplateApi(id);
    if (response != null) {
      final data = response.data as List;
      final templates =
          data.map((template) => Templates.fromJson(template)).toList();
      final specificTemplate = templates[0];
      return specificTemplate;
    }
    return null;
  }

  Future<bool?> addTemplate(dynamic data) async {
    final response = await apiService.postAddTemplateApi(data);
    log('${response?.statusCode}');
    if (response!.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }
}
