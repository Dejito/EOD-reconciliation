import 'package:eod/providers/db_helper.dart';
import 'package:eod/providers/increase_model.dart';
import 'package:flutter/foundation.dart';

class PosWithdrawalBrain extends ChangeNotifier {

  final List <int> _transaction = [];

  final List <double> _increase = [];

  final List<int> _charges = [];

  List<int> get transaction {
    return [..._transaction];
  }

  List<Increase> databaseTransactions =[];

  List<double> get increase {
    return [..._increase];
  }

  List<int> get charges {
    return [..._charges];
  }

  void addTransaction(int amount) {
    _transaction.add(amount);
    notifyListeners();
  }

  void addIncrease(double amount) {
    _increase.add(amount);
    notifyListeners();
  }

  void saveToDb() {
   final newIncrease = Increase(id: DateTime.now().toString(), increaseAmount: sumOfIncreaseValue);
    DBHelperPOS.insert('user_increase', {
      'id': newIncrease.id,
      'increaseAmount': newIncrease.increaseAmount
    });
    notifyListeners();
  }


  Future<void> fetchAndSetIncrease() async {
    final dataList = await DBHelperPOS.getData('user_increase');
     databaseTransactions = dataList.map((item) => Increase(id: item['id'], increaseAmount: item['increaseAmount'])).toList();
     notifyListeners();
  }

  void removeTransDismissible(var id){
    _transaction.remove(id);
    notifyListeners();
  }

  void removeIncreaseDismissible(var id){
    _increase.remove(id);
    notifyListeners();
  }


  void addCharges (int charge) {
    _charges.add(charge);
    notifyListeners();
  }

  double? calcIncrease (int amount) {
    if(amount < 20000) {
      return amount*0.005;
    }
    if (amount >= 20000){
      return 100;
    }
    return 100;
  }

  double get sumOfIncreaseValue {
    double total = 0;
    for (var element in _increase) {
      total+= element;
    }
    return total;
  }

  // double get sumOfDbIncrease {
  //   double total = 0;
  //   for (var element in databaseTransactions) {
  //     total+= element.increaseAmount;
  //   }
  //   return total;
  // }

  void removeTransaction(){
    _transaction.removeLast();
    notifyListeners();
  }
  void removeIncrease(){
    _increase.removeLast();
    notifyListeners();
  }

}