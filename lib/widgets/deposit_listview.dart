import 'package:eod/providers/deposit_brain.dart';
import 'package:flutter/material.dart';
import 'package:eod/widgets/transactions_listview_items.dart';
import 'package:provider/provider.dart';


class DepositListView extends StatelessWidget {
  const DepositListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final depo = Provider.of<DepositBrain>(context);
    return Expanded(
        child: ListView.builder(
            itemBuilder: (context, i){
              return Dismissible(
                key: ValueKey(depo.deposit[i]),
              direction: DismissDirection.startToEnd,
              onDismissed: (dismissed){
                depo.removeTransDismissible(depo.deposit[i]);
                depo.removeIncreaseDismissible(depo.increase[i]);
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
                ),),
                child: TransactionsListviewItems(
                  text: depo.deposit[i].toString()
                ),
              );
            },
            itemCount: depo.deposit.length,
        ),
    );
  }
}
