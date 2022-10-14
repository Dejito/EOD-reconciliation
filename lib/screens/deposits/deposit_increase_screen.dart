import 'package:eod/providers/deposit_brain.dart';
import 'package:eod/screens/selection_screen.dart';
import 'package:flutter/material.dart';
import 'package:eod/widgets/increase_screen_widget.dart';
import 'package:provider/provider.dart';




class DepositIncreaseScreen extends StatelessWidget {
  static const id = 'deposit_increase_screen';

  const DepositIncreaseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final depo = Provider.of<DepositBrain>(context);
    final inc = depo.depositIncrease.toDouble();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Deposit Profit'),
      ),
      body:depo.deposit.isEmpty ?
      const Center(child: Text(
          'No transactions added yet!'
      ),) : IncreaseScreenWidget(
          hintText: '#20 is deducted for processing fee',
          increaseFigure: inc,
          listViewBuilder:
                ListView.builder(
                  itemBuilder: (context, i) {
                    return Card(
                      color: Colors.grey.shade400,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                        padding: const EdgeInsets.all(5),
                        child: Text(
                          '${depo.deposit[i]} gives ${depo.increase[i]} profit',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  },
                  itemCount: depo.deposit.length,
                ), pageNavigator: SelectionScreen.id,
          ),
    );
  }
}
