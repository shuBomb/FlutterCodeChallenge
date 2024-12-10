
import 'package:code_challenge/app/modules/home_module/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class HomePage extends StatelessWidget {
   HomePage({super.key});
  final HomeController controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: const CommonAppBar(),
      body: Obx(
            () => Center(
          child: controller.widgetOptions.elementAt(controller.selectedIndex.value),
        ),
      ),
      bottomNavigationBar: Obx(
            () => Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Theme(
            data: Theme.of(context).copyWith(
              splashColor: Colors.transparent,
            ),
            child: BottomNavigationBar(
              backgroundColor: Theme.of(context).colorScheme.onSecondary,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: controller.buildImage("assets/images/homeUnselected.png", "assets/images/homeSelected.png", 0),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  icon: controller.buildImage("assets/images/favUnselected.png", "assets/images/favSelected.png", 1),
                  label: "Favorite",
                ),
                BottomNavigationBarItem(
                  icon: controller.buildImage("assets/images/shoppingUnselected.png","assets/images/shoppingSelected.png" , 2),
                  label: "Cart",
                ),
              ],
              type: BottomNavigationBarType.fixed,
              currentIndex: controller.selectedIndex.value,
              elevation: 0,
              showUnselectedLabels: true,
              showSelectedLabels: true,
              selectedItemColor: Colors.pink.withOpacity(0.4),
              unselectedItemColor: Colors.grey,
              unselectedLabelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, height: 2),
              selectedLabelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, height: 2),
              onTap: controller.onItemTapped,
            ),
          ),
        ),
      ),
    );
  }
}



