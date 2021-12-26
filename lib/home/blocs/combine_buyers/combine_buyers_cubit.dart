import 'package:bloc/bloc.dart';

class CombineBuyersCubit extends Cubit<List<String>> {
  final List<List<int>> _initValue = [];
  final List<int> _cases = [0, 1, 2];
  CombineBuyersCubit() : super([]);

  void printAllCases({required int buyers}) =>
      emit(_displayString(buyers: buyers));

  List<String> _displayString({required int buyers}) {
    final result = _combinationCases(buyers: buyers);
    return result.map((e) => e.join("-")).toList();
  }

  List<List<int>> _combinationCases({required int buyers}) {
    final List<int> generatedList = List<int>.generate(buyers, (i) => i + 1);
    return generatedList.fold(_initValue, (previousValue, _) {
      return _combineItems(items: previousValue);
    });
  }

  List<List<int>> _combineItemWithCases({required List<int> items}) {
    return this._cases.map((e) {
      var newList = new List<int>.from(items);
      newList.add(e);
      return newList;
    }).toList();
  }

  List<List<int>> _combineItems({required List<List<int>> items}) {
    if (items.isEmpty) {
      return [
        [0],
        [1],
        [2]
      ];
    }
    final List<List<int>> result =
        items.fold(_initValue, (previousValue, element) {
      final combineItems = _combineItemWithCases(items: element);
      var newList = new List<List<int>>.from(previousValue)
        ..addAll(combineItems);
      return newList;
    });
    return result;
  }
}
