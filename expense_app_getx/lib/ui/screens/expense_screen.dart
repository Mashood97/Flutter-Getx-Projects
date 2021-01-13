import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_management_system/ui/controllers/expense_controller.dart';
import '../../utils/common.dart';

class LoginScreen extends StatelessWidget {
  static const routeNamed = '/login-screen';

  final ChangeThemeController _changeThemeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottomOpacity: 0.0,
        title: Text(
          'Expense App',
          style: Theme.of(context).textTheme.headline6.copyWith(
                fontSize: 20.0,
              ),
        ),
        actions: [
          Obx(
            () => Switch.adaptive(
              value: _changeThemeController.getIsDarkMode,
              onChanged: (val) => _changeThemeController.setDarkTheme(val),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Obx(
          () => _changeThemeController.expenseList.isEmpty
              ? Center(
                  child: Text(
                    'Press + to add expense',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                )
              : ListView.separated(
                  itemBuilder: (ctx, index) => ListTile(
                      title: Text(
                        _changeThemeController.expenseList[index].expenseName,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      subtitle: Text(
                        '\$${_changeThemeController.expenseList[index].Amount}',
                        style: Theme.of(context).textTheme.headline6.copyWith(
                              fontWeight: FontWeight.w300,
                              color: _changeThemeController.getIsDarkMode
                                  ? Colors.white
                                  : Colors.black,
                            ),
                      ),
                      leading: CircleAvatar(
                        backgroundColor: Theme.of(context).primaryColor,
                        child: Text(
                          '${index + 1}',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: kErrorColor,
                            ),
                            splashColor: kErrorColor,
                            onPressed: () {
                              _changeThemeController
                                  .removeItemFromExpenseList(index);
                            },
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.edit,
                              color: kSuccessColor,
                            ),
                            onPressed: () {
                              _changeThemeController.showDialog(
                                  bottomSheetElements(context, index));
                            },
                            splashColor: kSuccessColor,
                          ),
                        ],
                      )),
                  separatorBuilder: (_, __) => Divider(),
                  itemCount: _changeThemeController.expenseList.length,
                ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _changeThemeController.showBottomSheet(
            _changeThemeController.getIsDarkMode
                ? Theme.of(context).primaryColor
                : Theme.of(context).accentColor,
            bottomSheetElements(context, -1),
          );
        },
        backgroundColor: Theme.of(context).accentColor,
        child: Icon(
          Icons.add,
        ),
        splashColor: Theme.of(context).primaryColor,
        tooltip: 'Add Expense',
      ),
    );
  }

  Widget bottomSheetElements(var context, var index) {
    if (index >= 0) {
      _changeThemeController.getExpenseTitleController.text =
          _changeThemeController.expenseList[index].expenseName;
      _changeThemeController.getExpenseAmountController.text =
          _changeThemeController.expenseList[index].Amount.toString();
    } else {
      _changeThemeController.getExpenseAmountController.clear();
      _changeThemeController.getExpenseTitleController.clear();
    }
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _changeThemeController.getExpenseTitleController,
            decoration: InputDecoration(
              labelText: 'Enter Expense Title',
              suffixIcon: Icon(
                Icons.title,
                color: _changeThemeController.getIsDarkMode
                    ? Theme.of(context).accentColor
                    : Colors.black,
              ),
              alignLabelWithHint: true,
            ),
            keyboardType: TextInputType.text,
            autocorrect: true,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _changeThemeController.getExpenseAmountController,
            decoration: InputDecoration(
              labelText: 'Enter Amount',
              suffixIcon: Icon(Icons.monetization_on,
                  color: _changeThemeController.getIsDarkMode
                      ? Theme.of(context).accentColor
                      : Colors.black),
              alignLabelWithHint: true,
            ),
            keyboardType: TextInputType.number,
            autocorrect: true,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: RaisedButton(
            onPressed: () {
              if (index >= 0) {
                          _changeThemeController.insertIndex(index);
              } else {
                _changeThemeController.addExpense();
              }
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            color: _changeThemeController.getIsDarkMode
                ? Theme.of(context).accentColor
                : Theme.of(context).primaryColor,
            child: index >= 0
                ? Text(
                    'Update',
                    style: Theme.of(context).textTheme.headline6.copyWith(
                          color: _changeThemeController.getIsDarkMode
                              ? Colors.black
                              : Colors.white,
                        ),
                  )
                : Text(
                    'Save',
                    style: Theme.of(context).textTheme.headline6.copyWith(
                          color: _changeThemeController.getIsDarkMode
                              ? Colors.black
                              : Colors.white,
                        ),
                  ),
          ),
        ),
      ],
    );
  }
}
