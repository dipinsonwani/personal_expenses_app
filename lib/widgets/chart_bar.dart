import 'package:flutter/material.dart';
import 'package:personal_expense_app/widgets/chart.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double perOfTotal;

  ChartBar(this.label, this.perOfTotal, this.spendingAmount);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(height: 20,
          child: FittedBox(child: Text('₹${spendingAmount.toStringAsFixed(0)}'))),
        SizedBox(height: 4),
        Container(
          height: 60,
          width: 10,
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    color: Color.fromRGBO(220, 220, 220, 1),
                    borderRadius: BorderRadius.circular(10)),
              ),
              FractionallySizedBox(
                heightFactor: perOfTotal,
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10)),
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 4),
        Text(label)
      ],
    );
  }
}
