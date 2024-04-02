import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sakura_test/presentation/cubit/add_event/add_event_cubit.dart';
import 'package:flutter_sakura_test/presentation/cubit/cubit/get_event_cubit.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'presentation/routes/route.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  await initializeDateFormatting('id_ID', null)
      .then((_) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AddEventCubit>(
          create: (BuildContext context) => AddEventCubit(),
        ),
        BlocProvider<GetEventCubit>(
          create: (BuildContext context) => GetEventCubit(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 800),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp.router(
            routeInformationParser: router.routeInformationParser,
            routerDelegate: router.routerDelegate,
            routeInformationProvider: router.routeInformationProvider,
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
