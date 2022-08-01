import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:frontend_test/helpers/api_repositary.dart';

part 'add_template_state.dart';

class AddTemplateCubit extends Cubit<AddTemplateState> {
  final ApiRepository apiRepository;
  AddTemplateCubit({required this.apiRepository}) : super(AddTemplateInitial());

  Future<void> addTemplate(dynamic data) async {
    emit(AddTemplateLoading());
    try {
      final bool? user = await apiRepository.addTemplate(data);
      if (user!) {
        emit(AddTemplateSuccess(message: "Sucessfully added"));
      }
    } on SocketException catch (err) {
      emit(const AddTemplateError(message: "No Internet Connection"));
    } catch (err) {
      emit(AddTemplateError(message: '$err'));
      rethrow;
    }
  }
}
