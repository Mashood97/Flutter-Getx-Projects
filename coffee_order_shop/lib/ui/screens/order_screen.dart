import 'package:coffee_order_shop/ui/controllers/order_controller.dart';
import 'package:coffee_order_shop/utils/common_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

class OrderScreen extends StatelessWidget {
  static const routeName = '/orderscreen';
  OrderController _orderController = Get.put(OrderController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 350,
              floating: true,
              title: Text(
                _orderController.getCoffee.name,
                style: Theme.of(context).textTheme.headline4,
              ),
              centerTitle: true,
              snap: true,
              flexibleSpace: Image.network(
                'https://images.pexels.com/photos/312418/pexels-photo-312418.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
                fit: BoxFit.cover,
              ),
            ),
            SliverFillRemaining(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    getHeaderWithQuantity(context),
                    buildTotalAmountWidget(context),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Cup-Size:',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),
                    buildCupSizeWidget(context),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Sugar (in cubes):',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),
                    buildSugarWidget(context),
                    kSizedBox,
                    buildAddToCartButton(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAddToCartButton(BuildContext context) {
    return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: RaisedButton(
                        onPressed: () {
                          _orderController.addToCart();
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.add_shopping_cart,
                              color: Colors.white,
                            ),
                            Text(
                              'Add to Cart',
                              style: Theme.of(context).textTheme.headline4,
                            ),
                          ],
                        ),
                        splashColor: Theme.of(context).accentColor,
                        color: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  );
  }

  Widget buildSugarWidget(BuildContext context) {
    return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Chip(
                        label: Text(
                          'One',
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              .copyWith(color: Colors.white),
                        ),
                        backgroundColor: Colors.pink.shade300,
                      ),
                      Chip(
                        label: Text(
                          'Two',
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              .copyWith(color: Colors.white),
                        ),
                        backgroundColor: Colors.pink.shade300,
                      ),
                      Chip(
                        label: Text(
                          'Three',
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              .copyWith(color: Colors.white),
                        ),
                        backgroundColor: Colors.pink.shade300,
                      ),
                    ],
                  );
  }

  Widget buildCupSizeWidget(BuildContext context) {
    return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Chip(
                        label: Text(
                          'Small',
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              .copyWith(color: Colors.white),
                        ),
                        backgroundColor: Colors.pink.shade300,
                      ),
                      Chip(
                        label: Text(
                          'Medium',
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              .copyWith(color: Colors.white),
                        ),
                        backgroundColor: Colors.pink.shade300,
                      ),
                      Chip(
                        label: Text(
                          'Large',
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              .copyWith(color: Colors.white),
                        ),
                        backgroundColor: Colors.pink.shade300,
                      ),
                    ],
                  );
  }

  Widget buildTotalAmountWidget(BuildContext context) {
    return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Total Amount:',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Obx(
                          () => Text(
                            '\$ ${_orderController.getTotalPrice}',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headline5,
                          ),
                        ),
                      ),
                    ],
                  );
  }

  Widget getHeaderWithQuantity(BuildContext context) {
    return Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          _orderController.getCoffee.name,
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ),
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                _orderController.addQuantity();
                              },
                              child: Chip(
                                label: Icon(
                                  Icons.add,
                                  size: 18,
                                  color: Colors.white,
                                ),
                                backgroundColor: Colors.pink.shade400,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Obx(() => Text(
                                _orderController.getQuantity.toString())),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                _orderController.lessQuantity();
                              },
                              child: Chip(
                                label: Text(
                                  '- ',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      .copyWith(
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                ),
                                backgroundColor: Colors.pink.shade400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
  }
}
