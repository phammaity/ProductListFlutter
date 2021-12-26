part of 'product_bloc.dart';

enum ProductStatus { initial, success, failure }

class ProductState extends Equatable {
  const ProductState({
    this.status = ProductStatus.initial,
    this.products = const <Item>[],
    this.hasReachedMax = false,
  });

  final ProductStatus status;
  final List<Item> products;
  final bool hasReachedMax;

  ProductState copyWith({
    ProductStatus? status,
    List<Item>? products,
    bool? hasReachedMax,
  }) {
    return ProductState(
      status: status ?? this.status,
      products: products ?? this.products,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [status, products, hasReachedMax];
}
