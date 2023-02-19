import 'dart:ffi';

import 'package:expense_app/models/transaction.dart';
import 'package:expense_app/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  const Chart({super.key, required this.transation});

  final List<Transation> transation;

  List<Map<String, Object>> get groupedTransationValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0.0;

      for (var i = 0; i < transation.length; i++) {
        if (transation[i].date.day == weekDay.day &&
            transation[i].date.month == weekDay.month &&
            transation[i].date.year == weekDay.year) {
          totalSum += transation[i].amount;
        }
      }
      print(DateFormat.E().format(weekDay));
      print(totalSum);
      return {'Day': DateFormat.E().format(weekDay), 'amount': totalSum};
    }).reversed.toList();
  }

  double get totalSpeding {
    return groupedTransationValues.fold(0.0, (previousValue, element) {
      return previousValue + (element['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransationValues);
    return Card(
      margin: EdgeInsets.all(20),
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: groupedTransationValues.map((e) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                  label: e['Day'] as String,
                  spendingAmount: e['amount'] as double,
                  spendingProcent: totalSpeding == 0.0
                      ? 0.0
                      : ((e['amount'] as double) / totalSpeding)),
            );
          }).toList(),
        ),
      ),
    );
  }
}
