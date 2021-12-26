import 'package:bloc/bloc.dart';

class CombineBuyersCubit extends Cubit<List<String>> {
  final List<String> _initValue = [];
  final List<String> _cases = ["0", "1", "2"];
  CombineBuyersCubit() : super(["init state"]);

  void printAllCases({required int buyers}) =>
      emit(_combinationCases(buyers: buyers));

  List<String> _combinationCases({required int buyers}) {
    final List<int> generatedList = List<int>.generate(buyers, (i) => i + 1);
    print(generatedList);
    return generatedList.fold(_initValue, (previousValue, _) {
      return _combineItems(items: previousValue);
    });
  }

  List<String> _combineItemWithCases({required String item}) {
    return this._cases.map((e) => (item + "-" + e)).toList();
  }

  List<String> _combineItems({required List<String> items}) {
    if (items.isEmpty) {
      return _cases;
    }
    final List<String> result =
        items.fold(_initValue, (previousValue, element) {
      var newList = new List<String>.from(previousValue)
        ..addAll(_combineItemWithCases(item: element));
      return newList;
    });
    return result;
  }
}
