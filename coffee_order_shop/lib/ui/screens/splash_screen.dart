import 'package:coffee_order_shop/ui/controllers/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  static const routeNamed = '/splashScreen';

  SplashController _splashController = Get.find();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: [
          Container(
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                Colors.pink.shade50.withOpacity(0.1),
                BlendMode.dstATop,
              ),
              child: Container(
                height: mediaQuery.height,
                child: Image.asset(
                  'assets/images/coffeebg.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Image.asset(
              'assets/images/coffeeimage.png',
            ),
          ),
        ],
      ),
    ));
  }
}
