import 'package:expense_tracker_app/components/expense_summary.dart';
import 'package:expense_tracker_app/components/expense_tile.dart';
import 'package:expense_tracker_app/database/expense_data.dart';
import 'package:expense_tracker_app/models/expense_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final newExpenseNameController = TextEditingController();
  final newExpenseAmountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // prepare data on startup
    Provider.of<ExpenseData>(context, listen: false).prepareData();
  }

  void addNewExpense() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add new expense'),
        icon: Icon(
          Icons.add_card_sharp,
          color: Colors.white,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Expense Name
            TextField(
              controller: newExpenseNameController,
              decoration: InputDecoration(
                hintText: 'Item',
                hintStyle: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
            // Expense Amount
            TextField(
              controller: newExpenseAmountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Amount',
                hintStyle: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
        actions: [
          MaterialButton(
            onPressed: save,
            child: Text('Add'),
          ),
          MaterialButton(
            onPressed: cancel,
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void save() {
    if (newExpenseNameController.text.isNotEmpty &&
        newExpenseAmountController.text.isNotEmpty) {
      ExpenseItem newExpense = ExpenseItem(
        name: newExpenseNameController.text,
        amount: newExpenseAmountController.text,
        dateTime: DateTime.now(),
      );

      Provider.of<ExpenseData>(context, listen: false).addExpense(newExpense);
    }

    Navigator.pop(context);
    clear();
  }

  void cancel() {
    Navigator.pop(context);
    clear();
  }

  void clear() {
    newExpenseNameController.clear();
    newExpenseAmountController.clear();
  }

  void deleteExpense(ExpenseItem expense) {
    Provider.of<ExpenseData>(context, listen: false).deleteExpense(expense);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          title: const Text(
            'Expenses',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          primary: true,
        ),
        body: ListView(
          children: [
            ExpenseSummary(
              startOfWeek: value.startOfWeekDate(),
            ),
            SizedBox(
              height: 10,
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: value.getAllExpenseList().length,
              itemBuilder: (context, index) => ExpenseTile(
                name: value.getAllExpenseList()[index].name,
                amount: value.getAllExpenseList()[index].amount,
                dateTime: value.getAllExpenseList()[index].dateTime,
                deleteTapped: (p0) =>
                    deleteExpense(value.getAllExpenseList()[index]),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: addNewExpense,
          backgroundColor: Colors.white,
          child: Icon(
            Icons.add_sharp,
            size: 32,
          ),
        ),
      ),
    );
  }
}
