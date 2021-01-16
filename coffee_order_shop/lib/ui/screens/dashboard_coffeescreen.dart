import 'package:coffee_order_shop/ui/controllers/coffee_controller.dart';
import 'package:coffee_order_shop/ui/controllers/order_controller.dart';
import 'package:coffee_order_shop/ui/models/Order.dart';
import 'package:coffee_order_shop/utils/common_constants.dart';
import 'package:coffee_order_shop/widgets/animated_searchbar.dart';
import 'package:coffee_order_shop/widgets/main_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class DashboardCoffeeScreen extends StatelessWidget {
  static const routeNamed = '/dashboard';

  final CoffeeController _coffeeController = Get.find();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final box = GetStorage();
  Order order;

  @override
  Widget build(BuildContext context) {
    order = box.read('Order');
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.pink.shade50,
        elevation: 0.0,
        bottomOpacity: 0.0,
        leading: IconButton(
          onPressed: () => _scaffoldKey.currentState.openDrawer(),
          icon: Icon(
            Icons.sort,
            size: 35.0,
            color: Colors.black,
          ),
        ),
        actions: [
          AnimatedSearchBar(),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RichText(
                text: TextSpan(
                    text: 'It\'s Great ',
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        .copyWith(letterSpacing: 2.0, fontSize: 36.0),
                    children: [
                      TextSpan(
                        text: 'Day For Coffee.',
                        style: Theme.of(context).textTheme.headline5.copyWith(
                              color: Colors.brown,
                              letterSpacing: 2.0,
                              fontSize: 36.0,
                            ),
                      ),
                    ]),
              ),
            ),
            kSizedBox,
            Expanded(
              child: Obx(
                () => ListView.separated(
                  itemBuilder: (ctx, i) => ListTile(
                    onTap: () {
                      _coffeeController.navigateToOrderScreen(i);
                    },
                    title: Text(
                      _coffeeController.getCoffeeList[i].name,
                      style: Theme.of(context).textTheme.headline6.copyWith(
                            fontSize: 24.0,
                            letterSpacing: 2.0,
                          ),
                    ),
                    subtitle: Text(
                      '\$ ${_coffeeController.getCoffeeList[i].price.toString()}',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    leading: CircleAvatar(
                      backgroundColor: Colors.brown,
                      child: Text(
                        '${i + 1}',
                        style: Theme.of(context).textTheme.headline6.copyWith(
                              color: Colors.white,
                            ),
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                    ),
                  ),
                  separatorBuilder: (_, __) => Divider(),
                  itemCount: _coffeeController.getCoffeeList.length,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                height: 10,
                color: Colors.pink.shade50,
              ),
            ),
          ],
        ),
      ),
      drawerScrimColor: Colors.black54,
      drawer: MainDrawer(),
      floatingActionButton: order == null
          ? Container()
          : FloatingActionButton(
              onPressed: () {
                print(order.totalPrice);
              },
              child: Icon(
                Icons.add_shopping_cart_rounded,
                color: Colors.white,
              ),
              backgroundColor: Colors.pink.shade300,
            ),
    );
  }
}
