import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_test/helpers/api_repositary.dart';
import 'package:frontend_test/models/template.dart';

part 'template_state.dart';

class TemplateCubit extends Cubit<TemplateState> {
  final ApiRepository apiRepository;
  TemplateCubit({required this.apiRepository}) : super(TemplateInitial());

  Future<void> FetchAllTemplates() async {
    emit(TemplateLoading());
    try {
      final List<Templates>? templateList =
          await apiRepository.getTemplateList();
      if (templateList != null) {
        emit(TemplateLoaded(templates: templateList));
      }
    } on SocketException catch (err) {
      emit(const TemplateError(message: "No Internet Connection"));
    } catch (err) {
      emit(TemplateError(message: '$err'));
      rethrow;
    }
  }
}
