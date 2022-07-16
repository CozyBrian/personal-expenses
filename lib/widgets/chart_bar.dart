import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPctOfTotal;

  const ChartBar(this.label, this.spendingAmount, this.spendingPctOfTotal);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: ((context, constraints) => 
    Column(
      children: [
        SizedBox(
          height: constraints.maxHeight * 0.16,
          child: FittedBox(
            child: Text("\$${spendingAmount.toStringAsFixed(0)}"),
          ),
        ),
        SizedBox(
          height: constraints.maxHeight * 0.04,
        ),
        SizedBox(
          height: constraints.maxHeight * 0.6,
          width: 10,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).primaryColor,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              FractionallySizedBox(
                heightFactor: spendingPctOfTotal,
                child: Container(
                  decoration:
                      BoxDecoration(color: Theme.of(context).primaryColor),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: constraints.maxHeight * 0.04,
        ),
        SizedBox(
          height: constraints.maxHeight * 0.15,
          child: FittedBox(child: Text(label))
        ),
      ],
    )
    ));
  }
}
