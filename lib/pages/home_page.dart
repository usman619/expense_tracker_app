import 'package:expense_tracker_app/components/expense_summary.dart';
import 'package:expense_tracker_app/components/expense_tile.dart';
import 'package:expense_tracker_app/data/expense_data.dart';
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
    ExpenseItem newExpense = ExpenseItem(
      name: newExpenseNameController.text,
      amount: newExpenseAmountController.text,
      dateTime: DateTime.now(),
    );
    Provider.of<ExpenseData>(context, listen: false).addExpense(newExpense);

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

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          title: const Text('Home Page'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          centerTitle: true,
          primary: true,
        ),
        body: ListView(
          children: [
            ExpenseSummary(
              startOfWeek: value.startOfWeekDate(),
            ),
            SizedBox(
              height: 25,
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: value.getAllExpense().length,
              itemBuilder: (context, index) => ExpenseTile(
                name: value.getAllExpense()[index].name,
                amount: value.getAllExpense()[index].amount,
                dateTime: value.getAllExpense()[index].dateTime,
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
