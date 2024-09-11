import 'dart:convert';

import 'package:crud_app/models/product_response.dart';
import 'package:crud_app/services/product_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductService productService;

  ProductBloc(this.productService) : super(ProductInitial()) {
    on<FetchProducts>(_onFetchProducts);
    on<AddProduct>(_onAddProduct);
    on<DetailProduct>(_onDetailProduct);
    on<UpdateProduct>(_onUpdateProduct);
    on<DeleteProduct>(_onDeleteProduct);
  }

  void _onFetchProducts(FetchProducts event, Emitter<ProductState> emit) async {
    try {
      if (state is ProductLoaded && (state as ProductLoaded).hasReachedMax) return;
      emit(ProductLoading());
      final products = await productService.fetchProducts();
      final productList = List<ProductResponse>.from(
          products.map((product) => ProductResponse.fromJson(product))
      ).toList();
      emit(ProductLoaded(productList, hasReachedMax: products.isEmpty));
    } catch (e) {
      emit(ProductError('Failed to load products'));
    }
  }

  void _onDetailProduct(DetailProduct event, Emitter<ProductState> emit) async {
    try {
      if (state is ProductDetailSuccess) return;
      emit(ProductLoading());
      final products = await productService.detailProduct(event.id);
      final productList = ProductResponse.fromJson(jsonDecode(products));
      emit(ProductDetailSuccess(productList));
    } catch (e) {
      emit(ProductError('Failed to load products'));
    }
  }

  void _onAddProduct(AddProduct event, Emitter<ProductState> emit) async {
    emit(ProductLoading());

    try {
      final data = await productService.addProduct(event.product);
      ProductResponse response = ProductResponse.fromJson(jsonDecode(data));
      emit(ProductAddSuccess(response));
      add(FetchProducts());
    } catch (e) {
      emit(ProductError('Failed to add product'));
    }
  }

  void _onUpdateProduct(UpdateProduct event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    try {
      await productService.updateProduct(event.product);
      emit(ProductUpdatedSuccess());
      add(FetchProducts());
    } catch (e) {
      emit(ProductError('Failed to update product'));
    }
  }

  void _onDeleteProduct(DeleteProduct event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    try {
      await productService.deleteProduct(event.productId);
      emit(ProductDeletedSuccess());
      add(FetchProducts());
    } catch (e) {
      emit(ProductError('Failed to delete product'));
    }
  }
}