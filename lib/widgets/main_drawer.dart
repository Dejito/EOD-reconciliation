import 'package:eod/providers/deposit_brain.dart';
import 'package:eod/providers/profit_db.dart';
import 'package:eod/providers/tf_withdrawal_brain.dart';
import 'package:eod/screens/history.dart';
import 'package:eod/screens/deposits/deposit_increase_screen.dart';
import 'package:eod/screens/pos_withdrawal/pos_with_increase_screen.dart';
import 'package:eod/screens/selection_screen.dart';
import 'package:eod/screens/total_profit/total_profit.dart';
import 'package:eod/screens/transfer_withdrawal/tx_with_increase_screen.dart';
import 'package:flutter/material.dart';
import 'package:eod/providers/pos_withdrawal_brain.dart';
import 'package:provider/provider.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  Widget listTile({required Function() onTap, required String txType, required IconData icon}) {
    return ListTile(
      leading:  Icon(
          icon
      ),
      title: Text(
        txType,
        style: const TextStyle(
            fontSize: 17
        ),
      ),
      onTap: onTap
      
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Container(
              height: 120,
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              alignment: Alignment.centerLeft,
              color: Colors.blueGrey,
              child: const Text ('Cooking Up!',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 30,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            listTile(
              txType: 'Home',
              icon: Icons.home_outlined,
              onTap: (){
                Navigator.of(context).pushNamed(SelectionScreen.id);
              },
            ),
            const Divider(thickness: 1,),
            listTile(
                txType: 'POS Profit',
                icon: Icons.calculate,
                onTap: (){
              Navigator.of(context).pushNamed(PosWithIncreaseScreen.id);
            },
            ),
            const Divider(thickness: 1,),
            listTile(
              txType: 'Transfer Withdrawal Profit',
              icon: Icons.money,
              onTap: (){
                Navigator.of(context).pushNamed(TxWithIncreaseScreen.id);
              },
            ),
            const Divider(thickness: 1,),
            listTile(
              txType: 'Deposit Profit',
              icon: Icons.monetization_on,
              onTap: (){
                Navigator.of(context).pushNamed(DepositIncreaseScreen.id);
              },
            ),
            const Divider(thickness: 1,),

            listTile(
              txType: 'Total Profit ',
              icon: Icons.calendar_today,
              onTap: (){
                Navigator.of(context).pushNamed(TotalProfit.id);
              },
            ),
            const Divider(thickness: 1,),
            listTile(
              txType: 'History',
              icon: Icons.history,
              onTap: () async{
                await Provider.of<TransactionBrain>(context, listen: false).fetchAndSetData();
                await Provider.of<PosWithdrawalBrain>(context,listen: false).fetchAndSetIncrease();
                await Provider.of<DepositBrain>(context, listen: false).fetchAndSetData();
                await Provider.of<ProfitDatabase>(context, listen: false).fetchAndSetData();
                Navigator.of(context).pushNamed(History.id);
              },
            ),
            const Divider(thickness: 1,),
          ],
        ),
      ),
    );
  }
}
