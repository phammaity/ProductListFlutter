import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products_flutter/home/blocs/combine_buyers/combine_buyers_cubit.dart';

class QuestionTwoDemo extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(
      builder: (_) => BlocProvider(
        create: (_) => CombineBuyersCubit(),
        child: QuestionTwoDemo(),
      ),
    );
  }

  final TextEditingController _textFieldController = TextEditingController();
  QuestionTwoDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Question 2"),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter a search term',
              ),
              keyboardType: TextInputType.number,
              controller: _textFieldController,
            ),
            ElevatedButton(
                onPressed: () {
                  final int buyers = int.parse(_textFieldController.text);
                  context
                      .read<CombineBuyersCubit>()
                      .printAllCases(buyers: buyers);
                },
                child: Text("Print")),
            BlocBuilder<CombineBuyersCubit, List<String>>(
              builder: (context, state) => Text(
                "Count = " + state.length.toString(),
              ),
            ),
            Expanded(
              child: BlocBuilder<CombineBuyersCubit, List<String>>(
                builder: (context, state) => ListView.builder(
                  itemBuilder: (BuildContext context, int index) => Container(
                    child: Center(
                      child: Text(state[index]),
                    ),
                  ),
                  itemCount: state.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
