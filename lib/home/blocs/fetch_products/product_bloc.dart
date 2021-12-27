import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:api_repository/models/item.dart';
import 'package:api_repository/api_repository.dart';
part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(const ProductState()) {
    on<FetchProducts>(_onProductFetched);
  }

  Future<AllItems> _fetchProducts({required int index}) async {
    final result = await ApiProvider.instance().fetchLocalItems();
    return result;
  }

  Future<void> _onProductFetched(
      FetchProducts event, Emitter<ProductState> emit) async {
    if (state.hasReachedMax) return;
    try {
      final response = await _fetchProducts(index: state.products.length);
      final filteredList = response.items
          .where((item) => !item.isDeleted && item.status == "active")
          .toList();
      filteredList.sort((item0, item1) => item0.rank.compareTo(item1.rank));
      final topItems = filteredList.take(10).toList();
      final justDroppedItems =
          filteredList.where((item) => item.justDropped).toList();

      return emit(state.copyWith(
        status: ProductStatus.success,
        products: response.items,
        topProducts: topItems,
        justDroppedProducts: justDroppedItems,
        hasReachedMax:
            response.pagination.totalCount <= response.pagination.pageSize,
      ));
    } catch (_) {
      emit(state.copyWith(status: ProductStatus.failure));
    }
  }
}
