import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:school_management_system/ui/model/Expense.dart';

class ChangeThemeController extends GetxController {
  var _isDarkMode = false.obs;
  var _listOfExpense = List<Expense>().obs;
  final _expenseNameTextEditingController = TextEditingController();
  final _expenseAmountTextEditingController = TextEditingController();

  TextEditingController get getExpenseTitleController =>
      _expenseNameTextEditingController;

  TextEditingController get getExpenseAmountController =>
      _expenseAmountTextEditingController;

  get getIsDarkMode => _isDarkMode.value;

  List<Expense> get expenseList => _listOfExpense;

  addExpense() {
    if (_expenseNameTextEditingController.text.isEmpty ||
        _expenseAmountTextEditingController.text.isEmpty) {
      Get.snackbar('Error', 'Please Provide All Fields');
    } else {
      _listOfExpense.add(
        Expense(
          id: '${DateTime.now().day} ${DateTime.now().month} ${DateTime.now().year}',
          Amount:
              double.parse(_expenseAmountTextEditingController.text.toString()),
          date: DateFormat.yMMMEd().format(
            DateTime.now(),
          ),
          expenseName: _expenseNameTextEditingController.text.toString(),
        ),
      );
      _expenseNameTextEditingController.clear();
      _expenseAmountTextEditingController.clear();
      Get.back();
    }
  }

  insertIndex(var index) {
    if (_expenseNameTextEditingController.text.isEmpty ||
        _expenseAmountTextEditingController.text.isEmpty) {
      Get.snackbar('Error', 'Please Provide All Fields');
    } else {
      removeItemFromExpenseList(index);
      _listOfExpense.insert(
        index,
        Expense(
          id: '${DateTime.now().day} ${DateTime.now().month} ${DateTime.now().year}',
          Amount:
          double.parse(_expenseAmountTextEditingController.text.toString()),
          date: DateFormat.yMMMEd().format(
            DateTime.now(),
          ),
          expenseName: _expenseNameTextEditingController.text.toString(),
        ),
      );
      _expenseNameTextEditingController.clear();
      _expenseAmountTextEditingController.clear();
      Get.back();
      Get.back();
    }

  }

  showDialog(Widget content) {
    Get.defaultDialog(
      title: 'Edit Item',
      content: content,
    );
  }


  removeItemFromExpenseList(var index){
    _listOfExpense.removeAt(index);
    Get.snackbar('Success', 'Item removed successfully');
  }
  showBottomSheet(var color, Widget child) {
    Get.bottomSheet(
      Container(
        height: 220,
        color: color,
        child: child,
      ),
    );
  }

  setDarkTheme(val) {
    final appdata = GetStorage(); // instance of GetStorage

    _isDarkMode.value = val;
    appdata.write('darkmode', _isDarkMode.value);
    print(_isDarkMode);
  }

  @override
  void dispose() {
    super.dispose();
    _expenseAmountTextEditingController.dispose();
    _expenseNameTextEditingController.dispose();
  }
}
