import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './widgets/chart.dart';
import './widgets/transaction_list.dart';
import './models/transaction.dart';
import './widgets/new_transaction.dart';

void main() {
  runApp(const MyApp());
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp]
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
          primarySwatch: Colors.green,
          fontFamily: "Quicksand",
          appBarTheme: const AppBarTheme()),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    Transaction("T1", "SomeBags", 12.92, DateTime.now()),
    Transaction("T2", "Spotify", 33.99, DateTime.now()),
    Transaction("T3", "F and J", 69.99, DateTime.now()),
    Transaction("T1", "SomeBags", 12.92, DateTime.now()),
    Transaction("T2", "Spotify", 33.99, DateTime.now()),
    Transaction("T3", "F and J", 69.99, DateTime.now()),
    Transaction("T1", "SomeBags", 12.92, DateTime.now()),
    Transaction("T2", "Spotify", 33.99, DateTime.now()),
    Transaction("T3", "F and J", 69.99, DateTime.now()),
  ];

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          const Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(String txTitle, double txAmount, DateTime date) {
    final newTX =
        Transaction(DateTime.now().toString(), txTitle, txAmount, date);

    setState(() {
      _userTransactions.add(newTX);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  void _startAddNewtransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransaction(_addNewTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: const Text("Personal Expenses"),
      actions: [
        IconButton(
            onPressed: () => _startAddNewtransaction(context),
            icon: const Icon(Icons.add))
      ],
    );

    return Scaffold(
      appBar: appBar,
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.24,
                child: Chart(_recentTransactions)),
            SizedBox(
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.76,
                child: TransactionList(_userTransactions, _deleteTransaction)),
          ],
        ),
      ),
    );
  }
}
