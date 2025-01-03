import 'package:expense_tracker_app/datetime/date_time_helper.dart';
import 'package:expense_tracker_app/models/expense_item.dart';
import 'package:flutter/material.dart';

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

class ExpenseData extends ChangeNotifier {
  List<ExpenseItem> overallExpenseList = [];

  List<ExpenseItem> getAllExpense() {
    return overallExpenseList;
  }

  void addExpense(ExpenseItem item) {
    overallExpenseList.add(item);
    notifyListeners();
  }

  void deleteExpense(ExpenseItem item) {
    overallExpenseList.remove(item);
    notifyListeners();
  }

  // Get the name of the day in letters
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

  // Get the Date of the start of the week
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

  // Calculate Daily Expense for the Day
  Map<String, double> calculateDailyExpenseSummary() {
    // date(ddmmyyyy) : totalExpenseForTheDay
    Map<String, double> dailyExpenseSummary = {};
    for (var expense in overallExpenseList) {
      String date = convertDateTimeToString(expense.dateTime);
      double amount = double.parse(expense.amount);

      if (dailyExpenseSummary.containsKey(date)) {
        double currentAmount = dailyExpenseSummary[date]!;
        currentAmount += amount;
        dailyExpenseSummary[date] = currentAmount;
      } else {
        dailyExpenseSummary.addAll({date: amount});
      }
    }
    return dailyExpenseSummary;
  }
}
