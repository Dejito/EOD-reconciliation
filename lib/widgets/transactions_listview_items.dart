import 'package:flutter/material.dart';

class TransactionsListviewItems extends StatelessWidget {

  final String text;
  const TransactionsListviewItems({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.shade400,
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            '#$text',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

