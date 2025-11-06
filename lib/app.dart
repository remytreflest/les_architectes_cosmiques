import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:les_architectes_cosmiques/features/building/presentation/pages/building_list_view.dart';
import 'package:les_architectes_cosmiques/features/dashboard/presentation/pages/dashboard_view.dart';
import 'package:les_architectes_cosmiques/features/user/presentation/pages/user_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'les_architectes_cosmiques',
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(name: '/dashboard', page: () => const DashboardView()),
        GetPage(name: '/home', page: () => const UserView()),
        GetPage(name: '/building', page: () => BuildingListView()),
        GetPage(name: '/technologies', page: () => const DashboardView()),
        GetPage(name: '/diplomacy', page: () => const DashboardView()),
        GetPage(name: '/bonus', page: () => const DashboardView()),
      ],
      initialRoute: '/home',
    );
  }
}
