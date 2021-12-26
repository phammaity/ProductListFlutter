import 'package:flutter/material.dart';
import 'package:products_flutter/home/screens/product_screen.dart';
import 'package:products_flutter/home/screens/question_two_demo.dart';

class HomeScreen extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomeScreen());
  }

  const HomeScreen({Key? key}) : super(key: key);

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
                  Navigator.of(context).push(ProductScreen.route());
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
