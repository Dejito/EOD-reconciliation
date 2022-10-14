import 'package:eod/providers/db_helper.dart';
import 'package:eod/providers/increase_model.dart';
import 'package:flutter/foundation.dart';

class DepositBrain extends ChangeNotifier {

  final List<int> _deposit = [];
  final List<int> _increase = [];

  List<Increase> _databaseTransactions = [];

  List<Increase> get databaseTransactions {
    return [..._databaseTransactions];
}


  List<int> get deposit {
    return [..._deposit];
  }

  List<int> get increase {
    return [..._increase];
  }

  void saveToDb(){
    final newIncrease = Increase(id: DateTime.now().toString(), increaseAmount: depositIncrease.toDouble());
    DBHelperDeposit.insert('deposit_increase', {
      'id': newIncrease.id,
      'increaseAmount': newIncrease.increaseAmount
    });
    notifyListeners();
  }

  Future<void> fetchAndSetData() async {
    final dbData = await DBHelperDeposit.getData('deposit_increase');
    _databaseTransactions = dbData.map((item) => Increase(id: item['id'], increaseAmount: item['increaseAmount'])).toList();
  }

  void addDeposit(int depo) {
    _deposit.add(depo);
    notifyListeners();
  }

  void addIncrease(int amount) {
    _increase.add(amount);
    notifyListeners();
  }

  int? calcProfit(int amount) {
    return amount - 20;
  }

  int get depositIncrease{
    int total = 0;
    for (var element in _increase) {
       total += element;
    }
    return total;
  }

  void removeFromList(){
    _deposit.removeLast();
    notifyListeners();
  }

  void removeTransDismissible(var id){
    _deposit.remove(id);
    notifyListeners();
  }

  void removeIncreaseDismissible(var id){
    _increase.remove(id);
    notifyListeners();
  }


}