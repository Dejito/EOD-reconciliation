import 'package:eod/screens/selection_screen.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  static const id = 'landing_page';

  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EOD Reconciliation'
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
             margin: const EdgeInsets.all(5),
            child: Image.asset('assets/images/landing_page.png',
            fit: BoxFit.fill,
       ),
          ),
          const SizedBox(height: 10),
          ElevatedButton.icon(
              onPressed: (){
                Navigator.of(context).pushReplacementNamed(SelectionScreen.id);
              },
              // style: ButtonStyle(
              //   tapTargetSize: MaterialTapTargetSize.padded
              // ),
              icon: const Icon(
                Icons.arrow_forward_ios_sharp
              ),
              label: const Text('Get Started')
          ),
        ],
      ),
    );
  }
}
