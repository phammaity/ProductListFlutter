import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:api_repository/models/item.dart';
import 'package:api_repository/api_repository.dart';
part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(const ProductState()) {
    on<FetchProducts>(_onLocalProductFetched);
  }

  Future<List<Item>> _fetchProducts() async {
    final result = await ApiProvider.instance().fetchLocalItems();
    return result.items;
  }

  Future<void> _onLocalProductFetched(
      FetchProducts event, Emitter<ProductState> emit) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == ProductStatus.initial) {
        final products = await _fetchProducts();
        return emit(state.copyWith(
          status: ProductStatus.success,
          products: products,
          hasReachedMax: false,
        ));
      }
    } catch (_) {
      emit(state.copyWith(status: ProductStatus.failure));
    }
  }

  // Future<void> _onPostFetched(PostFetched event, Emitter<PostState> emit) async {
  //   if (state.hasReachedMax) return;
  //   try {
  //     if (state.status == PostStatus.initial) {
  //       final posts = await _fetchPosts();
  //       return emit(state.copyWith(
  //         status: PostStatus.success,
  //         posts: posts,
  //         hasReachedMax: false,
  //       ));
  //     }
  //     final posts = await _fetchPosts(state.posts.length);
  //     emit(posts.isEmpty
  //         ? state.copyWith(hasReachedMax: true)
  //         : state.copyWith(
  //       status: PostStatus.success,
  //       posts: List.of(state.posts)..addAll(posts),
  //       hasReachedMax: false,
  //     ));
  //   } catch (_) {
  //     emit(state.copyWith(status: PostStatus.failure));
  //   }
  // }
}
