import 'package:eod/screens/selection_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/tf_withdrawal_brain.dart';

class TxWithIncreaseScreen extends StatelessWidget {
  static const id = 'tx_with_increase_screen';

  const TxWithIncreaseScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final txBrain = Provider.of<TransactionBrain>(context);
    final increaseFigure = txBrain.sumOfIncreaseValue;

        // ModalRoute.of(context)?.settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Transfer Withdrawal Profit'
        ),
      ),
      body: increaseFigure <= 0 ? const Center(child: Text('No transactions added yet!'),): Column(
        children: [
          Container(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              child: const Card( child:
              Text( 'It is assumed that at least #200 is charged for withdrawal of #10,000. #50 stamp duty is thus deducted for increase figure of #200 and above',
              style: TextStyle(
                fontSize: 13
              ),
              ))),
          Expanded(child:
            ListView.builder(
             shrinkWrap: true,
             itemBuilder: (context, i){
               return Card(
                 color: Colors.grey.shade400,
                 child: Container(
                   margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    padding: const EdgeInsets.all(5),
                   alignment: Alignment.center,
                   child: Text(
                       '${txBrain.transaction[i]} gives ${txBrain.increase[i]} profit',
                   ),
                 ),
               );
             },
             itemCount: txBrain.increase.length,
            )
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Card(
                elevation: 5,
                color: Colors.blueAccent,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    'Total increase $increaseFigure',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 19,
                        color: Colors.white
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              TextButton(onPressed: (){
                Navigator.of(context).pushReplacementNamed(SelectionScreen.id);
              }, child: const Text('Return'))
            ]
          )

        ],
      ),
    );
  }
}
