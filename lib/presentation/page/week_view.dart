import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../data/models/event_model.dart';
import '../cubit/cubit/get_event_cubit.dart';
import 'add_event_page.dart';

class WeekPage extends StatefulWidget {
  const WeekPage({super.key});

  @override
  State<WeekPage> createState() => _WeekPageState();
}

class _WeekPageState extends State<WeekPage> {
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
              return WeekView(
                  controller: EventController(),
                  eventTileBuilder: (date, events, boundry, start, end) {
                    // Return your widget to display as event tile.
                    return Container();
                  },
                  fullDayEventBuilder: (events, date) {
                    // Return your widget to display full day event view.
                    return Container();
                  },
                  showLiveTimeLineInAllDays:
                      true, // To display live time line in all pages in week view.
                  width: 400, // width of week view.
                  minDay: DateTime.now(),
                  maxDay: DateTime(2050),
                  initialDay: DateTime(2021),
                  heightPerMinute: 1, // height occupied by 1 minute time span.
                  eventArranger:
                      const SideEventArranger(), // To define how simultaneous events will be arranged.
                  onEventTap: (events, date) => print(events),
                  onDateLongPress: (date) => print(date),
                  startDay:
                      WeekDays.sunday, // To change the first day of the week.
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
