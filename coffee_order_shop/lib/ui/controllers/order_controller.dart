import 'package:coffee_order_shop/ui/models/Coffee.dart';
import 'package:coffee_order_shop/ui/models/Order.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  var _order = Order();

  var _totalPrice = 0.0.obs;

  Coffee _coffee;

  var _quantity = 1.obs;

  get getQuantity => _quantity.value;

  get getTotalPrice => _totalPrice.value;

  Coffee get getCoffee => _coffee;

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
    if (_quantity.value > 0 && _totalPrice.value != 0) {
      _order = Order(
        coffee: _coffee,
        orderId:
            '${DateTime.now().year} ${DateTime.now().month} ${DateTime.now().day}',
        quantity: _quantity.value,
        totalPrice: _totalPrice.value,
      );

      showSuccessSnackBar(
        'Order Added Successfully',
      );
    } else {
      showErrorSnackBar('Please select quantity');
    }
  }

  @override
  void onInit() {
    super.onInit();
    getCoffeeArgs();
    _totalPrice.value = _coffee.price * _quantity.value.toDouble();
  }
}
