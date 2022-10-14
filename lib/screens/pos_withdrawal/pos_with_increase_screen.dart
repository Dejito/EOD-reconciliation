import 'package:eod/providers/pos_withdrawal_brain.dart';
import 'package:eod/screens/selection_screen.dart';
import 'package:flutter/material.dart';
import 'package:eod/widgets/increase_screen_widget.dart';
import 'package:provider/provider.dart';

class PosWithIncreaseScreen extends StatelessWidget {
  static const id = 'pos_with_increase_screen';

  const PosWithIncreaseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final pos = Provider.of<PosWithdrawalBrain>(context);
    final increaseFigure = pos.sumOfIncreaseValue;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'POS Profit'
        ),
      ),
      body: increaseFigure <= 0 ? const Center(child:  Text('No transactions added yet!'),)
          :IncreaseScreenWidget(
        hintText: 'charge rate is calculated at 0.5% capped at #100',
        increaseFigure: increaseFigure,
        listViewBuilder: ListView.builder(
            itemBuilder: (context, i) {
              return Card(
                color: Colors.grey.shade400,
                  child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  padding: const EdgeInsets.all(5),
                  child: Text(
                  '${pos.transaction[i]} gives ${pos.increase[i].toStringAsFixed(1)} profit',
                    textAlign: TextAlign.center,
                  ),
                  ),
                  );
            },
            itemCount: pos.increase.length,
        ),
        pageNavigator: SelectionScreen.id,

      ),
    );
  }
}
