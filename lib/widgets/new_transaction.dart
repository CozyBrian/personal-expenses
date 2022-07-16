import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addtransactionHandle;

  const NewTransaction(this.addtransactionHandle);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleTextController = TextEditingController();
  final amountTextController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  void addTX() {
    final enteredTitle = titleTextController.text;
    if (amountTextController.text.isEmpty) {
      return;
    }
    final enteredAmount = double.parse(amountTextController.text);
    
    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }
    widget.addtransactionHandle(enteredTitle, enteredAmount, selectedDate);

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return null;
      }
      setState(() {
        selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.only(
            top: 10, 
            left: 10, 
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10 ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: "Title"),
                controller: titleTextController,
                onSubmitted: (_) => addTX,
              ),
              TextField(
                decoration: const InputDecoration(labelText: "Amount"),
                controller: amountTextController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) => addTX,
              ),
              SizedBox(
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(selectedDate == null
                          ? "No date selected!"
                          : 'Picked Date: ${DateFormat.yMd().format(selectedDate)}'),
                    ),
                    OutlinedButton(
                      onPressed: _presentDatePicker,
                      style: OutlinedButton.styleFrom(
                        primary: Theme.of(context).primaryColor,
                      ),
                      child: const Text(
                        "Choose Date",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: addTX,
                style: OutlinedButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                child: const Text("Add Transaction"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
