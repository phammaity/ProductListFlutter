library api_repository;

export 'service/api_provider.dart';

/// A Calculator.
class Calculator {
  /// Returns [value] plus 1.
  int addOne(int value) => value + 1;

  // void printCombination() {
  //   final int numberOfBuyers = 2;
  //   final List<int> oneBuyer = [
  //     0,
  //     1,
  //     2
  //   ]; //Number of sneakers cases that one buyer can buy.
  //   final List<int> buyers =
  //       List<int>.generate(numberOfBuyers, (index) => index);
  //   List<List<int>> result = [[]];
  //
  //   String text = buyers.reduce((value, element) => element.toString());
  // }
}
