import '../../domain/entty/event_entty.dart';

class EventModel extends EventEntitiy {
  const EventModel({
    required int id,
    required String eventTitle,
    required String selectedDate,
    required String startTime,
    required String endTime,
    required String descriptions,
    required int colorRed,
    required int colorGreen,
    required int colorBlue,
    required int colorAlpha,
  }) : super(
            id: id,
            eventTitle: eventTitle,
            selectedDate: selectedDate,
            startTime: startTime,
            endTime: endTime,
            descriptions: descriptions,
            colorRed: colorRed,
            colorGreen: colorGreen,
            colorBlue: colorBlue,
            colorAlpha: colorAlpha);

  factory EventModel.fromJson(Map<String, dynamic> json) => EventModel(
      id: json['id'],
      eventTitle: json['event_title'],
      selectedDate: json['selected_date'],
      startTime: json['start_time'],
      endTime: json['end_time'],
      descriptions: json['descriptions'],
      colorRed: json['color_red'],
      colorGreen: json['color_green'],
      colorBlue: json['color_blue'],
      colorAlpha: json['color_alpha']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'event_title': eventTitle,
        'selected_date': selectedDate,
        'start_time': startTime,
        'end_time': endTime,
        'descriptions': descriptions,
        'color_red': colorRed,
        'color_green': colorGreen,
        'color_blue': colorBlue,
        'color_alpha': colorAlpha,
      };

  EventEntitiy toEntitiy() => EventEntitiy(
      id: id,
      eventTitle: eventTitle,
      selectedDate: selectedDate,
      startTime: startTime,
      endTime: endTime,
      descriptions: descriptions,
      colorRed: colorRed,
      colorGreen: colorGreen,
      colorBlue: colorBlue,
      colorAlpha: colorAlpha);
}
