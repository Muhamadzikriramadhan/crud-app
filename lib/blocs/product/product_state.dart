import 'package:crud_app/models/product_response.dart';
import 'package:equatable/equatable.dart';

abstract class ProductState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<ProductResponse> products;
  final bool hasReachedMax;

  ProductLoaded(this.products, {this.hasReachedMax = false});

  ProductLoaded copyWith({
    List<ProductResponse>? products,
    bool? hasReachedMax,
  }) {
    return ProductLoaded(
      products ?? this.products,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props => [products, hasReachedMax];
}

class ProductError extends ProductState {
  final String message;

  ProductError(this.message);

  @override
  List<Object?> get props => [message];
}

class ProductAddSuccess extends ProductState {
  final ProductResponse response;

  ProductAddSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class ProductDetailSuccess extends ProductState {
  final ProductResponse response;

  ProductDetailSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class ProductUpdatedSuccess extends ProductState {

}
class ProductDeletedSuccess extends ProductState {

}

