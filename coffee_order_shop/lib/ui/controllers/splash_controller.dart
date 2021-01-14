


import 'dart:async';

import 'package:coffee_order_shop/ui/screens/dashboard_coffeescreen.dart';
import 'package:get/get.dart';

class SplashController extends GetxController{

  @override
  void onInit() {
    super.onInit();
    Timer(Duration(seconds: 5),(){
      Get.offNamed(DashboardCoffeeScreen.routeNamed);
    });
  }
}