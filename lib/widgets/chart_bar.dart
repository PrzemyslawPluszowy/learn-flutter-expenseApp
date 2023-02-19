import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  ChartBar(
      {super.key,
      required this.label,
      required this.spendingAmount,
      required this.spendingProcent});

  final String label;
  final double spendingAmount;
  final double spendingProcent;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
            height: 20,
            child: FittedBox(
                child: Text('\$${spendingAmount.toStringAsFixed(0)}'))),
        SizedBox(
          height: 5,
        ),
        Container(
          height: 60,
          width: 10,
          child: Stack(
            children: [
              Container(
                height: 60,
                alignment: Alignment.topCenter,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    border: Border.all(color: Colors.black38, width: 1.0)),
              ),
              FractionallySizedBox(
                heightFactor: spendingProcent,
                child: Container(
                  decoration:
                      BoxDecoration(color: Theme.of(context).primaryColor),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text('$label')
      ],
    );
  }
}
