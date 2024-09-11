import 'package:crud_app/models/product_response.dart';
import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchProducts extends ProductEvent {

  FetchProducts();

  @override
  List<Object?> get props => [];
}

class DetailProduct extends ProductEvent {

  final String id;

  DetailProduct(this.id);

  @override
  List<Object?> get props => [id];
}

class AddProduct extends ProductEvent {
  final Map<String, dynamic> product;

  AddProduct(this.product);

  @override
  List<Object?> get props => [product];
}

class UpdateProduct extends ProductEvent {
  final Map<String, dynamic> product;

  UpdateProduct(this.product);

  @override
  List<Object?> get props => [product];
}

class DeleteProduct extends ProductEvent {
  final String productId;

  DeleteProduct(this.productId);

  @override
  List<Object?> get props => [productId];
}
