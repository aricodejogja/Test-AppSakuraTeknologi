import 'package:flutter/material.dart';

import 'package:flutter_sakura_test/presentation/routes/route.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Calender View',
          style:
              GoogleFonts.inter(fontSize: 16.sp, fontWeight: FontWeight.bold),
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                context.goNamed(Routes.month);
              },
              child: Text(
                'Month View',
                style: GoogleFonts.inter(fontSize: 14.sp),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            ElevatedButton(
                onPressed: () {
                  context.goNamed(Routes.day);
                },
                child: Text(
                  'Day View',
                  style: GoogleFonts.inter(fontSize: 14.sp),
                )),
            SizedBox(
              height: 20.h,
            ),
            ElevatedButton(
                onPressed: () {
                  context.goNamed(Routes.week);
                },
                child: Text(
                  'Week View',
                  style: GoogleFonts.inter(fontSize: 14.sp),
                )),
          ],
        ),
      ),
    );
  }
}
