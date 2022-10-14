
import 'package:eod/providers/pos_withdrawal_brain.dart';
import 'package:eod/screens/landing_page.dart';
import 'package:eod/screens/selection_screen.dart';
import 'package:eod/screens/transfer_withdrawal/transfer_withdrawal_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:eod/providers/tf_withdrawal_brain.dart';
import 'package:eod/screens/transfer_withdrawal/tx_with_increase_screen.dart';
import 'package:eod/screens/pos_withdrawal/pos_withdrawal_screen.dart';
import 'package:eod/screens/pos_withdrawal/pos_with_increase_screen.dart';
import 'package:eod/screens/deposits/deposit_screen.dart';
import 'package:eod/providers/deposit_brain.dart';
import 'package:eod/screens/deposits/deposit_increase_screen.dart';
import 'package:eod/screens/total_profit/total_profit.dart';
import 'package:eod/screens/history.dart';
import 'package:eod/providers/profit_db.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: TransactionBrain(),
        ),
        ChangeNotifierProvider.value(
          value: PosWithdrawalBrain(),),
        ChangeNotifierProvider.value(
            value: DepositBrain(),),
        ChangeNotifierProvider.value(
            value: ProfitDatabase()),
      ],

        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: Colors.black,
              fontFamily: 'Lato',
              buttonTheme: ButtonTheme.of(context).copyWith(
              buttonColor: Colors.green,
            )
          ),
          home: const LandingPage(),
          routes: {
            LandingPage.id: (context) => const LandingPage(),
            SelectionScreen.id: (context) => const SelectionScreen(),
            TransferWithdrawalScreen.id: (context) => const TransferWithdrawalScreen(),
            TxWithIncreaseScreen.id: (context) => const TxWithIncreaseScreen(),
            POSWithdrawalScreen.id: (context) =>  const POSWithdrawalScreen(),
            PosWithIncreaseScreen.id: (context) =>  const PosWithIncreaseScreen(),
            DepositScreen.id: (context) => const DepositScreen(),
            DepositIncreaseScreen.id: (context) => const DepositIncreaseScreen(),
            TotalProfit.id: (context) => const TotalProfit(),
            History.id: (context) => const History(),
          },
        ),
    );
  }
}
