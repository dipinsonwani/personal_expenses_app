import 'package:flutter/material.dart';
import 'package:personal_expense_app/widgets/chart.dart';
import 'package:personal_expense_app/widgets/new_transaction.dart';
import 'models/transaction.dart';
import './widgets/transaction_list.dart';

void main() => runApp(MaterialApp(
      home: MyApp(),
      title: 'Personal Expenses App',
      theme: ThemeData(
          primarySwatch: Colors.green,
          accentColor: Colors.amber,
          fontFamily: 'Quicksand',
          textTheme: TextTheme(
              headline6: TextStyle(fontSize: 20),
              button: TextStyle(color: Colors.white))),
    ));

class MyApp extends StatefulWidget {
  // String titleInput;
  // String amountInput;
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // final titleController = TextEditingController();

  // final amountController = TextEditingController();
  final List<Transaction> _userTransactions = [
    Transaction(id: 't1', title: 'New ', amount: 99.2, date: DateTime.now()),
    Transaction(
       id: 't2', title: 'New Phone', amount: 400.5, date: DateTime.now())
  ];
  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addNewTransaction(String txTitle, double txAmount,DateTime chosenDate) {
    final newTx = Transaction(
        title: txTitle,
        amount: txAmount,
        date: chosenDate,
        id: DateTime.now().toString());

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
              onTap: () {},
              child:NewTransaction(
            _addNewTransaction,
            ),
            behavior: HitTestBehavior.opaque,
          ); //GestureDetector and behaviour used so that the Modal sheet doesnt close after tapping on it.
        });
  }
  void _deleteTransaction (String id){
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
    

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Expenses'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => startAddNewTransaction(context),
          )
        ],
      ),
      body: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Chart(_recentTransactions),
            TransactionList(_userTransactions, _deleteTransaction)
          ]),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => startAddNewTransaction(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
