import 'package:flutter/material.dart';
import '../screens/screens.dart';

class DemoScreen extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => DemoScreen());
  }

  const DemoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(HomeScreen.route());
                },
                child: Text("Question 1")),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(QuestionTwoDemo.route());
                },
                child: Text("Question 2"))
          ],
        ),
      ),
    );
  }
}
