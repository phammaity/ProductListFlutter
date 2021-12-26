import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products_flutter/home/blocs/fetch_products/product_bloc.dart';
import 'package:products_flutter/home/views/item_row_view.dart';

class ProductScreen extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => ProductScreen());
  }

  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Products"),
      ),
      body: BlocProvider(
        create: (_) => ProductBloc()..add(FetchProducts()),
        child: ProductList(),
      ),
    );
  }
}

class ProductList extends StatefulWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        switch (state.status) {
          case ProductStatus.failure:
            return const Center(child: Text('failed to fetch posts'));
          case ProductStatus.success:
            if (state.products.isEmpty) {
              return const Center(child: Text('no posts'));
            }
            return ListView.separated(
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
              itemBuilder: (BuildContext context, int index) {
                return index >= state.products.length
                    ? Text("Loading...")
                    : ItemRowView.fromItemModel(state.products[index]);
              },
              itemCount: state.hasReachedMax
                  ? state.products.length
                  : state.products.length + 1,
              controller: _scrollController,
            );
          default:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) context.read<ProductBloc>().add(FetchProducts());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
