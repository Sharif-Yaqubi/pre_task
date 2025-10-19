import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pre_interview_task/screen/dashboard_screen.dart';
import 'package:pre_interview_task/routes/route_name.dart';
import 'package:pre_interview_task/routes/routes.dart';

class NavigationService {
  const NavigationService._();
  static final rootNavigatorKey = GlobalKey<NavigatorState>();
}

class RouteConfig {
  const RouteConfig._();
  static route() => GoRouter(
    navigatorKey: NavigationService.rootNavigatorKey,
    initialLocation: '/',
    routes: [
      GoRoute(
        path: Routes.introductionScreen,
        name: RouteName.introductionScreen,
        builder: (context, state) => DashboardScreen(),
      ),
    ],
  );
}
