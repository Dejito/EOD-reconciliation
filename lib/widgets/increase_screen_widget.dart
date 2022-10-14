import 'package:flutter/material.dart';

class IncreaseScreenWidget extends StatelessWidget {

  final String hintText;
  final double increaseFigure;
  final Widget listViewBuilder;
  final String pageNavigator;

   const IncreaseScreenWidget({Key? key, required this.hintText, required this.increaseFigure, required this.listViewBuilder, required this.pageNavigator}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            child: Card( child:
            Text( hintText,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 13
              ),
            ))),
        Expanded (
            child: listViewBuilder
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Card(
              elevation: 5,
              color: Colors.blueAccent,

              child: Padding(
                padding: const EdgeInsets.all(9.0),
                child: Text(
                  'Total increase  ${increaseFigure.toStringAsFixed(1)}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 19,
                      color: Colors.white
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            TextButton(onPressed: (){
              Navigator.of(context).pushReplacementNamed(pageNavigator);
            }, child: const Text('Return',
            style: TextStyle(
              fontWeight: FontWeight.bold
            ),))
          ],

        ),

      ],
    );
  }
}


// {txBrain.transaction[i]}
// {txBrain.increase[i]}

// ListView.builder(
// itemBuilder: (context, i){
// return Card(
// child: Container(
// margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
// padding: const EdgeInsets.all(5),
// child: Text(
// '$txTypeIndex gives $txProfitIndex profit',
// ),
// ),
// );
// },
// itemCount: listViewLength,
// )