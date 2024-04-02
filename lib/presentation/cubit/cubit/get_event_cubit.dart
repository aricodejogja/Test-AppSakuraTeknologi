import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_sakura_test/data/models/event_model.dart';

import '../../../data/repository/event_repositori_impl.dart';

part 'get_event_state.dart';

class GetEventCubit extends Cubit<GetEventState> {
  GetEventCubit() : super(GetEventInitial());
  late final EventRepositoryIml _eventRepositoryIml = EventRepositoryIml();
  Future<void> get() async {
    final result = await _eventRepositoryIml.getDbEvent();
    result.fold(
      (failure) {
        emit(GetEventError(failure.message));
      },
      (data) {
        emit(GetEventSuccess(data));
      },
    );
  }
}
