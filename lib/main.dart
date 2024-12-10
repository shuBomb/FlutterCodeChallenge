import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() {
  String initialRoute;
  initialRoute = Routes.HOME;

  runApp(MyApp(initialRoutes: initialRoute));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.initialRoutes});

  final String initialRoutes;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge, overlays: []);


    return GetMaterialApp(
      title: 'Code Challenge',
      debugShowCheckedModeBanner: false,

      initialRoute: widget.initialRoutes,
      getPages: AppPages.pages,


    );
  }
}