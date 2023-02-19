import 'package:expense_app/widgets/chart.dart';
import 'package:expense_app/widgets/new_transaction.dart';
import 'package:expense_app/widgets/transaction_list.dart';
import 'package:flutter/material.dart';

import 'models/transaction.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // late List<Transation> _userTransation;
  final List<Transation> _transation = [
    Transation(
        id: 't1', title: 'new shoes', amount: 69.99, date: DateTime.now()),
    Transation(id: 't2', title: 'hdd', amount: 50.99, date: DateTime.now()),
    Transation(id: 't3', title: 'apple', amount: 120, date: DateTime.now()),
  ];
  List<Transation> get lastSevenTransation {
    return _transation.where((element) {
      return element.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ));
    }).toList();
  }

  void addNewTransaction(String title, double amount, DateTime date) {
    // .add(Transation(id: id, title: title, amount: amount, date: date));
    final newTx = Transation(
        id: DateTime.now().toString(),
        title: title,
        amount: amount,
        date: date);
    setState(() {
      _transation.add(newTx);
    });
  }

  void deleteTransaction(String id) {
    setState(() {
      _transation.removeWhere((element) => element.id == id);
    });
  }

  void startTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransation(addNewTransaction: addNewTransaction);
        });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Expense App',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          appBarTheme: AppBarTheme(
            toolbarTextStyle: TextStyle(color: Colors.amberAccent),
          ),
        ),
        home: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Chart(transation: lastSevenTransation),
                  TransationList(
                    transation: _transation,
                    delTrnsation: deleteTransaction,
                  ),
                ],
              ),
            ),
            appBar: AppBar(
              title: const Text("Expense app"),
              actions: [
                Builder(builder: (context) {
                  return IconButton(
                      onPressed: () => startTransaction(context),
                      icon: const Icon(Icons.add));
                })
              ],
            ),
            floatingActionButton: Builder(
              builder: (BuildContext context) {
                return FloatingActionButton(
                    onPressed: () => startTransaction(context),
                    child: Icon(Icons.add));
              },
            )));
  }
}
