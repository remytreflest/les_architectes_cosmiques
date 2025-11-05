import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'features/building/presentation/pages/login_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'les_architectes_cosmiques',
      debugShowCheckedModeBanner: false,
      getPages: [GetPage(name: '/home', page: () => const LoginPage())],
      initialRoute: '/home',
    );
  }
}
