import 'package:bloc/bloc.dart';

class CombineBuyersCubit extends Cubit<List<String>> {
  final List<List<int>> _initValue = [];
  final List<int> _cases = [0, 1, 2]; //number of sneaker that one buyer can buy
  CombineBuyersCubit() : super([]);

  void printAllCases({required int buyers}) =>
      emit(_displayedValue(buyers: buyers));

  List<String> _displayedValue({required int buyers}) {
    final result = _combinationCases(buyers: buyers);
    return result.map((e) => e.join("-")).toList();
  }

  List<List<int>> _combinationCases({required int buyers}) {
    final List<int> generatedList = List<int>.generate(buyers, (i) => i + 1);
    return generatedList.fold(_initValue, (previousValue, _) {
      return _expandMatrix(matrix: previousValue);
    });
  }

  /*
  * row = [0, 0]
  * _addColumn(row)
  * Result: [[0, 0, 0], [0, 0, 1], [0, 0, 2]]
  * */
  List<List<int>> _addColumn({required List<int> row}) {
    return this._cases.map((e) {
      var newRow = new List<int>.from(row);
      newRow.add(e);
      return newRow;
    }).toList();
  }

  /*
  * matrix = [[0], [1], [2]]
  * _expandMatrix(matrix)
  * Result: [[0, 0], [0, 1], [0, 2],
  *          [1, 0], [1, 1], [1, 2],
  *          [2, 0], [2, 1], [2, 2]]
  * */
  List<List<int>> _expandMatrix({required List<List<int>> matrix}) {
    if (matrix.isEmpty) {
      return _addColumn(row: []);
    }
    final List<List<int>> result =
        matrix.fold(_initValue, (previousMatrix, row) {
      final rows = _addColumn(row: row);
      var newMatrix = new List<List<int>>.from(previousMatrix)..addAll(rows);
      return newMatrix;
    });
    return result;
  }
}
