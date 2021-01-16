import 'dart:convert';

import 'package:coffee_order_shop/ui/models/Coffee.dart';
import 'package:coffee_order_shop/ui/models/Order.dart';
import 'package:coffee_order_shop/ui/screens/dashboard_coffeescreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class OrderController extends GetxController {
  Order _order;

  var _totalPrice = 0.0.obs;

  var _selectedCupSize = 1.obs;

  get getSelectedCupSize => _selectedCupSize.value;

  var _selectedSugarCubes = 1.obs;

  get getSelectedSugarCubes => _selectedSugarCubes.value;
  Coffee _coffee;

  var _quantity = 1.obs;

  get getQuantity => _quantity.value;

  get getTotalPrice => _totalPrice.value;

  Coffee get getCoffee => _coffee;

  setSelectedCupSize(val) {
    _selectedCupSize.value = val;
  }

  setSelectedSugarCube(val) {
    _selectedSugarCubes.value = val;
  }

  void getCoffeeArgs() {
    _coffee = Get.arguments;
    print(_coffee.name);
  }

  addQuantity() {
    if (_quantity.value >= 0) {
      _quantity.value++;
      _totalPrice.value = _coffee.price * _quantity.value.toDouble();
      print(_totalPrice);
    } else {
      showErrorSnackBar('Please select valid quantity');
    }
  }

  lessQuantity() {
    if (_quantity > 0) {
      _quantity.value--;
      _totalPrice.value = _coffee.price * _quantity.value.toDouble();
    } else {
      showErrorSnackBar('Please select valid quantity');
    }
  }

  showErrorSnackBar(var title) {
    Get.snackbar(
      'Error',
      title,
      backgroundColor: Colors.black,
      colorText: Colors.white,
    );
  }

  showSuccessSnackBar(var title) {
    Get.snackbar(
      'Success',
      title,
      backgroundColor: Colors.black,
      colorText: Colors.white,
    );
  }

  addToCart() {
    if (_selectedCupSize.value == 2) {
      _totalPrice += 5;
    }
    if (_selectedCupSize.value == 3) {
      _totalPrice += 10;
    }
    if (_quantity.value > 0 && _totalPrice.value != 0) {
      _order = Order(
        coffee: _coffee,
        orderId:
            '${DateTime.now().year} ${DateTime.now().month} ${DateTime.now().day}',
        quantity: _quantity.value,
        totalPrice: _totalPrice.value,
        cupsize: _selectedCupSize.value == 1
            ? 'Small'
            : _selectedCupSize.value == 2
                ? 'Medium'
                : 'Large',
        sugarcbes: _selectedSugarCubes.value,
      );

      if (_order != null) {
        saveOrderToStorage(Order(
          coffee: _order.coffee,
          orderId: _order.orderId,
          quantity: _order.quantity,
          totalPrice: _order.totalPrice,
          cupsize: _order.cupsize,
          sugarcbes: _order.sugarcbes,
        ));

        showSuccessSnackBar(
          'Order Added Successfully',
        );
        Get.offNamed(DashboardCoffeeScreen.routeNamed);
      } else {
        showErrorSnackBar('Order not saved, Try again later!');
      }
    } else {
      showErrorSnackBar('Please select quantity');
    }
  }

  saveOrderToStorage(Order order) {
    final _box = GetStorage();
    _box.write('Order', order);
    print(_box.read('Order'));
  }

  @override
  void onInit() {
    super.onInit();
    getCoffeeArgs();
    _totalPrice.value = _coffee.price * _quantity.value.toDouble();
  }
}
