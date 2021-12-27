part of 'product_bloc.dart';

enum ProductStatus { initial, success, failure }

class ProductState extends Equatable {
  const ProductState({
    this.status = ProductStatus.initial,
    this.products = const <Item>[],
    this.topProducts = const <Item>[],
    this.justDroppedProducts = const <Item>[],
    this.hasReachedMax = false,
  });

  final ProductStatus status;
  final List<Item> products;
  final List<Item> topProducts;
  final List<Item> justDroppedProducts;
  final bool hasReachedMax;

  ProductState copyWith({
    ProductStatus? status,
    List<Item>? products,
    List<Item>? topProducts,
    List<Item>? justDroppedProducts,
    bool? hasReachedMax,
  }) {
    return ProductState(
      status: status ?? this.status,
      products: products ?? this.products,
      topProducts: topProducts ?? this.topProducts,
      justDroppedProducts: justDroppedProducts ?? this.justDroppedProducts,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [
        status,
        products,
        topProducts,
        justDroppedProducts,
        hasReachedMax,
      ];
}
