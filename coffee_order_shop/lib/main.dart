import 'package:coffee_order_shop/ui/controllers/order_controller.dart';
import 'package:coffee_order_shop/ui/controllers/splash_controller.dart';
import 'package:coffee_order_shop/ui/screens/dashboard_coffeescreen.dart';
import 'package:coffee_order_shop/ui/screens/order_screen.dart';
import 'package:coffee_order_shop/ui/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

import 'ui/controllers/coffee_controller.dart';

void main() async {
  await GetStorage.init();
  Get.put(SplashController());
  Get.put(CoffeeController());
  runApp(MyApp());
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.pink.shade50,
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Coffee Shop',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Colors.pink.shade50,
        textTheme: TextTheme(
          headline6: GoogleFonts.montserrat(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            letterSpacing: 2.0,
            fontSize: 16.0,
          ),
          headline5: GoogleFonts.indieFlower(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            letterSpacing: 2.0,
            fontSize: 20.0,
          ),
          headline4: GoogleFonts.montserrat(
            color: Colors.white,
            letterSpacing: 2.0,
            fontWeight: FontWeight.w500,
            fontSize: 24.0,
          ),
        ),
      ),
      initialRoute: SplashScreen.routeNamed,
      getPages: [
        GetPage(
          name: SplashScreen.routeNamed,
          page: () => SplashScreen(),
        ),
        GetPage(
          name: DashboardCoffeeScreen.routeNamed,
          page: () => DashboardCoffeeScreen(),
        ),
        GetPage(
          name: OrderScreen.routeName,
          page: () => OrderScreen(),
        ),
      ],
    );
  }
}
