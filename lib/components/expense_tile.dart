import 'package:flutter/material.dart';

class ExpenseTile extends StatelessWidget {
  final String name;
  final String amount;
  final DateTime dateTime;
  const ExpenseTile({
    super.key,
    required this.name,
    required this.amount,
    required this.dateTime,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        name,
        style: TextStyle(fontSize: 18),
      ),
      subtitle: Text(
        '${dateTime.day}/${dateTime.month}/${dateTime.year}',
        style: TextStyle(color: Colors.grey, fontSize: 16),
      ),
      trailing: Text(
        '\$$amount',
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}
