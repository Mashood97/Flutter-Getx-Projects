import 'package:coffee_order_shop/ui/models/Coffee.dart';
import 'package:coffee_order_shop/ui/screens/order_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CoffeeController extends GetxController {
  var _coffeeList = List<Coffee>().obs;

  List<Coffee> get getCoffeeList => _coffeeList;
  @override
  void onInit() {
    super.onInit();
    var list = [
      Coffee(
        id: '1',
        name: 'Espresso',
        icon: 'assets/images/espresso.png',
        price: 15.25,
      ),
      Coffee(
        id: '2',
        name: 'Cappuccino',
        icon: 'assets/images/Macchiato.png',
        price: 18.00,
      ),
      Coffee(
        id: '3',
        name: 'Macchiato',
        icon: 'assets/images/espresso.png',
        price: 22.20,
      ),
      Coffee(
        id: '4',
        name: 'Mocha',
        icon: 'assets/images/Macchiato.png',
        price: 24.66,
      ),
      Coffee(
        id: '5',
        name: 'Latte',
        icon: 'assets/images/espresso.png',
        price: 30.55,
      ),
      Coffee(
        id: '5',
        name: 'Americano',
        icon: 'assets/images/Macchiato.png',
        price: 45.55,
      ),
      Coffee(
        id: '5',
        name: 'Doppio',
        icon: 'assets/images/espresso.png',
        price: 25.99,
      ),
    ];
    _coffeeList.addAll(list);
  }


  navigateToOrderScreen(int index){
    Get.toNamed(OrderScreen.routeName,arguments:_coffeeList[index]);
  }
}
