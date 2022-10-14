import 'package:eod/providers/deposit_brain.dart';
import 'package:eod/providers/pos_withdrawal_brain.dart';
import 'package:eod/providers/tf_withdrawal_brain.dart';
import 'package:flutter/material.dart';
import 'package:eod/providers/profit_db.dart';
import 'package:provider/provider.dart';


class TotalProfit extends StatelessWidget {
  static const id = 'total_profit_screen';
  const TotalProfit({Key? key}) : super(key: key);


  Widget profitContainer({required String profit, required String transactionType}) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 18, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$transactionType profit'
          ),
          Text(
            profit,
            textAlign: TextAlign.left,
            style: const TextStyle(
                fontSize: 19
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final depo = Provider.of<DepositBrain>(context, listen: false);
    final pos = Provider.of<PosWithdrawalBrain>(context, listen: false);
    final transfer = Provider.of<TransactionBrain>(context, listen: false);
    final profit = Provider.of<ProfitDatabase>(context, listen: false);
    double netProfit = depo.depositIncrease + pos.sumOfIncreaseValue + transfer.sumOfIncreaseValue;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Total Profit Summary'),
      ),
      // body: FutureBuilder(
      //   future: posD,
      //   builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          body: netProfit ==0 ? const Center(
            child: Text('No transactions added yet!'),)
              :
          Column(
            children: [
              Column(
                children: [
                  profitContainer(
                      transactionType: 'POS',
                      profit: '${pos.sumOfIncreaseValue}'
                  ),
                  profitContainer(
                      transactionType: 'Transfer',
                      profit: '${transfer.sumOfIncreaseValue}'
                  ),
                  profitContainer(
                      transactionType: 'Deposit',
                      profit: '${depo.depositIncrease}'
                  ),
                ],
              ),
             const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(11),
                    child: Text(
                      'Total Profit  $netProfit',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.5,
                          color: Colors.white
                      ),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () async{
                      pos.saveToDb();
                      transfer.saveToDb();
                      depo.saveToDb();
                      profit.saveToDb(netProfit);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text(
                          'Saved!',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        backgroundColor: Colors.green,
                        )
                      );
                    },
                    label: const Text(
                      'Save',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: Colors.white
                      ),
                    ),
                    icon: const Icon(
                        Icons.save
                    ),
                  ),
                ],
              )

            ],
          ),
    );
  }
}
