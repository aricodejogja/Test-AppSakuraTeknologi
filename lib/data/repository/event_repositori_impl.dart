import 'package:flutter_sakura_test/data/models/event_model.dart';
import 'package:flutter_sakura_test/domain/entty/event_entty.dart';

import 'package:flutter_sakura_test/config/error/failure.dart';

import 'package:dartz/dartz.dart';

import '../../domain/repository/event_repositori.dart';
import '../datasource/database/db_remote_datasource.dart';

class EventRepositoryIml extends EventRepository {
  final EventDbDataSourceImpl _remoteDataSource = EventDbDataSourceImpl();

  @override
  Future<Either<Failure, String>> addDbEvent(EventEntitiy data) async {
    print(data);
    try {
      await _remoteDataSource.addCurentDbEvent({
        'id': data.id,
        'event_title': data.eventTitle,
        'selected_date': data.selectedDate,
        'start_time': data.startTime,
        'end_time': data.endTime,
        'descriptions': data.descriptions,
        'color_red': data.colorRed,
        'color_green': data.colorGreen,
        'color_blue': data.colorBlue,
        'color_alpha': data.colorAlpha
      });
      return const Right('Sucess');
    } catch (e) {
      return const Left(DatabaseFailure('no interenet conecttions'));
    }
  }

  @override
  Future<Either<Failure, String>> delDbEvent(String id) {
    // TODO: implement delDbEvent
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<EventModel>>> getDbEvent() async {
    try {
      final db = await _remoteDataSource.getCurentDbEvent();

      return Right(db);
    } catch (e) {
      return const Left(DatabaseFailure('no interenet conecttions'));
    }
  }

  @override
  Future<Either<Failure, String>> updateDbEvent(EventEntitiy data, String id) {
    // TODO: implement updateDbEvent
    throw UnimplementedError();
  }
}
