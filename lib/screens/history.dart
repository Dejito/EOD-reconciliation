import 'package:eod/providers/deposit_brain.dart';
import 'package:eod/providers/profit_db.dart';
import 'package:eod/providers/tf_withdrawal_brain.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:eod/providers/pos_withdrawal_brain.dart';

class History extends StatefulWidget {
  static const id = 'history';
  const History({Key? key}) : super(key: key);
  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
   @override
  Widget build(BuildContext context) {
   final  pos = Provider.of<PosWithdrawalBrain>(context, listen: false);
   final posDB = pos.databaseTransactions;
   final transferDb = Provider.of<TransactionBrain>(context, listen: false).databaseTransactions;
   final depoDb = Provider.of<DepositBrain>(context, listen: false).databaseTransactions;
   final profitDb = Provider.of<ProfitDatabase>(context).profit;
   final controller = ScrollController();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'History'
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
            future: pos.fetchAndSetIncrease(),
            builder:  (context, snapshot) =>
              snapshot.connectionState== ConnectionState.waiting || posDB.isEmpty ?
              const Center(child: Text('No transactions added yet!'),) :
               SingleChildScrollView(
                 // reverse: true,
                 controller: controller,
                 // physics: NeverScrollableScrollPhysics(),
                 child: ListView.builder(
                   reverse: true,
                   shrinkWrap: true,
                   physics: const NeverScrollableScrollPhysics(),
                   itemBuilder: (context, i){
                  return Card(
                    child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Text(posDB[i].id.substring(0,11),style: const TextStyle(
                                color: Colors.blue
                            ),),
                            Text(
                                'POS increase is ${posDB[i].increaseAmount.toString()}'),
                            Text(
                              'Tf Withdrawal increase is  ${transferDb[i].increaseAmount.toString()}',
                            ),
                            Text(
                              'Deposit increase is  ${depoDb[i].increaseAmount.toString()}',
                            ),
                      Text(
                        'Total increase is  ${profitDb[i].increaseAmount.toString()}',
                      style: const TextStyle(
                        color: Colors.blue
                        ),
                      ),
                          ],
                        )
                    ),
                  );
              },
                  itemCount: pos.databaseTransactions.length,
              ),
               ),
          ),
          ),
        ],
      ),
    );
  }
}
