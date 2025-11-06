import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavController extends GetxController {
  RxInt selectedIndex = 0.obs;

  void navigate(int index) {
    selectedIndex.value = index;

    switch (index) {
      case 0:
        Get.offAllNamed('/dashboard');
        break;
      case 1:
        // Get.offAllNamed('/home');
        Get.offAllNamed('/dashboard');
        break;
      case 2:
        Get.offAllNamed('/technologies');
        break;
      case 3:
        Get.offAllNamed('/diplomacy');
        break;
      case 4:
        Get.offAllNamed('/bonus');
        break;
    }
  }
}

class CustomBottomNavBar extends StatelessWidget {
  CustomBottomNavBar({Key? key}) : super(key: key);

  final _icons = [
    Icons.dashboard,
    Icons.home,
    Icons.device_hub,
    Icons.public,
    Icons.star,
  ];

  final _labels = ["Dashboard", "Bâtiment", "Techno", "Diplomatie", "Bonus"];

  @override
  Widget build(BuildContext context) {
    final BottomNavController controller = Get.put(BottomNavController());

    return Obx(
      () => BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: controller.selectedIndex.value,
        onTap: controller.navigate,
        items: List.generate(5, (index) {
          return BottomNavigationBarItem(
            icon: Icon(
              _icons[index],
              color: controller.selectedIndex.value == index
                  ? Theme.of(context).colorScheme.primary
                  : Colors.grey,
            ),
            label: _labels[index],
          );
        }),
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
      ),
    );
  }
}
