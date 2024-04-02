import 'package:equatable/equatable.dart';

class EventEntitiy extends Equatable {
  final int id;
  final String eventTitle;
  final String selectedDate;
  final String startTime;
  final String endTime;
  final String descriptions;
  final int colorRed;
  final int colorGreen;
  final int colorBlue;
  final int colorAlpha;

  const EventEntitiy({
    required this.id,
    required this.eventTitle,
    required this.selectedDate,
    required this.startTime,
    required this.endTime,
    required this.descriptions,
    required this.colorRed,
    required this.colorGreen,
    required this.colorBlue,
    required this.colorAlpha,
  });

  @override
  List<Object?> get props => [
        id,
        eventTitle,
        selectedDate,
        startTime,
        endTime,
        descriptions,
        colorRed,
        colorGreen,
        colorBlue,
        colorAlpha,
      ];
}
