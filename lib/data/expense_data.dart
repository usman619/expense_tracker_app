import 'package:expense_tracker_app/models/expense_item.dart';

/*
The following are thing that will the part of the expense data:
  - Overall Expense List
    [
      [item, date, amount],
      ...
      ..
      .
    ]
  - Daily Expense Summary
    [
      [date, total_amount],
      ...
      ..
      .
    ]
  - Add and delete expense 
  - Barchat to represent expense
*/

class ExpenseData {
  List<ExpenseItem> overallExpenseList = [];

  List<ExpenseItem> getAllExpense() {
    return overallExpenseList;
  }

  void addExpense(ExpenseItem item) {
    overallExpenseList.add(item);
  }

  void deleteExpense(ExpenseItem item) {
    overallExpenseList.remove(item);
  }

  String getDayName(DateTime dateTime) {
    switch (dateTime.weekday) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tues';
      case 3:
        return 'Wed';
      case 4:
        return 'Thur';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
        return '';
    }
  }

  DateTime startOfWeekDate() {
    DateTime? startOfWeek;
    DateTime today = DateTime.now();

    for (int i = 0; i < 7; i++) {
      if (getDayName(today.subtract(Duration(days: i))) == 'Sun') {
        startOfWeek = today.subtract(Duration(days: i));
      }
    }
    return startOfWeek!;
  }
}
