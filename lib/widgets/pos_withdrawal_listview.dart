import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:eod/providers/pos_withdrawal_brain.dart';
import 'package:eod/widgets/transactions_listview_items.dart';


class PosWithdrawalListview extends StatelessWidget {
  const PosWithdrawalListview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pos = Provider.of<PosWithdrawalBrain>(context);
    return Expanded(
      child: SingleChildScrollView(
        child: ListView.builder(
          shrinkWrap: true,
          reverse: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, i) {
            return Dismissible(
              key: ValueKey(pos.transaction[i]),
              direction: DismissDirection.startToEnd,
              onDismissed: (dismissed){
                pos.removeTransDismissible(pos.transaction[i]);
                pos.removeIncreaseDismissible(pos.increase[i]);
              },
              background: Container(
                margin: const EdgeInsets.only(top: 3),
                padding: const EdgeInsets.only(left: 12),
                decoration: BoxDecoration(
                  color: Theme.of(context).errorColor,
                  borderRadius: BorderRadius.circular(4)
                ),
                alignment: Alignment.centerLeft,
                child: const Icon(
                  Icons.delete,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              child: TransactionsListviewItems(
                text:pos.transaction[i].toString(),
              ),
            );
          },
          itemCount: pos.transaction.length,
        ),
      ),
    );
  }
}
