part of 'add_event_cubit.dart';

abstract class AddEventState extends Equatable {
  const AddEventState();

  @override
  List<Object> get props => [];
}

class AddEventInitial extends AddEventState {}

class AddEventLoading extends AddEventState {}

class AddEventSuccess extends AddEventState {
  const AddEventSuccess(this.msg);
  final String msg;
}

class AddEventError extends AddEventState {
  const AddEventError(this.msg);
  final String msg;
}
