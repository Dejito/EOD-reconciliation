import 'package:flutter/foundation.dart';
import 'package:eod/providers/db_helper.dart';
import 'package:eod/providers/increase_model.dart';

class ProfitDatabase with ChangeNotifier{

  List<Increase> _profit = [];

  List<Increase> get profit {
    return [..._profit];
  }

  void saveToDb(double increaseAmount)  async {
    final newDB =  Increase(id: DateTime.now().toString(), increaseAmount: increaseAmount);
    DBHelperProfit.insert('userProfit', {
      'id': newDB.id,
      'increaseAmount': newDB.increaseAmount
    });
    notifyListeners();
  }

  Future<void> fetchAndSetData() async {
   final dataList = await DBHelperProfit.getData('userProfit');
   _profit = dataList.map((item) => Increase(
       id: item['id'],
       increaseAmount: item['increaseAmount'])).toList();
    notifyListeners();
  }
}