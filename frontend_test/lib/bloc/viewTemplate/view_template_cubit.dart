import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:frontend_test/helpers/api_repositary.dart';
import 'package:frontend_test/models/template.dart';

part 'view_template_state.dart';

class ViewTemplateCubit extends Cubit<ViewTemplateState> {
  final ApiRepository apiRepository;
  ViewTemplateCubit({required this.apiRepository})
      : super(ViewTemplateInitial());

  Future<void> FetchSpecificTemplates(String id) async {
    emit(ViewTemplateLoading());
    try {
      final Templates? template = await apiRepository.getSpecificTemplate(id);
      if (template != null) {
        emit(ViewTemplateLoaded(template: template));
      }
    } on SocketException catch (err) {
      emit(const ViewTemplateError(message: "No Internet Connection"));
    } catch (err) {
      emit(ViewTemplateError(message: '$err'));
      rethrow;
    }
  }
}
