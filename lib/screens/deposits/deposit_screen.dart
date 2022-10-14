import 'package:eod/screens/deposits/deposit_increase_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:eod/providers/deposit_brain.dart';
import 'package:eod/widgets/deposit_listview.dart';

class DepositScreen extends StatefulWidget {
  static const id = 'deposit_screen';

  const DepositScreen({Key? key}) : super(key: key);

  @override
  State<DepositScreen> createState() => _DepositScreenState();
}

class _DepositScreenState extends State<DepositScreen> {

  @override
  void dispose() {
    _chargesFocusNode.dispose();
    _depositFocusNode.dispose();
    super.dispose();
  }

  final _depositFocusNode = FocusNode();
  final _chargesFocusNode = FocusNode();
  final _depositController = TextEditingController();
  final _chargesController = TextEditingController();
  var _deposit = '';
  var _charges = '';

  @override
  Widget build(BuildContext context) {
    final depoBrain = Provider.of<DepositBrain>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Deposit Screen'
        ),
        actions:  [
          CircleAvatar(
            radius: 16,
            child: Text('${depoBrain.deposit.length}',style: const TextStyle(
            color: Colors.white,
          ),),)
        ],
      ),
      body:
      Container(
        margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Column(
          children: [
            TextField(
              controller: _depositController,
              keyboardType: TextInputType.number,
              focusNode: _depositFocusNode,
              decoration: const InputDecoration(
                label: Text('deposit amount'),
              ),
              onSubmitted: (_){
                FocusScope.of(context).requestFocus(_chargesFocusNode);
              },
              onChanged: (value){
                _deposit = value;
              },
            ),
            TextField(
              focusNode: _chargesFocusNode,
              keyboardType: TextInputType.number,
              controller: _chargesController,
              decoration: const InputDecoration(
                label: Text('charged fee'),
              ),
              onChanged: (value){
                _charges = value;
              },
            ),
            const DepositListView(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                   onPressed: (){
                     if (_deposit.isEmpty || _charges.isEmpty) {
                       return;
                     }
                    int? depoAmount = int.tryParse(_deposit);
                    //add deposit to a list
                    depoBrain.addDeposit(depoAmount!);
                    //calculate profit
                    int? chargedFee = int.tryParse(_charges);
                    int? increase = depoBrain.calcProfit(chargedFee!);
                    //add to list
                    depoBrain.addIncrease(increase!);

                    _charges = '';
                    _deposit = '';
                    _depositController.clear();
                    _chargesController.clear();
                FocusScope.of(context).requestFocus(_depositFocusNode);
                    },
                    child: const Text('Add transaction')
                ),
                TextButton(
                    onPressed: (){
                    depoBrain.removeFromList();
                },
                    child: const Text('Undo add')
                ),
              ],
            ),
            ElevatedButton(
              onPressed:(){
                if(depoBrain.deposit.isEmpty){
                  return;
                }
                Navigator.of(context).pushNamed(DepositIncreaseScreen.id);
              },
              child: const Text('Calculate increase'),),
          ],
        ),
      ),
    );
  }
}
