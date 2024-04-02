import 'package:flutter/material.dart';

import '../../extension.dart';
import '../day_view_page.dart';
import '../month_view_page.dart';
import '../week_view_page.dart';

class MobileHomePage extends StatelessWidget {
  const MobileHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Calendar Page"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () => context.pushRoute(const MonthViewPageDemo()),
              child: const Text("Month View"),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () => context.pushRoute(const DayViewPageDemo()),
              child: const Text("Day View"),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () => context.pushRoute(const WeekViewDemo()),
              child: const Text("Week View"),
            ),
          ],
        ),
      ),
    );
  }
}
