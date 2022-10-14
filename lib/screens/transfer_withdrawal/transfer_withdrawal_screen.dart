import 'package:eod/screens/transfer_withdrawal/tx_with_increase_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/transaction_list_view.dart';
import '../../providers/tf_withdrawal_brain.dart';

class TransferWithdrawalScreen extends StatefulWidget {
  static const id = 'transfer_withdrawal';

   const TransferWithdrawalScreen({Key? key}) : super(key: key);

  @override
  State<TransferWithdrawalScreen> createState() => _TransferWithdrawalScreenState();
}

class _TransferWithdrawalScreenState extends State<TransferWithdrawalScreen> {

  @override
  void dispose() {
  _amountFocusNode.dispose();
  _chargesFocusNode.dispose();
    super.dispose();
  }

  final _amountController = TextEditingController();
  final _chargesController = TextEditingController();
  var _txAmount = '';
  var _chargeFee = '';
  final _chargesFocusNode = FocusNode();
  final _amountFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final txBrain = Provider.of<TransactionBrain>(context);
    return Scaffold(
     appBar: AppBar(
    title: const Text(
    'Transfer Withdrawal'
    ),
    actions:  [
    CircleAvatar(            radius: 16,
      child: Text('${txBrain.transaction.length}',style: const TextStyle(
    color: Colors.white
    ),),)
    ],
    ),
      body: Container(
         margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Column(
          children: [
            TextField(
              focusNode: _amountFocusNode,
              keyboardType: TextInputType.number,
              controller: _amountController,
              decoration: const InputDecoration(
                label: Text('amount withdrawn'),
              ),
              onSubmitted: (_){
                FocusScope.of(context).requestFocus(_chargesFocusNode);
              },
              onChanged: (value){
                try{
                  _txAmount = value;
                }
                catch(e) {
                  rethrow;
                }
              },
            ),
            TextField(
              focusNode: _chargesFocusNode,
              keyboardType: TextInputType.number,
              controller: _chargesController,
              decoration: const InputDecoration(
                label: Text('charge fee'),
              ),

              onChanged: (value){
                try{
                  _chargeFee = value;
                }
                catch(e) {
                  rethrow;
                }
              },
            ),
            const TransactionsListView(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                    onPressed: (){
                      if (_chargeFee.isEmpty || _txAmount.isEmpty) {
                        return;
                      }
                  //add to transaction list
                  txBrain.addTransaction(int.parse(_txAmount));
                  //convert string of amount withdrawn to int
                  int? chargesValue = int.tryParse(_chargeFee);
                  //put calculate result method here
                 int? increase =  txBrain.calculateTransferWithdrawalIncrease(chargesValue!);
                 //add the increase to a list
                  txBrain.addIncrease(increase!);

                  _amountController.clear();
                  _chargesController.clear();
                  _txAmount = '';
                  _chargeFee = '';
                  FocusScope.of(context).requestFocus(_amountFocusNode);
                },
                    child: const Text('Add transaction')
                ),
                TextButton(onPressed: (){
                  txBrain.removeTransaction();
                  txBrain.removeIncrease();
                },
                    child: const Text('Undo add')
                ),
              ],
            ),
            ElevatedButton(
                onPressed:(){
                  if(txBrain.transaction.isEmpty){
                    return;
                  }
                  final inCreaseValue = txBrain.sumOfIncreaseValue;
                  Navigator.of(context).pushNamed(TxWithIncreaseScreen.id, arguments: inCreaseValue);
                },
                child: const Text('Calculate increase'),),
          ],
        ),
      ),
    );
  }
}
