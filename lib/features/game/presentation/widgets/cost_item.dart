import 'package:flutter/material.dart';

class CostItem extends StatelessWidget {
  final String text;
  final bool canAfford;

  const CostItem(this.text, this.canAfford, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: canAfford ? Colors.green : Colors.red,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
