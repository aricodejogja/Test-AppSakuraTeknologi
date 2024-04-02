part of 'get_event_cubit.dart';

abstract class GetEventState extends Equatable {
  const GetEventState();

  @override
  List<Object> get props => [];
}

class GetEventInitial extends GetEventState {}

class GetEventLoading extends GetEventState {}

class GetEventSuccess extends GetEventState {
  const GetEventSuccess(this.data);
  final List<EventModel> data;
}

class GetEventError extends GetEventState {
  const GetEventError(this.msg);
  final String msg;
}
