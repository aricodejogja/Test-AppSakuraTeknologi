import 'package:dartz/dartz.dart';
import 'package:flutter_sakura_test/data/models/event_model.dart';
import 'package:flutter_sakura_test/domain/entty/event_entty.dart';
import '../../config/error/failure.dart';

abstract class EventRepository {
  Future<Either<Failure, List<EventModel>>> getDbEvent();
  Future<Either<Failure, String>> addDbEvent(EventEntitiy data);
  Future<Either<Failure, String>> updateDbEvent(EventEntitiy data, String id);
  Future<Either<Failure, String>> delDbEvent(String id);
}
