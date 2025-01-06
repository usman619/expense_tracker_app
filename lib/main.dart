import 'package:expense_tracker_app/database/expense_data.dart';
import 'package:expense_tracker_app/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox("expense_database");

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ExpenseData(),
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'FiraCode',
          brightness: Brightness.dark,
          colorScheme: const ColorScheme.dark(
            primary: Colors.white,
          ),
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}
