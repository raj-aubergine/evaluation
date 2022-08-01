part of 'template_cubit.dart';

@immutable
abstract class TemplateState extends Equatable {
  const TemplateState();
  @override
  List<Object> get props => [];
}

class TemplateInitial extends TemplateState {}

class TemplateLoading extends TemplateState {}

class TemplateLoaded extends TemplateState {
  final List<Templates> templates;
  const TemplateLoaded({required this.templates});
  @override
  List<Object> get props => [templates];
}

class TemplateError extends TemplateState {
  final String message;
  const TemplateError({required this.message});
  @override
  List<Object> get props => [message];
}
