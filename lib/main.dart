import 'package:api_repository/api_repository.dart';
import 'package:flutter/material.dart';
import 'home/screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _navigatorKey = GlobalKey<NavigatorState>();
  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    final testVal = Calculator();
    print(testVal.addOne(10));
    return MaterialApp(
        title: 'Flutter test assignment',
        navigatorKey: _navigatorKey,
        onGenerateRoute: (_) => HomeScreen.route(),
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        builder: (context, child) {
          return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: child ?? Container());
        });
  }
}
