import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
        GetPage(name: '/home', page: () => const UserView()),
        GetPage(name: '/dashboard', page: () => const DashboardView()),
      ],
      initialRoute: '/home',
    );
  }
}
