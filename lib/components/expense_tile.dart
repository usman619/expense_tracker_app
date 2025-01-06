// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ExpenseTile extends StatelessWidget {
  final String name;
  final String amount;
  final DateTime dateTime;
  final void Function(BuildContext)? deleteTapped;
  const ExpenseTile({
    super.key,
    required this.name,
    required this.amount,
    required this.dateTime,
    required this.deleteTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          SlidableAction(
            onPressed: deleteTapped,
            icon: Icons.delete,
            foregroundColor: Colors.white,
            backgroundColor: Colors.red,
            borderRadius: BorderRadius.circular(8),
          ),
        ],
      ),
      child: ListTile(
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
      ),
    );
  }
}
