import 'package:code_challenge/app/modules/favorite_module/favorite_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../search_module/search_screen.dart';
import '../shopping/shoppin_screen.dart';

class HomeController extends GetxController {
  var selectedIndex = 0.obs;

  List<dynamic> widgetOptions = <dynamic>[
    SearchScreen(),
    FavoriteScreen(),
    ShoppinScreen(),

  ];

  void onItemTapped(int index) {
    selectedIndex.value = index;
  }

  Widget buildImage(
      String assetPath,
      String selectedAssetPath,
      int index,
      ) {
    return ColorFiltered(
      colorFilter: ColorFilter.mode(
        selectedIndex.value == index ? Colors.pink.withOpacity(0.4) : Colors.grey,
        BlendMode.srcIn,
      ),
      child: Image.asset(
        selectedIndex.value == index ? selectedAssetPath : assetPath,
        height: 24,
      ),
    );
  }



}


