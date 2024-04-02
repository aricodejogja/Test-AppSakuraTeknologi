import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sakura_test/data/models/event_model.dart';
import 'package:flutter_sakura_test/presentation/cubit/cubit/get_event_cubit.dart';
import 'package:flutter_sakura_test/presentation/page/page.dart';
import 'package:flutter_sakura_test/presentation/routes/route.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class MonthPage extends StatefulWidget {
  const MonthPage({super.key});

  @override
  State<MonthPage> createState() => _MonthPageState();
}

class _MonthPageState extends State<MonthPage> {
  EventController eventController = EventController();
  GlobalKey<MonthViewState> myWidgetKey = GlobalKey<MonthViewState>();
  DateTime dateTitelPage = DateTime.now();
  int indexPage = 0;
  @override
  void initState() {
    context.read<GetEventCubit>().get();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xffDFEFFF),
          leading: IconButton(
              onPressed: () {
                if (indexPage != 0) {
                  myWidgetKey.currentState!.previousPage();
                } else {
                  context.pop();
                }
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
          actions: [
            IconButton(
                onPressed: () {
                  myWidgetKey.currentState!.nextPage();
                },
                icon: const Icon(
                  Icons.arrow_forward,
                  color: Colors.black,
                ))
          ],
          centerTitle: true,
          title: Text(
            "${dateTitelPage.month}-${dateTitelPage.year}",
            style: GoogleFonts.inter(
                fontSize: 16.sp,
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
        ),
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
              return MonthView(
                  key: myWidgetKey,
                  controller: eventController,
                  // to provide custom UI for month cells.
                  cellBuilder: (date, events, isToday, isInMonth) {
                    // Return your widget to display as month cell.

                    Color cellColor = date.month == dateTitelPage.month
                        ? Colors.white
                        : Colors.grey.withOpacity(0.5);

                    List<EventModel> filteredEvents = state.data.where((event) {
                      DateTime eventDate =
                          DateFormat('dd-MM-yyyy').parse(event.selectedDate);
                      return eventDate.day == date.day &&
                          eventDate.month == date.month &&
                          eventDate.year == date.year;
                    }).toList();

                    return Container(
                      color: cellColor,
                      child: Column(
                        children: [
                          if (isToday)
                            ClipOval(
                              child: Container(
                                  width: 25,
                                  height: 25,
                                  padding: const EdgeInsets.all(5),
                                  color: Colors.blue,
                                  child: Center(
                                    child: Text(
                                      date.day.toString(),
                                      style: GoogleFonts.inter(
                                          fontSize: 10.sp, color: Colors.white),
                                    ),
                                  )),
                            ),
                          if (!isToday)
                            Text(
                              date.day.toString(),
                              style: GoogleFonts.inter(
                                  fontSize: 10.sp, color: Colors.black),
                            ),
                          Column(
                            children: filteredEvents.take(3).map((event) {
                              return Container(
                                margin: EdgeInsets.only(
                                  top: 8.h,
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 4.w, vertical: 4.h),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.r),
                                    color: Color.fromARGB(
                                      event.colorAlpha,
                                      event.colorRed,
                                      event.colorGreen,
                                      event.colorGreen,
                                    )),
                                child: Text(
                                  event.eventTitle,
                                  maxLines: 1,
                                  style: GoogleFonts.inter(
                                      fontSize: 8.sp, color: Colors.white),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    );
                  },
                  minMonth: DateTime.now(),
                  maxMonth: DateTime(2050),
                  initialMonth: DateTime(2021),
                  cellAspectRatio: 0.5,
                  onPageChange: (date, pageIndex) {
                    setState(() {
                      dateTitelPage = date;
                      indexPage = pageIndex;
                    });
                    print(Colors.amber);
                  },
                  onCellTap: (events, date) {
                    // Implement callback when user taps on a cell.
                    print(events);
                  },
                  startDay:
                      WeekDays.sunday, // To change the first day of the week.
                  // This callback will only work if cellBuilder is null.
                  onEventTap: (event, date) => print(event),
                  onDateLongPress: (date) => print(date),
                  headerBuilder: MonthHeader.hidden // To hide month header
                  );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }
}
