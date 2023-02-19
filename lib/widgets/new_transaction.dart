import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransation extends StatefulWidget {
  NewTransation({super.key, required this.addNewTransaction});

  // late String titleInput;
  // late String amountInput;
  final Function addNewTransaction;

  @override
  State<NewTransation> createState() => _NewTransationState();
}

class _NewTransationState extends State<NewTransation> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();
  DateTime? transationDate;

  void submitData() {
    final String title = titleController.text;
    final double amount = double.parse(amountController.text);

    if (title == "" || amount <= 0) return;

    widget.addNewTransaction(title, amount, transationDate);
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2023),
            lastDate: DateTime.now())
        .then((date) {
      if (date == null) {
        return;
      } else {
        setState(() {
          transationDate = date;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        child: Container(
          margin: EdgeInsets.all(5),
          padding: EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                keyboardType: TextInputType.text,
                controller: titleController,
                decoration: InputDecoration(labelText: 'Title'),
                onSubmitted: (_) => submitData(),
              ),
              TextField(
                keyboardType: TextInputType.number,
                controller: amountController,
                decoration: InputDecoration(labelText: 'Amount'),
                onSubmitted: (_) => submitData(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(transationDate == null
                      ? "No date chosen"
                      : 'Pick date: ${DateFormat.yMMMEd().format(transationDate as DateTime)}'),
                  TextButton(
                    style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all(Colors.purple)),
                    onPressed: _presentDatePicker,
                    child: const Text('chose date'),
                  )
                ],
              ),
              ElevatedButton(
                style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(
                        Color.fromARGB(255, 255, 255, 255))),
                onPressed: submitData,
                child: Text("Add Item"),
              )
            ],
          ),
        ));
  }
}
