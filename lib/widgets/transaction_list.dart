import 'package:expense_app/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransationList extends StatelessWidget {
  TransationList(
      {super.key, required this.transation, required this.delTrnsation});

  final List<Transation> transation;
  final Function delTrnsation;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 500,
        child: transation.isEmpty
            ? Column(
                children: [
                  Text(
                    'no transaction',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 300,
                    child: Image.asset(
                      'lib/assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              )
            : ListView.builder(
                itemCount: transation.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: ListTile(
                        trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              delTrnsation(transation[index].id);
                            }),
                        subtitle: Text(
                            DateFormat.yMMMd().format(transation[index].date)),
                        title: Text(
                          transation[index].title,
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                        leading: CircleAvatar(
                          radius: 30,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FittedBox(
                                child: Text(transation[index]
                                    .amount
                                    .toStringAsFixed(2))),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ));
  }
}
