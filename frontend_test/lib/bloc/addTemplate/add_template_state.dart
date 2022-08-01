part of 'add_template_cubit.dart';

abstract class AddTemplateState extends Equatable {
  const AddTemplateState();

  @override
  List<Object> get props => [];
}

class AddTemplateInitial extends AddTemplateState {}

class AddTemplateLoading extends AddTemplateState {}

class AddTemplateSuccess extends AddTemplateState {
  final String message;
  const AddTemplateSuccess({required this.message});
  @override
  List<Object> get props => [message];
}

class AddTemplateError extends AddTemplateState {
  final String message;
  const AddTemplateError({required this.message});
  @override
  List<Object> get props => [message];
}
