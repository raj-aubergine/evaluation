part of 'view_template_cubit.dart';

abstract class ViewTemplateState extends Equatable {
  const ViewTemplateState();

  @override
  List<Object> get props => [];
}

class ViewTemplateInitial extends ViewTemplateState {}

class ViewTemplateLoading extends ViewTemplateState {}

class ViewTemplateLoaded extends ViewTemplateState {
  final Templates template;
  const ViewTemplateLoaded({required this.template});
  @override
  List<Object> get props => [template];
}

class ViewTemplateError extends ViewTemplateState {
  final String message;
  const ViewTemplateError({required this.message});
  @override
  List<Object> get props => [message];
}
