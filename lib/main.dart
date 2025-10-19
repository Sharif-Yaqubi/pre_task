
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pre_interview_task/routes/route_config.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
    late final GoRouter router;
    @override
  void initState() {
    super.initState();
    router = RouteConfig.route();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Pre Interview',
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
