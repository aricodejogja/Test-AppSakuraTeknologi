import 'dart:io';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../cubit/add_event/add_event_cubit.dart';

class AddEventPage extends StatefulWidget {
  const AddEventPage({super.key});

  @override
  State<AddEventPage> createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  DateTime? selectedDate;
  TimeOfDay? selectedStartTime;
  TimeOfDay? selectedEndTime;

  final TextEditingController title = TextEditingController();
  final TextEditingController description = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    if (Platform.isAndroid) {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate ?? DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2050),
      );

      if (picked != null && picked != selectedDate) {
        setState(() {
          selectedDate = picked;
        });
      }
    } else if (Platform.isIOS) {
      final DateTime? picked = await showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) {
          return Container(
            color: Colors.white,
            height: 300.0,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: selectedDate ?? DateTime.now(),
              minimumYear: DateTime.now().year,
              maximumYear: 2050,
              onDateTimeChanged: (DateTime newDate) {
                setState(() {
                  selectedDate = newDate;
                });
              },
            ),
          );
        },
      );

      if (picked != null && picked != selectedDate) {
        setState(() {
          selectedDate = picked;
        });
      }
    }
  }

  Future<void> _selectStartTime(BuildContext context) async {
    if (Platform.isAndroid) {
      final TimeOfDay? picked = await showTimePicker(
        initialEntryMode: TimePickerEntryMode.input,
        context: context,
        initialTime: selectedStartTime ?? TimeOfDay.now(),
      );
      if (picked != null && picked != selectedStartTime) {
        setState(() {
          selectedStartTime = picked;
        });
      }
    } else if (Platform.isIOS) {
      final TimeOfDay? picked = await showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) {
          return Container(
            color: Colors.white,
            height: 300.0,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.time,
              initialDateTime: DateTime(
                DateTime.now().year,
                DateTime.now().month,
                DateTime.now().day,
                selectedStartTime?.hour ?? DateTime.now().hour,
                selectedStartTime?.minute ?? DateTime.now().minute,
              ),
              onDateTimeChanged: (DateTime newTime) {
                setState(() {
                  selectedStartTime = TimeOfDay.fromDateTime(newTime);
                });
              },
            ),
          );
        },
      );

      if (picked != null && picked != selectedStartTime) {
        setState(() {
          selectedStartTime = picked;
        });
      }
    }
  }

  Future<void> _selectEndTime(BuildContext context) async {
    if (Platform.isAndroid) {
      final TimeOfDay? picked = await showTimePicker(
        initialEntryMode: TimePickerEntryMode.input,
        context: context,
        initialTime: selectedEndTime ?? TimeOfDay.now(),
      );
      if (picked != null && picked != selectedEndTime) {
        setState(() {
          selectedEndTime = picked;
        });
      }
    } else if (Platform.isIOS) {
      final TimeOfDay? picked = await showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) {
          return Container(
            color: Colors.white,
            height: 300.0,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.time,
              initialDateTime: DateTime(
                DateTime.now().year,
                DateTime.now().month,
                DateTime.now().day,
                selectedEndTime?.hour ?? DateTime.now().hour,
                selectedEndTime?.minute ?? DateTime.now().minute,
              ),
              onDateTimeChanged: (DateTime newTime) {
                setState(() {
                  selectedEndTime = TimeOfDay.fromDateTime(newTime);
                });
              },
            ),
          );
        },
      );

      if (picked != null && picked != selectedEndTime) {
        setState(() {
          selectedEndTime = picked;
        });
      }
    }
  }

  int generateRandomId() {
    Random random = Random();
    return random.nextInt(999999);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Create New Event',
          style: GoogleFonts.inter(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
            child: Column(
              children: [
                TextFormField(
                  controller: title,
                  keyboardType: TextInputType.text,
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 12.sp,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Title tidak boleh kosing';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "Event Title",
                    labelText: "Event Title",
                    hintStyle: GoogleFonts.poppins(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 12.sp,
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide(
                            width: 2,
                            color: Colors.deepPurpleAccent.withOpacity(0.5))),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide(
                            width: 2,
                            color: Colors.deepPurpleAccent.withOpacity(0.5))),
                    contentPadding: EdgeInsets.only(left: 10.w),
                    helperStyle: GoogleFonts.poppins(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Tanggal lahir tidak boleh kosong.';
                    }
                    return null;
                  },
                  onTap: () => _selectDate(context),
                  controller: TextEditingController(
                    text: selectedDate == null
                        ? ''
                        : DateFormat('dd/MM/yyyy').format(selectedDate!),
                  ),
                  readOnly: true,
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 12.sp,
                  ),
                  decoration: InputDecoration(
                    hintText: "Select Date",
                    labelText: "Select Date",
                    hintStyle: GoogleFonts.poppins(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 12.sp,
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide(
                            width: 2,
                            color: Colors.deepPurpleAccent.withOpacity(0.5))),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide(
                            width: 2,
                            color: Colors.deepPurpleAccent.withOpacity(0.5))),
                    contentPadding: EdgeInsets.only(left: 10.w),
                    helperStyle: GoogleFonts.poppins(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return '';
                          }
                          return null;
                        },
                        onTap: () => _selectStartTime(context),
                        controller: TextEditingController(
                          text: selectedStartTime == null
                              ? ''
                              : DateFormat('HH:mm').format(
                                  DateTime(
                                    DateTime.now().year,
                                    DateTime.now().month,
                                    DateTime.now().day,
                                    selectedStartTime!.hour,
                                    selectedStartTime!.minute,
                                  ),
                                ),
                        ),
                        readOnly: true,
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 12.sp,
                        ),
                        decoration: InputDecoration(
                          hintText: "Start Time",
                          labelText: "Start Time",
                          filled: true,
                          hintStyle: GoogleFonts.poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 12.sp,
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.r),
                              borderSide: BorderSide(
                                  width: 2,
                                  color: Colors.deepPurpleAccent
                                      .withOpacity(0.5))),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.r),
                              borderSide: BorderSide(
                                  width: 2,
                                  color: Colors.deepPurpleAccent
                                      .withOpacity(0.5))),
                          contentPadding: EdgeInsets.only(left: 10.w),
                          helperStyle: GoogleFonts.poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return '';
                          }
                          return null;
                        },
                        onTap: () => _selectEndTime(context),
                        controller: TextEditingController(
                          text: selectedEndTime == null
                              ? ''
                              : DateFormat('HH:mm').format(
                                  DateTime(
                                    DateTime.now().year,
                                    DateTime.now().month,
                                    DateTime.now().day,
                                    selectedEndTime!.hour,
                                    selectedEndTime!.minute,
                                  ),
                                ),
                        ),
                        readOnly: true,
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 12.sp,
                        ),
                        decoration: InputDecoration(
                          hintText: "End Time",
                          labelText: "End Time",
                          filled: true,
                          hintStyle: GoogleFonts.poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 12.sp,
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.r),
                              borderSide: BorderSide(
                                  width: 2,
                                  color: Colors.deepPurpleAccent
                                      .withOpacity(0.5))),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.r),
                              borderSide: BorderSide(
                                  width: 2,
                                  color: Colors.deepPurpleAccent
                                      .withOpacity(0.5))),
                          contentPadding: EdgeInsets.only(left: 10.w),
                          helperStyle: GoogleFonts.poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                TextFormField(
                  controller: description,
                  keyboardType: TextInputType.text,
                  maxLength: 10000,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Tanggal lahir tidak boleh kosong.';
                    }
                    return null;
                  },
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 12.sp,
                  ),
                  decoration: InputDecoration(
                    hintText: "Event Descrptions",
                    labelText: "Event Description",
                    hintStyle: GoogleFonts.poppins(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 12.sp,
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide(
                            width: 2,
                            color: Colors.deepPurpleAccent.withOpacity(0.5))),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide(
                            width: 2,
                            color: Colors.deepPurpleAccent.withOpacity(0.5))),
                    contentPadding: EdgeInsets.only(left: 10.w),
                    helperStyle: GoogleFonts.poppins(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  children: [
                    Text(
                      'Event Color:',
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    ClipOval(
                      child: Material(
                        color: Colors.blue,
                        child: InkWell(
                          onTap: () {},
                          child: const SizedBox(
                            width: 30,
                            height: 30,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                SizedBox(
                  width: 200,
                  height: 40.h,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Colors.deepPurpleAccent.withOpacity(0.5),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r))),
                    onPressed: () {
                      if (selectedDate != null &&
                          selectedStartTime != null &&
                          selectedEndTime != null) {
                        int randomId = generateRandomId();
                        context.read<AddEventCubit>().add(
                            randomId,
                            title.text,
                            DateFormat('d-MM-yyyy').format(selectedDate!),
                            DateFormat('HH:mm').format(DateTime(
                                DateTime.now().year,
                                DateTime.now().month,
                                DateTime.now().day,
                                selectedStartTime!.hour,
                                selectedStartTime!.minute)),
                            DateFormat('HH:mm').format(DateTime(
                                DateTime.now().year,
                                DateTime.now().month,
                                DateTime.now().day,
                                selectedEndTime!.hour,
                                selectedEndTime!.minute)),
                            description.text,
                            0,
                            0,
                            255,
                            255);
                      }
                    },
                    child: BlocConsumer<AddEventCubit, AddEventState>(
                      listener: (context, state) {
                        if (state is AddEventSuccess) {
                          final snackBar = SnackBar(
                            content: Text(
                              state.msg,
                              style: GoogleFonts.poppins(
                                  fontSize: 12.sp, color: Colors.white),
                            ),
                            backgroundColor: Colors.green,
                            action: SnackBarAction(
                              label: 'Close',
                              textColor: Colors.amber,
                              onPressed: () {},
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      },
                      builder: (context, state) {
                        if (state is AddEventLoading) {
                          return Row(
                            children: [
                              const SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: Center(
                                      child: CircularProgressIndicator())),
                              SizedBox(
                                width: 10.w,
                              ),
                              Text("Add Event",
                                  style: GoogleFonts.poppins(
                                    fontSize: 14.sp,
                                    color: Colors.white,
                                  ))
                            ],
                          );
                        }
                        return Text(
                          "Add Event",
                          style: GoogleFonts.poppins(
                            fontSize: 14.sp,
                            color: Colors.white,
                          ),
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
