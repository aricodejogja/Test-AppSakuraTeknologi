import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import '../page/page.dart';

export 'package:go_router/go_router.dart';
part 'route_name.dart';

// GoRouter configuration
final router = GoRouter(
  debugLogDiagnostics: true,
  routerNeglect: true,
  initialLocation: "/",
  routes: [
    GoRoute(
      path: '/',
      name: Routes.main,
      builder: (context, state) => const HomePage(),
      routes: [
        GoRoute(
          path: 'month',
          name: Routes.month,
          builder: (context, state) => const MonthPage(),
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              key: state.pageKey,
              child: const MonthPage(),
              transitionDuration: const Duration(milliseconds: 500),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: CurveTween(curve: Curves.easeIn).animate(animation),
                  child: child,
                );
              },
            );
          },
        ),
        GoRoute(
          path: 'day',
          name: Routes.day,
          builder: (context, state) => const DayPage(),
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              key: state.pageKey,
              child: const DayPage(),
              transitionDuration: const Duration(milliseconds: 500),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: CurveTween(curve: Curves.easeIn).animate(animation),
                  child: child,
                );
              },
            );
          },
        ),
        GoRoute(
          path: 'week',
          name: Routes.week,
          builder: (context, state) => const WeekPage(),
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              key: state.pageKey,
              child: const WeekPage(),
              transitionDuration: const Duration(milliseconds: 500),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: CurveTween(curve: Curves.easeIn).animate(animation),
                  child: child,
                );
              },
            );
          },
        ),
      ],
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: const HomePage(),
          transitionDuration: const Duration(milliseconds: 500),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: CurveTween(curve: Curves.easeIn).animate(animation),
              child: child,
            );
          },
        );
      },
    ),
  ],
);
