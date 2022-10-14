import 'package:eod/screens/pos_withdrawal/pos_with_increase_screen.dart';
import 'package:eod/widgets/pos_withdrawal_listview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:eod/providers/pos_withdrawal_brain.dart';

class POSWithdrawalScreen extends StatefulWidget {
  static const id = 'pos_withdrawal_screen';

  const POSWithdrawalScreen({Key? key}) : super(key: key);

  @override
  State<POSWithdrawalScreen> createState() => _POSWithdrawalScreenState();
}

class _POSWithdrawalScreenState extends State<POSWithdrawalScreen> {

  @override
  void dispose() {
    _chargesFocusNode.dispose();
    _amountFocusNode.dispose();
    super.dispose();
  }

  final _amountController = TextEditingController();

  final  _chargeController = TextEditingController();

  final _chargesFocusNode = FocusNode();

  final _amountFocusNode = FocusNode();

  var _amountWithdrawn = '';

  var _charges = '';

  @override
  Widget build(BuildContext context) {
    final posBrain = Provider.of<PosWithdrawalBrain>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('POS Withdrawals'),
          actions:  [
            CircleAvatar(
              radius: 16,
              child: Text('${posBrain.transaction.length}',style: const TextStyle(
                color: Colors.white
            ),
            ),
            ),
          ],
        ),
      body: Container(
        margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Column(
          children: [
            TextField(
              controller: _amountController,
              focusNode: _amountFocusNode,
              decoration: const InputDecoration(
                label: Text('amount withdrawn'),
              ),
              onSubmitted: (_){
                FocusScope.of(context).requestFocus(_chargesFocusNode);
              },
              keyboardType: TextInputType.number,
              onChanged: (value){
                _amountWithdrawn = value;
              },
            ),
            TextField(
              focusNode: _chargesFocusNode,
              controller: _chargeController,
              decoration: const InputDecoration(
                label: Text('charged fee'),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value){
                _charges = value;
              },
            ),
            const PosWithdrawalListview(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                    onPressed: (){
                      if(_charges.isEmpty || _amountWithdrawn.isEmpty) {
                        return;
                      }
                      // FocusScope.of(context).requestFocus(_amountFocusNode);
                      //add transaction to list
                      int? amount = int.tryParse(_amountWithdrawn);
                      posBrain.addTransaction(amount!);
                      //accept amount charged
                      int? amountCharged = int.tryParse(_charges);
                      //calculate increase accrued from the transaction
                      double? posCharges = posBrain.calcIncrease(amount);
                      double increase = amountCharged! - posCharges!;
                      //store the increase to a list
                      posBrain.addIncrease(increase);
                      _charges = '';
                      _amountWithdrawn = '';
                      _amountController.clear();
                      _chargeController.clear();
                      FocusScope.of(context).requestFocus(_amountFocusNode);
                      },
                    child: const Text('Add transaction')
                ),
                TextButton(onPressed: (){
                  posBrain.removeIncrease();
                  posBrain.removeTransaction();
                },
                    child: const Text('Undo add')
                ),
              ],
            ),
            ElevatedButton(
              onPressed:(){
                if(posBrain.transaction.isEmpty){
                  return;
                }
                _chargesFocusNode.unfocus();
                // final totalIncrease = posBrain.sumOfIncreaseValue;
                Navigator.of(context).pushNamed(PosWithIncreaseScreen.id, );
              },
              child: const Text('Calculate increase'),),
          ],
        ),
      ),
    );
  }
}
