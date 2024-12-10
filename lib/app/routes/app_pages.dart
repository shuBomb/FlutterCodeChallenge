import 'package:get/get.dart';

import '../modules/home_module/home_binding.dart';
import '../modules/home_module/home_screen.dart';

part './app_routes.dart';


abstract class AppPages {
  static final pages = [

    GetPage(
      name: Routes.HOME,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),

  ];
}
