import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/repository/event_repositori_impl.dart';
import '../../../domain/entty/event_entty.dart';

part 'add_event_state.dart';

class AddEventCubit extends Cubit<AddEventState> {
  AddEventCubit() : super(AddEventInitial());

  late final EventRepositoryIml _eventRepositoryIml = EventRepositoryIml();
  Future<void> add(
    int id,
    String eventTitle,
    String selectedDate,
    String startTime,
    String endTime,
    String descriptions,
    int colorRed,
    int colorGreen,
    int colorBlue,
    int colorAlpha,
  ) async {
    emit(AddEventLoading());
    final result = await _eventRepositoryIml.addDbEvent(EventEntitiy(
        id: id,
        eventTitle: eventTitle,
        selectedDate: selectedDate,
        startTime: startTime,
        endTime: endTime,
        descriptions: descriptions,
        colorRed: colorRed,
        colorGreen: colorGreen,
        colorBlue: colorBlue,
        colorAlpha: colorAlpha));
    result.fold(
      (failure) {
        emit(AddEventError(failure.message));
      },
      (data) {
        emit(AddEventSuccess(data));
      },
    );
  }
}
