import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../data/models/event_model.dart';
import '../cubit/cubit/get_event_cubit.dart';
import 'add_event_page.dart';

class DayPage extends StatefulWidget {
  const DayPage({super.key});

  @override
  State<DayPage> createState() => _DayPageState();
}

class _DayPageState extends State<DayPage> {
  @override
  void initState() {
    context.read<GetEventCubit>().get();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AddEventPage()));
          },
          child: const Icon(Icons.add),
        ),
        body: BlocBuilder<GetEventCubit, GetEventState>(
          builder: (context, state) {
            if (state is GetEventSuccess) {
              return DayView(
                  controller: EventController(),
                  eventTileBuilder: (date, events, boundry, start, end) {
                    List<EventModel> filteredEvents = state.data.where((event) {
                      DateTime eventDate =
                          DateFormat('dd-MM-yyyy').parse(event.selectedDate);
                      return eventDate.day == date.day &&
                          eventDate.month == date.month &&
                          eventDate.year == date.year;
                    }).toList();

                    return Container(
                      width: 100,
                      height: 100,
                      color: Colors.amber,
                    );
                  },
                  fullDayEventBuilder: (events, date) {
                    // Return your widget to display full day event view.

                    return Column();
                  },
                  showVerticalLine:
                      true, // To display live time line in day view.
                  showLiveTimeLineInAllDays:
                      true, // To display live time line in all pages in day view.
                  minDay: DateTime.now(),
                  maxDay: DateTime(2050),
                  initialDay: DateTime(2021),
                  heightPerMinute: 1, // height occupied by 1 minute time span.
                  eventArranger:
                      SideEventArranger(), // To define how simultaneous events will be arranged.
                  onEventTap: (events, date) => print(events),
                  onDateLongPress: (date) => print(date),
                  startHour: 5 // To set the first hour displayed (ex: 05:00)

                  );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }
}
