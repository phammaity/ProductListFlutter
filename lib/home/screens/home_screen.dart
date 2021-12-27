import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../components/components.dart';
import '../blocs/blocs.dart';
import '../screens/screens.dart';
import '../views/views.dart';

class HomeScreen extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomeScreen());
  }

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: BlocProvider(
        create: (_) => ProductBloc()..add(FetchProducts()),
        child: TopProductsScreen(),
      ),
    );
  }
}

class TopProductsScreen extends StatelessWidget {
  const TopProductsScreen({Key? key}) : super(key: key);
  final int _numberOfSection = 2;
  final int _numberOfActions = 1;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        switch (state.status) {
          case ProductStatus.failure:
            return const Center(child: Text('something wrong'));
          case ProductStatus.success:
            if (state.products.isEmpty) {
              return const Center(child: Text('no items'));
            }
            //generate list items
            List<ListItem> items = [];
            items.add(SectionItem("Trending"));
            items.addAll(state.topProducts.map(
              (e) => ItemRowView.fromItemModel(e),
            ));
            items.add(SectionItem("Just dropped"));
            items.addAll(state.justDroppedProducts.map(
              (e) => ItemRowView.fromItemModel(e),
            ));
            items.add(ActionItem(
              name: "See all",
              onTap: () {
                Navigator.of(context)
                    .push(ProductScreen.route(BlocProvider.of(context)));
              },
            ));
            return ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return items[index] as Widget;
                },
                itemCount: state.topProducts.length +
                    state.justDroppedProducts.length +
                    _numberOfSection +
                    _numberOfActions);
          default:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
